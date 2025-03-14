import os


from alibabacloud_tea_openapi import models as open_api_models
from alibabacloud_ros20190910.client import Client
from alibabacloud_credentials.client import Client as CredClient
from alibabacloud_ros20190910 import models
from libterraform import TerraformCommand
from libterraform.exceptions import TerraformCommandError

from rostran.core import RosTemplate
from rostran.core.exceptions import RosTranException
from rostran.core.rule_manager import RuleManager, RuleClassifier
from rostran.providers.ros.template import ROS2TerraformTemplate
from rostran.providers.ros.yaml_util import yaml


class RosPlugin:

    def __init__(self):
        self.ros_client = Client(
            open_api_models.Config(credential=CredClient())
        )

    def list_resource_types(self):
        request = models.ListResourceTypesRequest(entity_type="Resource", provider="ROS")
        response = self.ros_client.list_resource_types(request)
        return response.to_map()

    def get_resource_template(self, resource_type: str) -> dict:
        request = models.GetResourceTypeTemplateRequest(resource_type=resource_type)
        response = self.ros_client.get_resource_type_template(request)
        ret = response.to_map()
        return ret['body']['TemplateBody']


def get_supported_resource_types():
    res_rules = RuleManager.initialize(RuleClassifier.ROS).resource_rules
    supported_resources = res_rules.keys()
    return tuple(supported_resources)


def _test_all_resource_types(resource_type: str = None):
    ros_plugin = RosPlugin()
    current_path = os.path.dirname(__file__)
    resources_path = os.path.join(current_path, "resources")
    success_resource_path = os.path.join(resources_path, "success_resources")
    with open(success_resource_path, "r") as f:
        content = f.readlines()
    if resource_type:
        supported_resource_types = [resource_type]
    else:
        supported_resource_types = get_supported_resource_types()
    for res_type in supported_resource_types:
        if f"{res_type}\n" in content and not resource_type:
            continue
        template = ros_plugin.get_resource_template(res_type)
        dir_name = res_type[8:].lower().replace("::", "_")
        resource_path = os.path.join(resources_path, dir_name)

        try:
            ros2tf = ROS2TerraformTemplate.initialize(template, validate=False)
            ros2tf.transform(resource_path, single_file=True)

            tf = TerraformCommand(resource_path)
            tf.init()
            tf.validate(check=True)
            data = RosTemplate.initialize(template).as_dict(format=True)
            with open(os.path.join(resource_path, "template.yml"), "w", encoding="utf-8") as f:
                yaml.dump(data, f)
            with open(success_resource_path, "a") as f:
                f.write(f"{res_type}\n")
        except TerraformCommandError as e:
            print(f"{dir_name} {res_type} failed: {e.stdout}")
        except RosTranException as e:
            print(f"{dir_name} {res_type} failed: {e}")
            with open(os.path.join(resource_path, "template.yml"), "w", encoding="utf-8") as f:
                yaml.dump(template, f)
        except Exception as e:
            print(f"{dir_name} {res_type} failed: {e}")
            raise e


def _test_specific_resource_type():
    res_type = "ALIYUN::ECS::InstanceGroup"
    _test_all_resource_types(resource_type=res_type)
