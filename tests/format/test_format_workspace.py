import yaml

from rostran.core.workspace import Workspace

tpl_workspace_yaml = """
modules/vpc/main.tf: |-
  variable "vpc_name" {
    type = string
    default = "tf_test"
    description = "专有网络名称"
  }
  resource "alicloud_vpc" "vpc" {
    name       = var.vpc_name
    cidr_block = "172.16.0.0/12"
  }
  output "vpc_id" {
    value = "${alicloud_vpc.vpc.id}"
  }
main.tf: |-
  variable "zone_id" {
    type = string
    description = <<EOT
    {
      "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
      "Description": {
        "en": "Zone of VSwitch",
        "zh-cn": "交换机所在可用区"
      },
      "Label": {
        "en": "Zone",
        "zh-cn": "可用区"
      }
    }
    EOT
  }
  variable "subnet_mask" {
    type = number
  }
  module "my_vpc" {
    source      = "./modules/vpc"
  }
  resource "alicloud_vswitch" "vsw" {
    vpc_id            = "${module.my_vpc.vpc_id}"
    cidr_block        = "172.16.0.0/${var.subnet_mask}"
    availability_zone = var.zone_id
  }
  output "vsw_id" {
    value = "${alicloud_vswitch.vsw.id}"
    description = <<EOT
    {
      "Description": {
        "en": "VSwitch ID",
        "zh-cn": "交换机ID"
      }
    }
    EOT
  }
"""


def test_format_workspace():
    params = Workspace.initialize(yaml.safe_load(tpl_workspace_yaml))
    data = params.as_dict(format=True)

    # Workspace key order
    assert list(data) == ["main.tf", "modules/vpc/main.tf"]
