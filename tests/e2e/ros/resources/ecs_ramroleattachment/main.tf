variable "policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "When granting the instance RAM role to one or more ECS instances, you can specify an additional permission policy to further limit the permissions of the RAM role.\nThe length is 1~1024 characters."
    },
    "Label": {
      "en": "Policy",
      "zh-cn": "权限策略"
    },
    "MinLength": 1,
    "MaxLength": 1024
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::Role",
    "Description": {
      "en": "The ram role name."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "instance_ids" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The instance id that needs to be granted the ram role."
    },
    "Label": {
      "zh-cn": "ECS实例ID列表"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_ram_role_attachment" "ram_role_attachment" {
  role_name    = var.ram_role_name
  instance_ids = var.instance_ids
}

