import re
import json
import logging

import yaml
import requests
import markdown
import typer

from bs4 import BeautifulSoup
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkros.request.v20190910.GetResourceTypeRequest import GetResourceTypeRequest

logger = logging.getLogger(__name__)


def tf_properties_attrs(md: str):
    html = markdown.markdown(md)
    soup = BeautifulSoup(html, features="lxml")
    h2 = soup.find_all("h2")

    attrs = []
    properties = {}
    for i in h2:
        if i.string == "Attributes Reference":
            try:
                li_list = (
                    i.next_sibling.next_sibling.next_sibling.next_sibling.find_all("li")
                )
            except AttributeError:
                li_list = i.next_sibling.next_sibling.find_all("li")

            for li in li_list:
                arg = li.find_all("code")[0].string
                if ":" not in arg:
                    attrs.append(arg)
        if i.string == "Argument Reference":
            li_list = i.next_sibling.next_sibling.next_sibling.next_sibling.find_all(
                "li"
            )
            for li in li_list:
                arg = li.find_all("code")[0].string
                if ":" not in arg:
                    properties[arg] = {}

    return properties, attrs


def handle_sub_properties(
    tf_resource: str, go_content: str, properties: dict, tail_1=None, tail_2=None
):
    params = dict()
    go_content = go_content.split("\n")
    for line in go_content:
        if '": {' in line:
            tab = line.count("\t")
            param = re.findall(r'"(.*?)": ', line)[0]
            if tab == 3:
                params[param] = {}
                tail_1 = param
            elif tab == 6:
                params[tail_1][param] = {}
                tail_2 = param
            elif tab == 9:
                params[tail_1][tail_2][param] = {}
            else:
                logger.warning(
                    f"{tf_resource}[{tail_2}]Level 4 sub-attributes - {param}"
                )

    for k in params:
        if params[k]:
            properties[k] = params[k]
    return properties


def handle_ros(ak: str, sk: str, resource_type: str):
    client = AcsClient(ak, sk, "cn-hangzhou")
    request = GetResourceTypeRequest()
    request.set_accept_format("json")

    request.set_ResourceType(resource_type)

    try:
        response = client.do_action_with_exception(request)
    except ServerException as e:
        typer.secho(e.message, fg=typer.colors.YELLOW)
        exit(1)

    res_dict = json.loads(response, encoding="utf-8")

    ret = dict()

    ret["ResourceType"] = res_dict["ResourceType"]

    ret["Attributes"] = list(res_dict.get("Attributes").keys())
    properties = res_dict["Properties"]

    def get_pro(propers: dict, r: dict, ros_type: str = None):
        if ros_type:
            r["RosType"] = ros_type
        for k in propers:
            r[k] = {}
            if propers[k]["Type"] in ("string", "integer", "number", "boolean"):
                pass
            elif propers[k]["Type"] == "map":
                try:
                    get_pro(propers[k]["Schema"], r[k], ros_type="Map")
                except KeyError:
                    pass
            elif propers[k]["Type"] == "list":
                try:
                    get_pro(
                        propers[k]["Schema"]["*"].get("Schema"), r[k], ros_type="List"
                    )
                except KeyError:
                    pass

        return r

    ret["Properties"] = get_pro(properties, {})
    return ret


def parse_attrs(tf_attr: list, ros_attr: dict):
    attrs = {}
    for attr in tf_attr:
        trans_attr = "".join([i.title() for i in attr.split("_")])
        if trans_attr in ros_attr:
            attrs[attr] = {"To": trans_attr}
        else:
            attrs[attr] = {"Ignore": True}
    return attrs


def parse_properties(
    tf_resource_type: str, tf_params: dict, ros_params: dict, ret: dict = {}
):
    for param in tf_params:
        trans_param = "".join([i.title() for i in param.split("_")])

        tf_resource_suffix = tf_resource_type.split("_")[-1].title()
        if tf_params[param] == {}:
            if ros_params.get(trans_param) == {}:
                ret[param] = {"To": trans_param}
                continue
            elif ros_params.get(f"{tf_resource_suffix}{trans_param}") == {}:
                ret[param] = {"To": f"{tf_resource_suffix}{trans_param}"}

            else:
                ret[param] = {"Ignore": True}
        else:
            if ros_params.get(trans_param):
                if (
                    "RosType" in ros_params[trans_param]
                    and len(ros_params[trans_param]) > 1
                ):
                    ros_type = ros_params[trans_param].pop("RosType")

                    r = parse_properties(
                        "", tf_params[param], ros_params[trans_param], {}
                    )
                    ret[param] = {"To": trans_param, "Type": ros_type, "Schema": r}
                else:
                    ret[param] = {"Ignore": True}
            else:
                ret[param] = {"Ignore": True}
    return ret


def parse_tf_ros(
    ak: str, sk: str, ros_resource: str, tf_resource: str, target_path: str
):
    logger.info("Parse Terraform and ROS resource type...")
    # tf
    r_link = (
        f"https://raw.githubusercontent.com/aliyun/terraform-provider-alicloud/master/website/docs/r/"
        f'{tf_resource.replace("alicloud_", "")}.html.markdown'
    )
    go_link = f"https://raw.githubusercontent.com/aliyun/terraform-provider-alicloud/master/alicloud/resource_{tf_resource}.go"

    r_content = requests.get(r_link).text
    go_content = requests.get(go_link).text

    properties, attrs = tf_properties_attrs(r_content)
    properties = handle_sub_properties(tf_resource, go_content, properties)

    # ros
    ros_res = handle_ros(ak, sk, ros_resource)

    # parse
    result = dict(
        {
            "Version": "2020-06-01",
            "Type": "Resource",
            "ResourceType": {"From": tf_resource, "To": ros_resource},
            "Properties": {},
            "Attributes": {},
        }
    )

    result["Attributes"] = parse_attrs(attrs, ros_res["Attributes"])
    result["Properties"] = parse_properties(
        tf_resource, properties, ros_res["Properties"], {}
    )

    result = json.loads(json.dumps(result))
    result = yaml.dump(result)
    with open(target_path, "w", encoding="utf8") as f:
        f.write(result)
    typer.secho(f"Write result in {target_path}", fg=typer.colors.RED)
