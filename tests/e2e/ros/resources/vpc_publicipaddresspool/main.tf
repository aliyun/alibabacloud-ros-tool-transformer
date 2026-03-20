variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the address pool instance.\nThe length is 0-256 characters, and you cannot start with http:// or https: //."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "地址池实例的描述"
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
      "en": "The ID of the resource group that the IP address pool belongs to."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "IP 地址池所属的资源组 ID"
    }
  }
  EOT
}

variable "isp" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The line type. Valid values:\nBGP (default): BGP (Multi-ISP) lines. All regions support BGP (Multi-ISP) EIPs.\nBGP_PRO: BGP (Multi-ISP) Pro lines. \nOnly the following regions support BGP (Multi-ISP) Pro lines: \nChina (Hong Kong), Singapore, Malaysia (Kuala Lumpur), Philippines (Manila), Indonesia (Jakarta), and Thailand (Bangkok).\nFor more information about BGP (Multi-ISP) and BGP (Multi-ISP) Pro, see EIP line types.\nIf you are allowed to use single-ISP bandwidth, you can also choose one of the following values:\nChinaTelecom: China Telecom\nChinaUnicom: China Unicom\nChinaMobile: China Mobile\nChinaTelecom_L2: China Telecom L2\nChinaUnicom_L2: China Unicom L2\nChinaMobile_L2: China Mobile L2\nIf your services are deployed in China East 1 Finance, you must set this parameter to BGP_FinanceCloud."
    },
    "AllowedValues": [
      "BGP",
      "BGP_PRO",
      "RunShellScript",
      "ChinaTelecom",
      "ChinaUnicom",
      "ChinaMobile",
      "ChinaTelecom_L2",
      "ChinaUnicom_L2",
      "ChinaMobile_L2",
      "BGP_FinanceCloud"
    ],
    "Label": {
      "en": "Isp",
      "zh-cn": "线路类型"
    }
  }
  EOT
}

variable "security_protection_types" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "AllowedValues": [
          "AntiDDoS_Enhanced"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Safety protection level.\nWhen configured as empty, the default is DDOS protection (basic version).\nWhen configured as Antiddos_enhanced, it means DDOS protection (enhanced version)."
    },
    "Label": {
      "en": "SecurityProtectionTypes",
      "zh-cn": "安全防护级别"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "biz_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The business type of IP address pool.Value:\nCloudbox: Cloud Box.Cloud box users support to select this type.\nDefault (default): default, indicating non -special types."
    },
    "AllowedValues": [
      "CloudBox",
      "Default"
    ],
    "Label": {
      "en": "BizType",
      "zh-cn": "IP地址池的业务类型"
    }
  }
  EOT
}

variable "tags" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The value of the tag."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The keyword of the tag."
          },
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
      "en": "The list of container group tags in the form of key/value pairs. You can define a maximum of 20 tags for each container group."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "IP地址池绑定的标签列表"
    },
    "MinLength": 1,
    "MaxLength": 20
  }
  EOT
}

variable "zones" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
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
      "en": "The available areas of the IP address pool.\nThe Biztype value is Cloudbox, that is, when the type of IP address pool is a cloud box, the parameter must be filled."
    },
    "Label": {
      "en": "Zones",
      "zh-cn": "IP 地址池的可用区"
    },
    "MaxLength": 1
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the address pool instance.\nThe length is 0-128 characters, and you cannot start with http: // or https: //."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "地址池实例的名称"
    }
  }
  EOT
}

resource "alicloud_vpc_public_ip_address_pool" "public_ip_address_pool" {
  description                 = var.description
  resource_group_id           = var.resource_group_id
  isp                         = var.isp
  security_protection_types   = var.security_protection_types
  biz_type                    = var.biz_type
  tags                        = var.tags
  public_ip_address_pool_name = var.name
}

output "public_ip_address_pool_id" {
  value       = alicloud_vpc_public_ip_address_pool.public_ip_address_pool.public_ip_address_pool_id
  description = "Example ID of the IP address pool."
}

