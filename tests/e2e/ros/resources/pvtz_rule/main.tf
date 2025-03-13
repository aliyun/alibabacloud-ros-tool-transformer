variable "forward_ip" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Ip": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the destination external server."
          },
          "Required": true
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port number of the destination external server."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The destination external server."
    },
    "Label": {
      "en": "ForwardIp",
      "zh-cn": "转发目标IP配置"
    }
  }
  EOT
}

variable "zone_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The domain name that requires DNS traffic forwarding."
    },
    "Label": {
      "en": "ZoneName",
      "zh-cn": "转发Zone名称"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "OUTBOUND"
    ],
    "Description": {
      "en": "The type of the forwarding rule. Valid value:\nOUTBOUND: forwards Domain Name System (DNS) traffic to one or more external IP addresses."
    },
    "Label": {
      "en": "Type",
      "zh-cn": "转发规则类型"
    }
  }
  EOT
}

variable "endpoint_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the endpoint."
    },
    "Label": {
      "en": "EndpointId",
      "zh-cn": "终端节点ID"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the forwarding rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "转发规则名称"
    }
  }
  EOT
}

resource "alicloud_pvtz_rule" "extension_resource" {
  zone_name   = var.zone_name
  type        = var.type
  endpoint_id = var.endpoint_id
  rule_name   = var.rule_name
}

output "forward_ip" {
  // Could not transform ROS Attribute ForwardIp to Terraform attribute.
  value       = null
  description = "The information about each destination external server."
}

output "zone_name" {
  value       = alicloud_pvtz_rule.extension_resource.zone_name
  description = "The domain name that requires Domain Name System (DNS) traffic forwarding."
}

output "vpcs" {
  // Could not transform ROS Attribute Vpcs to Terraform attribute.
  value       = null
  description = "The information about each virtual private cloud (VPC) that is associated with the forwarding rule."
}

output "type" {
  value       = alicloud_pvtz_rule.extension_resource.type
  description = "The type of the forwarding rule."
}

output "endpoint_name" {
  // Could not transform ROS Attribute EndpointName to Terraform attribute.
  value       = null
  description = "The name of the endpoint."
}

output "endpoint_id" {
  value       = alicloud_pvtz_rule.extension_resource.endpoint_id
  description = "The ID of the endpoint."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The timestamp when the forwarding rule was created."
}

output "rule_name" {
  value       = alicloud_pvtz_rule.extension_resource.rule_name
  description = "The name of the forwarding rule."
}

