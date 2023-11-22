import json
import os
from subprocess import run
from tempfile import NamedTemporaryFile

import requests
import jsonref
from alibabacloud_ros20190910 import models as ros_models
from alibabacloud_ros20190910.client import Client as RosClient

from tools import exceptions


class RosResource:
    def __init__(self, client: RosClient, resource_type: str):
        self.resource_type = resource_type
        self.client = client
        self._rt_info = None

    def fetch(self):
        req = ros_models.GetResourceTypeRequest(self.resource_type)
        resp = self.client.get_resource_type(req)
        self._rt_info = resp.body

    @property
    def rt_info(self) -> ros_models.GetResourceTypeResponseBody:
        if not self._rt_info:
            self.fetch()
        return self._rt_info

    def properties(self):
        return self.rt_info.properties

    def attributes(self):
        return self.rt_info.attributes


class TerraformResource:
    ALICLOUD_SRC_URL = "https://raw.githubusercontent.com/aliyun/terraform-provider-alicloud/master/alicloud/resource_{}.go"
    AST_FUNC_RETURN = {
        "NodeType": "StarExpr",
        "X": {
            "NodeType": "SelectorExpr",
            "X": {"NodeType": "Ident", "Name": "schema"},
            "Sel": {"NodeType": "Ident", "Name": "Resource"},
        },
    }
    AST_RESOURCE_TYPE = {
        "NodeType": "SelectorExpr",
        "X": {"NodeType": "Ident", "Name": "schema"},
        "Sel": {"NodeType": "Ident", "Name": "Resource"},
    }
    AST_SCHEMA_TYPE = {
        "NodeType": "StarExpr",
        "X": {
            "NodeType": "SelectorExpr",
            "X": {"NodeType": "Ident", "Name": "schema"},
            "Sel": {"NodeType": "Ident", "Name": "Schema"},
        },
    }
    AST_D_SET_FUNC = {
        "NodeType": "SelectorExpr",
        "X": {"NodeType": "Ident", "Name": "d"},
        "Sel": {"NodeType": "Ident", "Name": "Set"},
    }
    TYPE_MAPPING = {
        "TypeString": "string",
        "TypeBool": "boolean",
        "TypeSet": "list",
        "TypeList": "list",
        "TypeInt": "integer",
        "TypeFloat": "number",
        "TypeMap": "map",
    }
    KEYS_USING_DEFAULT_TAGS_SCHEMA = ("tags", "volume_tags", "template_tags")
    DEFAULT_TAGS_SCHEMA = {
        "Handler": "tags_dict_to_list"
        # 'Type': 'list',
        # 'Schema': {
        #     '*': {
        #         "Type": "map",
        #         "Required": False,
        #         "Schema": {
        #             "Value": {
        #                 "Type": "string",
        #                 "Required": False,
        #             },
        #             "Key": {
        #                 "Type": "string",
        #                 "Required": True,
        #             }
        #         },
        #     }
        # }
    }

    def __init__(self, resource_type: str, resource_filename: str = None):
        self.resource_type = resource_type
        self.resource_filename = resource_filename or resource_type
        self._ast = None

    def path_or_url(self):
        alicloud_local = os.getenv("TERRAFORM_PROVIDER_ALICLOUD")
        if alicloud_local:
            path = os.path.join(
                alicloud_local, "alicloud", f"resource_{self.resource_filename}.go"
            )
            return path, "path"
        url = self.ALICLOUD_SRC_URL.format(self.resource_filename)
        return url, "url"

    def fetch(self):
        path_or_url, t = self.path_or_url()
        if t == "path":
            with open(path_or_url) as f:
                code = f.read().encode("utf-8")
        else:
            resp = requests.get(path_or_url)
            if resp.status_code != 200:
                raise exceptions.RosToolWarning(
                    message=f"Cannot fetch {path_or_url}. Reason: {resp.text}"
                )
            code = resp.text.encode("utf-8")

        with NamedTemporaryFile() as f:
            p = run("asty go2json", input=code, shell=True, stdout=f)
            if p.returncode != 0:
                raise exceptions.RosToolWarning(
                    message=f'Run `{p.args}` failed. Reason: {p.stderr.decode("utf-8")}'
                )
            f.seek(0)
            self._ast = json.loads(f.read())

    @property
    def ast(self):
        if not self._ast:
            self.fetch()
        return self._ast

    def properties(self):
        ast_resource = self._find_ast_resource(self.ast)
        ast_schema = self._find_ast_schema(ast_resource)
        properties = self._get_properties_schema(ast_schema)
        return properties

    def attributes(self):
        decls = self.ast.get("Decls")
        if not decls:
            return

        attributes = {}
        for decl in decls:
            if decl["NodeType"] != "FuncDecl":
                continue
            decl_type = decl["Type"]
            if decl_type["NodeType"] != "FuncType":
                continue
            body = decl["Body"]
            if body["NodeType"] != "BlockStmt":
                continue
            self._fetch_attributes(body["List"], attributes)
        return attributes

    @classmethod
    def _fetch_attributes(cls, block, attributes):
        if isinstance(block, dict):
            x = block.get("X")
            if x and x.get("Fun") == cls.AST_D_SET_FUNC:
                args = x["Args"]
                if args and args[0]["Kind"] == "STRING":
                    attr_name = args[0]["Value"].strip('"')
                    attributes[attr_name] = {}
            else:
                for val in block.values():
                    cls._fetch_attributes(val, attributes)
        elif isinstance(block, list):
            for val in block:
                cls._fetch_attributes(val, attributes)

    @classmethod
    def _find_ast_resource(cls, ast):
        decls = ast.get("Decls")
        if not decls:
            return

        for decl in decls:
            if decl["NodeType"] != "FuncDecl":
                continue
            decl_type = decl["Type"]
            if decl_type["NodeType"] != "FuncType":
                continue
            if decl_type["Results"]["NodeType"] != "FieldList":
                continue
            for result in decl_type["Results"]["List"]:
                if result["Type"] != cls.AST_FUNC_RETURN:
                    continue
            for block in decl["Body"]["List"]:
                if block["NodeType"] != "ReturnStmt":
                    continue
                for result in block["Results"]:
                    x = result.get("X")
                    if x and x["Type"] == cls.AST_RESOURCE_TYPE:
                        return x

    @classmethod
    def _find_ast_schema(cls, ast_resource):
        if not ast_resource:
            return

        for elt in ast_resource["Elts"]:
            if elt["NodeType"] != "KeyValueExpr":
                continue
            elt_value = elt["Value"]
            if (
                elt_value["NodeType"] == "CompositeLit"
                and elt_value["Type"]["Value"] == cls.AST_SCHEMA_TYPE
            ):
                return elt_value

    def _get_properties_schema(self, ast_schema, prop_path=""):
        if not ast_schema:
            return {}

        properties_schema = {}
        for elt in ast_schema["Elts"]:
            prop_name = eval(elt["Key"]["Value"])
            new_prop_path = f"{prop_path}.{prop_name}" if prop_path else prop_name
            try:
                prop = self._get_property_schema(elt["Value"], new_prop_path)
            except ValueError as e:
                if prop_name in self.KEYS_USING_DEFAULT_TAGS_SCHEMA:
                    prop = self.DEFAULT_TAGS_SCHEMA
                else:
                    path_or_url, t = self.path_or_url()
                    raise ValueError(f"{e}. Path: {path_or_url}")
            properties_schema[prop_name] = prop

        return properties_schema

    def _get_property_schema(self, ast_prop, path):
        if ast_prop["NodeType"] == "CallExpr":
            path_or_url, t = self.path_or_url()
            raise ValueError(
                f'Found function call in schema "{path}", not supported. Path: {path_or_url}'
            )

        prop = {"Required": True}
        for elt in ast_prop["Elts"]:
            elt_key_name = elt["Key"]["Name"]
            elt_value = elt["Value"]
            if elt_key_name == "Type":
                prop["Type"] = self.TYPE_MAPPING[elt_value["Sel"]["Name"]]
            elif elt_key_name == "Optional":
                prop["Required"] = elt_value["Name"] == '"True"'
            elif elt_key_name == "Elem":
                node_type = elt_value["NodeType"]
                if node_type == "UnaryExpr":
                    if elt_value["Op"] == "&":
                        x = elt_value["X"]
                        x_name = x["Type"]["Sel"]["Name"]
                        new_prop_path = f"{path}.*"
                        if x_name == "Schema":
                            sub_prop = self._get_property_schema(x, new_prop_path)
                            prop["Schema"] = {"*": sub_prop}
                        elif x_name == "Resource":
                            sub_props = self._get_properties_schema(
                                x["Elts"][0]["Value"], new_prop_path
                            )
                            prop["Schema"] = {
                                "*": {
                                    "Required": False,
                                    "Type": "map",
                                    "Schema": sub_props,
                                }
                            }

        return prop


