variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the route table.\nThe description must be 2 to 256 characters in length. The description must start with a letter, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "路由表的描述信息"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The ID of the VPC to which the custom route table belongs."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "自定义路由表所属的VPC ID"
    }
  }
  EOT
}

variable "route_table_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the route table.\nThe name must be 2 to 128 characters in length. It can contain letters, numbers, periods (.), underscores (_), and hyphens (-). It must start with a letter and cannot start with http:// or https://."
    },
    "Label": {
      "en": "RouteTableName",
      "zh-cn": "路由表的名称"
    }
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
      "en": "Tags to attach to routetable. Max support 20 tags to add during create routetable. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_route_table" "route_table" {
  description = var.description
  vpc_id      = var.vpc_id
  name        = var.route_table_name
  tags        = var.tags
}

output "route_table_id" {
  value       = alicloud_route_table.route_table.id
  description = "The ID of the route table."
}

output "vpc_id" {
  value       = alicloud_route_table.route_table.vpc_id
  description = "The ID of the VRouter to which the route table belongs."
}

output "vswitch_ids" {
  // Could not transform ROS Attribute VSwitchIds to Terraform attribute.
  value       = null
  description = "A list of VSwitches under the VPC."
}

output "route_table_type" {
  // Could not transform ROS Attribute RouteTableType to Terraform attribute.
  value       = null
  description = "The type of the route table."
}

output "route_table_name" {
  value       = alicloud_route_table.route_table.route_table_name
  description = "The name of the route table."
}

