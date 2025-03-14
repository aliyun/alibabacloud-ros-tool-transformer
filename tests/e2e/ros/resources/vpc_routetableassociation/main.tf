variable "route_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the route table."
    },
    "Label": {
      "en": "RouteTableId",
      "zh-cn": "路由表ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the VSwitch."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "要绑定的交换机ID"
    }
  }
  EOT
}

resource "alicloud_route_table_attachment" "route_table_association" {
  route_table_id = var.route_table_id
  vswitch_id     = var.vswitch_id
}

output "route_table_id" {
  value       = alicloud_route_table_attachment.route_table_association.route_table_id
  description = "The ID of the route table."
}

output "vswitch_id" {
  value       = alicloud_route_table_attachment.route_table_association.vswitch_id
  description = "The VSwitch ID which the route table associated with."
}

