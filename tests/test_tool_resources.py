import json
from types import SimpleNamespace
from unittest.mock import Mock

import pytest
from Tea.exceptions import TeaException

from tools import exceptions, resource


def test_ros_resource_retries_throttling_and_caches_response(monkeypatch):
    failure = TeaException({"code": "Throttling.User", "message": "slow down"})
    body = SimpleNamespace(properties={"Name": {}}, attributes={"Id": {}})
    client = SimpleNamespace(
        get_resource_type=Mock(side_effect=[failure, SimpleNamespace(body=body)])
    )
    monkeypatch.setattr(resource.time, "sleep", lambda seconds: None)
    item = resource.RosResource(client, "ALIYUN::ECS::Instance")
    assert item.properties() == {"Name": {}}
    assert item.attributes() == {"Id": {}}
    assert client.get_resource_type.call_count == 2


def test_ros_resource_propagates_non_throttling_errors():
    failure = TeaException({"code": "Forbidden", "message": "denied"})
    item = resource.RosResource(
        SimpleNamespace(get_resource_type=Mock(side_effect=failure)), "type"
    )
    with pytest.raises(TeaException):
        item.fetch()


def test_cloudformation_schema_resolves_types_and_read_only_attributes():
    schema = {
        "properties": {
            "Name": {"type": "string"},
            "Id": {"type": "string"},
            "Config": {
                "type": "object",
                "properties": {"Enabled": {"type": "boolean"}},
                "required": ["Enabled"],
            },
            "Items": {"type": "array", "items": {"type": "integer"}},
        },
        "required": ["Name"],
        "readOnlyProperties": ["/properties/Id"],
    }
    client = SimpleNamespace(
        describe_type=Mock(return_value={"Schema": json.dumps(schema)})
    )
    item = resource.CloudFormationResource(client, "AWS::Example::Resource")
    props = item.properties()
    assert props["Name"]["Required"] is True
    assert props["Config"]["Schema"]["Enabled"]["Required"] is True
    assert props["Items"]["Schema"]["*"]["Type"] == "integer"
    assert list(item.attributes()) == ["Id"]
    assert client.describe_type.call_count == 1


@pytest.mark.parametrize(
    ("types", "expected"),
    [
        (["null", "object"], "map"),
        (["null", "array"], "list"),
        (["null", "string"], "string"),
    ],
)
def test_cloudformation_union_type_selection(types, expected):
    item = resource.CloudFormationResource(None, "test")
    prop = {"type": types}
    if "array" in types:
        prop["items"] = {"type": "string"}
    item._handle_prop(prop)
    assert prop["Type"] == expected


def test_terraform_resource_reads_local_or_remote_go_and_invokes_asty(
    tmp_path, monkeypatch
):
    folder = tmp_path / "alicloud"
    folder.mkdir()
    (folder / "resource_alicloud_test.go").write_text("package example")
    monkeypatch.setenv("TERRAFORM_PROVIDER_ALICLOUD", str(tmp_path))
    item = resource.TerraformResource("alicloud_test")
    assert item.path_or_url()[1] == "path"

    def run(command, input, shell, stdout):
        assert input == b"package example"
        stdout.write(b'{"Decls": []}')
        return SimpleNamespace(returncode=0)

    monkeypatch.setattr(resource, "run", run)
    assert item.ast == {"Decls": []}
    monkeypatch.delenv("TERRAFORM_PROVIDER_ALICLOUD")
    assert item.path_or_url()[1] == "url"
    monkeypatch.setattr(
        resource.requests,
        "get",
        lambda url: SimpleNamespace(status_code=404, text="not found"),
    )
    with pytest.raises(exceptions.RosToolWarning, match="not found"):
        item.fetch()


