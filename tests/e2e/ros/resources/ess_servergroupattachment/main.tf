variable "server_groups" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of backend server group.\nValid values:\nALB\nNLB"
          },
          "AllowedValues": [
            "ALB",
            "NLB"
          ],
          "Required": true
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port number used by an ECS instance in the scaling group after Auto Scaling adds the ECS instance to backend server group.\nALB server group port range [1,65535], NLB server group port range [0,65535]."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 65535
        },
        "ServerGroupId": {
          "Type": "String",
          "Description": {
            "en": "The ID of backend server group."
          },
          "Required": true
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of an ECS instance in the scaling group as a backend server after Auto Scaling adds the ECS instance to backend server group. Valid values: 0 to 100.\nIf you increase the weight of an ECS instance in a backend server group, the number of access requests that are forwarded to the ECS instance increases. If you set the Weight parameter for an ECS instance in a backend server group to 0, no access requests are forwarded to the ECS instance."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 100
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "A collection of information about server groups."
    },
    "Label": {
      "en": "ServerGroups",
      "zh-cn": "服务器组的相关信息集合"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the scaling group."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩组ID"
    }
  }
  EOT
}

variable "force_attach" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to add the Elastic Compute Service (ECS) instances in the scaling group to the backend server group of the newly attached SLB instance. Valid values:\ntrue\nfalse\nDefault value: false."
    },
    "Label": {
      "en": "ForceAttach",
      "zh-cn": "是否将当前伸缩组内的ECS实例添加到新增的服务器组"
    }
  }
  EOT
}

resource "alicloud_ess_alb_server_group_attachment" "server_group_attachment" {
  scaling_group_id = var.scaling_group_id
  force_attach     = var.force_attach
}

output "scaling_activity_id" {
  // Could not transform ROS Attribute ScalingActivityId to Terraform attribute.
  value       = null
  description = <<EOT
  "The ID of the scaling activity during which one or more SLB instances are attached to the scaling group and the ECS instances in the scaling group are added to the backend server groups of the SLB instances.\nNote This parameter is returned only after you set the ForceAttach parameter to true."
  EOT
}

