import json
import os

import pytest

pytest.importorskip("fastapi")
from fastapi.testclient import TestClient  # noqa: E402

from rostran.core.format import (  # noqa: E402
    SourceTemplateFormat,
    TargetTemplateFormat,
)
from rostran.web.server import build_app  # noqa: E402
from rostran.web import service  # noqa: E402


CFN_TEMPLATE = json.dumps(
    {
        "AWSTemplateFormatVersion": "2010-09-09",
        "Description": "test",
        "Resources": {
            "Vpc": {
                "Type": "AWS::EC2::VPC",
                "Properties": {"CidrBlock": "192.168.0.0/16"},
            }
        },
    }
)

ROS_TEMPLATE = (
    "ROSTemplateFormatVersion: '2015-09-01'\n"
    "Description: test\n"
    "Resources:\n"
    "  Vpc:\n"
    "    Type: ALIYUN::ECS::VPC\n"
    "    Properties:\n"
    "      CidrBlock: 192.168.0.0/16\n"
)


@pytest.fixture
def client():
    return TestClient(build_app())


def test_meta(client):
    resp = client.get("/api/meta")
    assert resp.status_code == 200
    data = resp.json()
    assert "version" in data
    assert "cloudformation" in data["source_formats"]
    assert "terraform/alicloud" in data["rules_classifiers"]


def test_health(client):
    assert client.get("/api/health").json() == {"status": "ok"}


def test_transform_cloudformation_to_ros(client):
    resp = client.post(
        "/api/transform",
        data={"source_format": "cloudformation", "target_format": "yaml"},
        files={"files": ("vpc.json", CFN_TEMPLATE, "application/json")},
    )
    assert resp.status_code == 200, resp.text
    data = resp.json()
    assert data["targets"], data
    content = data["targets"][0]["content"]
    assert "ROSTemplateFormatVersion" in content
    assert "ALIYUN::ECS::VPC" in content


def test_transform_stream_emits_log_and_result(client):
    with client.stream(
        "POST",
        "/api/transform/stream",
        data={"source_format": "cloudformation", "target_format": "yaml"},
        files={"files": ("vpc.json", CFN_TEMPLATE, "application/json")},
    ) as resp:
        assert resp.status_code == 200
        assert "text/event-stream" in resp.headers["content-type"]
        body = "".join(resp.iter_text())

    assert "event: log" in body
    assert "event: result" in body
    # The final result event carries the transformed template.
    events = body.split("\n\n")
    result_event = [e for e in events if "event: result" in e][0]
    data = json.loads(result_event.splitlines()[1][len("data: ") :])
    assert data["targets"][0]["content"].count("ROSTemplateFormatVersion") == 1
    assert "ALIYUN::ECS::VPC" in data["targets"][0]["content"]


def test_transform_stream_error_event(client):
    with client.stream(
        "POST",
        "/api/transform/stream",
        data={"source_format": "bogus"},
        files={"files": ("x.json", "{}", "application/json")},
    ) as resp:
        assert resp.status_code == 200
        body = "".join(resp.iter_text())
    assert "event: error" in body


def test_transform_invalid_source_format(client):
    resp = client.post(
        "/api/transform",
        data={"source_format": "nope"},
        files={"files": ("x.json", "{}", "application/json")},
    )
    assert resp.status_code == 400
    assert resp.json()["error"]["type"] == "InvalidRequest"


def test_format_endpoint(client):
    resp = client.post(
        "/api/format",
        data={"content": ROS_TEMPLATE, "format": "yaml"},
    )
    assert resp.status_code == 200, resp.text
    assert "ROSTemplateFormatVersion" in resp.json()["content"]


def test_format_invalid(client):
    resp = client.post(
        "/api/format",
        data={"content": "{ not valid", "format": "json"},
    )
    assert resp.status_code == 422


def test_examples_list_and_get(client):
    resp = client.get("/api/examples")
    assert resp.status_code == 200
    examples = resp.json()["examples"]
    assert any(e["id"] == "cloudformation-vpc" for e in examples)
    # content omitted in list
    assert all("content" not in e for e in examples)

    resp = client.get("/api/examples/cloudformation-vpc")
    assert resp.status_code == 200
    assert "content" in resp.json()

    assert client.get("/api/examples/missing").status_code == 404


def test_rules_classifiers(client):
    resp = client.get("/api/rules/classifiers")
    assert resp.status_code == 200
    assert "cloudformation" in resp.json()["classifiers"]


def test_service_transform_no_files():
    with pytest.raises(service.TransformError):
        service.transform(files=[], source_format=None)  # type: ignore[arg-type]


def test_ros_to_terraform_without_credentials():
    """ROS -> Terraform must work without Alibaba Cloud credentials by skipping
    the validation API call (which would otherwise raise), and must run cleanly
    in a worker thread (no `signal only works in main thread` error)."""
    import concurrent.futures

    ros = (
        "ROSTemplateFormatVersion: '2015-09-01'\n"
        "Resources:\n"
        "  SG:\n"
        "    Type: ALIYUN::ECS::SecurityGroup\n"
        "    Properties:\n"
        "      VpcId: vpc-x\n"
    )

    def run():
        return service.transform(
            files=[("template.yml", ros.encode())],
            source_format=SourceTemplateFormat.ROS,
            target_format=TargetTemplateFormat.Auto,
        )

    with concurrent.futures.ThreadPoolExecutor() as ex:
        result = ex.submit(run).result()

    assert any(t.filename.endswith(".tf") for t in result.targets)


def test_transform_runs_off_the_event_loop(monkeypatch, client):
    """The synchronous (and potentially slow) transform must be offloaded to a
    worker thread so it never blocks the event loop. A worker thread has no
    running asyncio loop, whereas code executed inline inside the async endpoint
    would. This deterministically catches a regression to inline execution."""
    import asyncio

    captured = {}

    def record_transform(*_args, **_kwargs):
        try:
            asyncio.get_running_loop()
            captured["on_event_loop"] = True
        except RuntimeError:
            captured["on_event_loop"] = False
        return service.TransformResult(
            targets=[service.TargetFile("template.yml", "ok: true\n")],
            log="",
        )

    monkeypatch.setattr(service, "transform", record_transform)

    resp = client.post(
        "/api/transform",
        data={"source_format": "cloudformation"},
        files={"files": ("a.json", "{}", "application/json")},
    )
    assert resp.status_code == 200, resp.text
    assert captured.get("on_event_loop") is False, (
        "transform ran on the event loop thread; it must be offloaded"
    )


def test_transform_runs_in_subprocess():
    """Transforms run out-of-process so libterraform / native crashes / chdir
    stay isolated from the server. The conversion still works end to end."""
    cfn = '{"AWSTemplateFormatVersion":"2010-09-09","Resources":{"Vpc":{"Type":"AWS::EC2::VPC","Properties":{"CidrBlock":"192.168.0.0/16"}}}}'
    before = os.getcwd()
    res = service.transform(
        files=[("vpc.json", cfn.encode())],
        source_format=SourceTemplateFormat.CloudFormation,
        target_format=TargetTemplateFormat.Yaml,
    )
    assert any("ALIYUN::ECS::VPC" in t.content for t in res.targets)
    # The server process working directory is untouched by the child.
    assert os.getcwd() == before
    # Internal temp paths / save notices are scrubbed from the log.
    assert "Save template to" not in res.log