def test_terraform_parses_property_types_nested_schema_and_tags(monkeypatch):
    item = resource.TerraformResource("alicloud_test")
    item.path_or_url = lambda: ("resource.go", "path")

    def type_field(name):
        return {"Key": {"Name": "Type"}, "Value": {"Sel": {"Name": name}}}

    optional = {"Key": {"Name": "Optional"}, "Value": {"Name": "false"}}
    leaf = {"NodeType": "CompositeLit", "Elts": [type_field("TypeString"), optional]}
    assert item._get_property_schema(leaf, "name") == {
        "Type": "string",
        "Required": False,
    }
    schema = {
        "Elts": [
            {"Key": {"Value": '"name"'}, "Value": leaf},
            {"Key": {"Value": '"tags"'}, "Value": {"NodeType": "CallExpr"}},
        ]
    }
    result = item._get_properties_schema(schema)
    assert result["name"]["Type"] == "string"
    assert result["tags"] == item.DEFAULT_TAGS_SCHEMA
    schema["Elts"][1]["Key"]["Value"] = '"unknown"'
    with pytest.raises(ValueError, match="resource.go"):
        item._get_properties_schema(schema)


def test_terraform_attribute_walker_finds_nested_set_calls():
    item = resource.TerraformResource("alicloud_test")
    call = {
        "X": {
            "Fun": item.AST_D_SET_FUNC,
            "Args": [{"Kind": "STRING", "Value": '"instance_id"'}],
        }
    }
    item._ast = {
        "Decls": [
            {
                "NodeType": "FuncDecl",
                "Type": {"NodeType": "FuncType"},
                "Body": {"NodeType": "BlockStmt", "List": [call]},
            }
        ]
    }
    assert item.attributes() == {"instance_id": {}}
    assert item._find_ast_resource({}) is None
    assert item._find_ast_schema(None) is None


def test_ros_resource_gives_up_after_four_throttling_errors(monkeypatch):
    failure = TeaException({"code": "Throttling.User", "message": "slow"})
    client = SimpleNamespace(get_resource_type=Mock(side_effect=failure))
    monkeypatch.setattr(resource.time, "sleep", lambda seconds: None)
    with pytest.raises(TeaException):
        resource.RosResource(client, "type").fetch()
    assert client.get_resource_type.call_count == 4


def test_terraform_resource_reports_asty_failure(monkeypatch):
    item = resource.TerraformResource("alicloud_test")
    monkeypatch.delenv("TERRAFORM_PROVIDER_ALICLOUD", raising=False)
    monkeypatch.setattr(
        resource.requests,
        "get",
        lambda url: SimpleNamespace(status_code=200, text="source"),
    )
    monkeypatch.setattr(
        resource,
        "run",
        lambda *args, **kwargs: SimpleNamespace(
            returncode=1, args="asty", stderr=b"bad source"
        ),
    )
    with pytest.raises(exceptions.RosToolWarning, match="bad source"):
        item.fetch()


def test_terraform_finds_resource_schema_in_ast():
    cls = resource.TerraformResource
    schema = {
        "NodeType": "CompositeLit",
        "Type": {"Value": cls.AST_SCHEMA_TYPE},
        "Elts": [],
    }
    resource_node = {
        "Type": cls.AST_RESOURCE_TYPE,
        "Elts": [{"NodeType": "Ident"}, {"NodeType": "KeyValueExpr", "Value": schema}],
    }
    ast = {
        "Decls": [
            {"NodeType": "Other"},
            {
                "NodeType": "FuncDecl",
                "Type": {
                    "NodeType": "FuncType",
                    "Results": {
                        "NodeType": "FieldList",
                        "List": [{"Type": cls.AST_FUNC_RETURN}],
                    },
                },
                "Body": {
                    "List": [
                        {"NodeType": "ReturnStmt", "Results": [{"X": resource_node}]}
                    ]
                },
            },
        ]
    }
    assert cls._find_ast_resource(ast) == resource_node
    assert cls._find_ast_schema(resource_node) == schema


def test_terraform_nested_schema_and_recursive_attributes():
    item = resource.TerraformResource("alicloud_test")
    nested = {
        "NodeType": "CompositeLit",
        "Type": {"Sel": {"Name": "Schema"}},
        "Elts": [{"Key": {"Name": "Type"}, "Value": {"Sel": {"Name": "TypeString"}}}],
    }
    prop = {
        "NodeType": "CompositeLit",
        "Elts": [
            {"Key": {"Name": "Type"}, "Value": {"Sel": {"Name": "TypeList"}}},
            {
                "Key": {"Name": "Elem"},
                "Value": {"NodeType": "UnaryExpr", "Op": "&", "X": nested},
            },
        ],
    }
    assert item._get_property_schema(prop, "items")["Schema"]["*"]["Type"] == "string"
    attrs = {}
    call = {
        "X": {"Fun": item.AST_D_SET_FUNC, "Args": [{"Kind": "STRING", "Value": '"id"'}]}
    }
    item._fetch_attributes({"other": [{"nested": [call]}]}, attrs)
    assert attrs == {"id": {}}


