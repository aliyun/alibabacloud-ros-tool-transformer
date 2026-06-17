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


def test_transform_restores_cwd_between_calls(monkeypatch):
    """libterraform changes the process cwd via terraform's -chdir; the service
    must restore it so a later transform (e.g. a second Terraform run) does not
    fail on os.getcwd() once the previous temp dir is gone."""
    import rostran.cli.__main__ as cli

    def fake_transform(*, source_path, target_path, **_kwargs):
        # Simulate libterraform chdir-ing into the per-request temp dir.
        os.chdir(os.path.dirname(source_path))
        with open(target_path, "w") as f:
            f.write("ROSTemplateFormatVersion: '2015-09-01'\n")

    monkeypatch.setattr(cli, "transform", fake_transform)

    before = os.getcwd()
    res1 = service.transform(
        files=[("t.json", b"{}")],
        source_format=SourceTemplateFormat.CloudFormation,
        target_format=TargetTemplateFormat.Yaml,
    )
    assert res1.targets
    # Working directory restored and still valid after the temp dir is removed.
    assert os.getcwd() == before

    # A second transform must succeed rather than raising FileNotFoundError.
    res2 = service.transform(
        files=[("t.json", b"{}")],
        source_format=SourceTemplateFormat.CloudFormation,
        target_format=TargetTemplateFormat.Yaml,
    )
    assert res2.targets
    assert os.getcwd() == before


def test_transform_recovers_from_corrupted_cwd(monkeypatch):
    """If the process is already sitting in a deleted directory (e.g. a prior
    terraform run left it there), the service must recover rather than fail
    forever on os.getcwd()."""
    import tempfile

    import rostran.cli.__main__ as cli

    def fake_transform(*, target_path, **_kwargs):
        with open(target_path, "w") as f:
            f.write("ROSTemplateFormatVersion: '2015-09-01'\n")

    monkeypatch.setattr(cli, "transform", fake_transform)

    original = os.getcwd()
    doomed = tempfile.mkdtemp()
    os.chdir(doomed)
    os.rmdir(doomed)  # cwd now points at a directory that no longer exists
    try:
        with pytest.raises(OSError):
            os.getcwd()  # confirm the process cwd is genuinely broken

        res = service.transform(
            files=[("t.json", b"{}")],
            source_format=SourceTemplateFormat.CloudFormation,
            target_format=TargetTemplateFormat.Yaml,
        )
        assert res.targets
        # cwd is valid again afterwards.
        assert os.getcwd()
    finally:
        os.chdir(original)
