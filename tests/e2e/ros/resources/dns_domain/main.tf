variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "域名所属的资源组ID"
    }
  }
  EOT
}

variable "domain_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::DNS::Domain::ValidateDomain",
    "Description": {
      "en": "Domain name"
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "域名名称"
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Domain name grouping, the default is the \"default grouping\" GroupId"
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "域名分组ID"
    }
  }
  EOT
}

resource "alicloud_alidns_domain" "domain" {
  resource_group_id = var.resource_group_id
  domain_name       = var.domain_name
  tags              = var.tags
  group_id          = var.group_id
}

output "group_name" {
  value       = alicloud_alidns_domain.domain.group_name
  description = "The name of the domain name group"
}

output "domain_id" {
  value       = alicloud_alidns_domain.domain.domain_id
  description = "Domain ID"
}

output "domain_name" {
  value       = alicloud_alidns_domain.domain.id
  description = "Domain name"
}

output "puny_code" {
  value       = alicloud_alidns_domain.domain.puny_code
  description = "punycode returned only for a Chinese domain name"
}

output "dns_servers" {
  value       = alicloud_alidns_domain.domain.dns_servers
  description = "The DNS list for the domain name under resolution"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "group_id" {
  value       = alicloud_alidns_domain.domain.group_id
  description = "Domain name group ID"
}