def test_cloudformation_without_readonly_properties():
    schema = {"properties": {"Choice": {"type": "string"}}}
    item = resource.CloudFormationResource(
        SimpleNamespace(
            describe_type=Mock(return_value={"Schema": json.dumps(schema)})
        ),
        "AWS::Test",
    )
    assert item.properties()["Choice"]["Type"] == "string"
    assert item.attributes() == {}


def test_terraform_ast_walkers_skip_unrelated_declarations():
    cls = resource.TerraformResource
    item = cls("alicloud_test")
    item._ast = {"Decls": []}
    assert item.attributes() is None
    item._ast = {
        "Decls": [
            {"NodeType": "Other"},
            {"NodeType": "FuncDecl", "Type": {"NodeType": "Other"}},
            {
                "NodeType": "FuncDecl",
                "Type": {"NodeType": "FuncType"},
                "Body": {"NodeType": "Other"},
            },
        ]
    }
    assert item.attributes() == {}
    invalid_returns = {
        "Decls": [
            {"NodeType": "Other"},
            {"NodeType": "FuncDecl", "Type": {"NodeType": "Other"}},
            {
                "NodeType": "FuncDecl",
                "Type": {"NodeType": "FuncType", "Results": {"NodeType": "Other"}},
            },
            {
                "NodeType": "FuncDecl",
                "Type": {
                    "NodeType": "FuncType",
                    "Results": {
                        "NodeType": "FieldList",
                        "List": [{"Type": "unexpected"}],
                    },
                },
                "Body": {
                    "List": [
                        {"NodeType": "Other"},
                        {"NodeType": "ReturnStmt", "Results": [{}]},
                    ]
                },
            },
        ]
    }
    assert cls._find_ast_resource(invalid_returns) is None
    assert (
        cls._find_ast_schema(
            {
                "Elts": [
                    {"NodeType": "Other"},
                    {"NodeType": "KeyValueExpr", "Value": {"NodeType": "Other"}},
                ]
            }
        )
        is None
    )


def test_terraform_nested_resource_schema_and_empty_walker_inputs():
    item = resource.TerraformResource("alicloud_test")
    leaf = {
        "NodeType": "CompositeLit",
        "Elts": [{"Key": {"Name": "Type"}, "Value": {"Sel": {"Name": "TypeBool"}}}],
    }
    nested_schema = {"Elts": [{"Key": {"Value": '"enabled"'}, "Value": leaf}]}
    nested_resource = {
        "NodeType": "CompositeLit",
        "Type": {"Sel": {"Name": "Resource"}},
        "Elts": [{"Value": nested_schema}],
    }
    prop = {
        "NodeType": "CompositeLit",
        "Elts": [
            {"Key": {"Name": "Type"}, "Value": {"Sel": {"Name": "TypeList"}}},
            {
                "Key": {"Name": "Elem"},
                "Value": {"NodeType": "UnaryExpr", "Op": "&", "X": nested_resource},
            },
        ],
    }
    result = item._get_property_schema(prop, "items")
    assert result["Schema"]["*"]["Schema"]["enabled"]["Type"] == "boolean"
    assert item._get_properties_schema(None) == {}
    attrs = {}
    item._fetch_attributes({"X": {"Fun": item.AST_D_SET_FUNC, "Args": []}}, attrs)
    item._fetch_attributes(
        {"X": {"Fun": item.AST_D_SET_FUNC, "Args": [{"Kind": "INT"}]}}, attrs
    )
    assert attrs == {}


def test_ros_resource_allows_an_empty_response_without_caching():
    client = SimpleNamespace(get_resource_type=Mock(return_value=None))
    item = resource.RosResource(client, "type")
    item.fetch()
    assert item._rt_info is None
