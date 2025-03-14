variable "instance_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "ID list of instances to install backup client"
    },
    "Label": {
      "en": "InstanceIds",
      "zh-cn": "安装ECS备份客户端的实例ID"
    },
    "MinLength": 1,
    "MaxLength": 20
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_hbr_ecs_backup_client" "backup_clients" {}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "instance_ids" {
  // Could not transform ROS Attribute InstanceIds to Terraform attribute.
  value       = null
  description = "ID list of instances to install backup client"
}

output "client_ids" {
  // Could not transform ROS Attribute ClientIds to Terraform attribute.
  value       = null
  description = "ID list of clients installed in instances"
}