class CloudFormationResource:
    def __init__(self, client, resource_type: str):
        self.client = client
        self.resource_type = resource_type
        self._rt_info = None
        self._schema = None

    def fetch(self):
        resp = self.client.describe_type(
            Type="RESOURCE",
            TypeName=self.resource_type,
        )
        self._rt_info = resp

    @property
    def rt_info(self) -> dict:
        if not self._rt_info:
            self.fetch()
        return self._rt_info

    @property
    def schema(self) -> dict:
        if not self._schema:
            s = self.rt_info["Schema"]
            # remove resource-schema.json due to can not resolve
            s = s.replace("resource-schema.json#", "#")
            self._schema = jsonref.loads(s, proxies=False, lazy_load=False)
            self._schema["type"] = "object"
            self._handle_prop(self._schema)
        return self._schema

    def properties(self):
        return self._get_props(read_only=False)

    def attributes(self):
        return self._get_props(read_only=True)

    def _get_props(self, read_only=False):
        properties = self.schema["Properties"]
        read_only_properties = self.schema.get("ReadOnlyProperties")
        if read_only_properties:
            read_only_names = set(
                n.replace("/properties/", "") for n in read_only_properties
            )
        else:
            read_only_names = set()

        if read_only:
            props = {n: properties[n] for n in properties if n in read_only_names}
        else:
            props = {n: properties[n] for n in properties if n not in read_only_names}
        return props

    def _handle_props(self, props: dict, required_names: list = None):
        for name, prop in props.items():
            if required_names and name in required_names:
                prop["Required"] = True
            else:
                prop["Required"] = False
            self._handle_prop(prop)

    def _handle_prop(self, prop: dict):
        for k in list(prop):
            if k == "required" and prop.get("type") == "object":
                nk = ".RequiredList"
            else:
                nk = "{}{}".format(k[0].upper(), k[1:])
            prop[nk] = prop.pop(k)

        t = prop.get("Type")
        if isinstance(t, list):
            if "object" in t:
                t = "object"
            elif "array" in t:
                t = "array"
            else:
                t = t[-1]
            prop["Type"] = t

        if t == "array":
            prop["Type"] = "list"
            item_schema = prop.get("Items")
            self._handle_prop(item_schema)
            prop["Schema"] = {"*": item_schema}
        elif t == "object":
            prop["Type"] = "map"
            props = prop.get("Properties")
            if props:
                required_names = prop.pop(".RequiredList", None)
                self._handle_props(props, required_names)
                prop["Schema"] = props
        elif not t and "oneof" in prop:
            for each_prop in prop["oneof"]:
                self._handle_prop(each_prop)
