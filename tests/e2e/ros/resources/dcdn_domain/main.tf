variable "check_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The validation of the origin."
    },
    "Label": {
      "en": "CheckUrl",
      "zh-cn": "健康检测URL"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group. If this is left blank, the system automatically fills in the ID of the default resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Valid values: domestic, overseas, and global. Default value: domestic. The setting is supported for users outside mainland China, users in mainland China of level 3 or above."
    },
    "AllowedValues": [
      "domestic",
      "overseas",
      "global"
    ],
    "Label": {
      "en": "Scope",
      "zh-cn": "加速区域"
    }
  }
  EOT
}

variable "domain_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The DCDN domain name. Wildcard domain names that start with periods (.) are supported. For example, .a.com."
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "待添加的加速域名"
    }
  }
  EOT
}

variable "top_level_domain" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The top-level domain, which can only be configured by users on the whitelist."
    },
    "Label": {
      "en": "TopLevelDomain",
      "zh-cn": "顶级接入域"
    }
  }
  EOT
}

variable "sources" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of the origin server. Valid values:\nipaddr: the IP address\ndomain: the domain name\noss: the endpoint of an Object Storage Service (OSS) bucket\nfc_domain: the domain name of Function Compute"
          },
          "AllowedValues": [
            "ipaddr",
            "domain",
            "oss",
            "fc_domain"
          ],
          "Required": true
        },
        "Content": {
          "Type": "String",
          "Description": {
            "en": "The address of the origin server. You can specify an IP address or a domain name."
          },
          "Required": true
        },
        "Priority": {
          "Type": "String",
          "Description": {
            "en": "The priority of the origin server if multiple origin servers are specified. Default value: 20. Valid values:\n20: the primary origin server\n30: the secondary origin server"
          },
          "AllowedValues": [
            "20",
            "30"
          ],
          "Required": false,
          "Default": "20"
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port. Valid values:\n80: the default port\n443: the HTTPS port\nA custom port"
          },
          "Required": false,
          "Default": 80
        },
        "Weight": {
          "Type": "String",
          "Description": {
            "en": "The weight of the origin server if multiple origin servers are specified. Valid values: 0 to 100. Default value: 10."
          },
          "Required": false,
          "Default": "10"
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of origin URLs."
    },
    "Label": {
      "en": "Sources",
      "zh-cn": "回源地址列表"
    },
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required.",
      "zh-cn": "实例的标签。最多支持添加20个标签。"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例的标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_dcdn_domain" "domain" {
  check_url         = var.check_url
  resource_group_id = var.resource_group_id
  scope             = var.scope
  domain_name       = var.domain_name
  top_level_domain  = var.top_level_domain
  sources           = var.sources
  tags              = var.tags
}

output "domain_name" {
  value       = alicloud_dcdn_domain.domain.id
  description = "The CDN domain name. Wildcard domain names that start with periods (.) are supported. For example, .a.com."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "cname" {
  value       = alicloud_dcdn_domain.domain.cname
  description = "The CNAME generated for the CDN domain.You must add a CNAME record with your DNS provider to map the CDN domain name to the CNAME."
}

