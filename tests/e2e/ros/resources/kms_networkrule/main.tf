variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the network rule."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "source_private_ip" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "CIDR format IP."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "VPC network whitelist, The private IP address or private CIDR block, Supports binding up to 800 CIDR blocks or IP addresses."
    },
    "Label": {
      "en": "SourcePrivateIp",
      "zh-cn": "私网IP地址或者私网网段列表"
    },
    "MinLength": 1,
    "MaxLength": 800
  }
  EOT
}

variable "network_rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the access control rule."
    },
    "Label": {
      "en": "NetworkRuleName",
      "zh-cn": "网络控制规则名称"
    }
  }
  EOT
}

resource "alicloud_kms_network_rule" "extension_resource" {
  description       = var.description
  source_private_ip = var.source_private_ip
  network_rule_name = var.network_rule_name
}

output "description" {
  value       = alicloud_kms_network_rule.extension_resource.description
  description = "Description."
}

output "source_private_ip" {
  value       = alicloud_kms_network_rule.extension_resource.source_private_ip
  description = "VPC network whitelist."
}

