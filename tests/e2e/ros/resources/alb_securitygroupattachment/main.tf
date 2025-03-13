variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of ALB instance."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "应用型负载均衡实例 ID"
    }
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the security group to which the ALB instance join."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "安全组 ID 集合"
    },
    "MinLength": 0,
    "MaxLength": 4
  }
  EOT
}

resource "alicloud_alb_load_balancer_security_group_attachment" "security_group_attachment" {
  load_balancer_id = var.load_balancer_id
}

