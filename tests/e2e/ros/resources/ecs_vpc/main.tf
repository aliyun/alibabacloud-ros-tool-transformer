variable "ipv6_isp" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${EnableIpv6}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "The Internet service provider (ISP) for IPv6 addresses of the VPC. Valid values:\nBGP(default): Alibaba Cloud BGP IPv6\nChinaMobile: China Mobile (single line)\nChinaUnicom: China Unicom (single line)\nChinaTelecom: China Telecom (single line)\nNote If your Alibaba Cloud account is allowed to activate single-ISP bandwidth, you can set the parameter to ChinaTelecom, ChinaUnicom, and ChinaMobile."
    },
    "AllowedValues": [
      "BGP",
      "ChinaMobile",
      "ChinaUnicom",
      "ChinaTelecom"
    ],
    "Label": {
      "en": "Ipv6Isp",
      "zh-cn": "专有网络的IPv6地址段类型"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the vpc, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "专有网络描述"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "secondary_cidr_blocks" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The secondary IPv4 CIDR block. \nYou can specify one of the following standard IPv4 CIDR blocks or their \nsubnets as the secondary IPv4 CIDR block: 192.168.0.0/16, 172.16.0.0/12, \nand 10.0.0.0/8.To use a public CIDR block as the secondary IPv4 CIDR block, \nsubmit a ticket. When you add a secondary IPv4 CIDR block, take note of \nthe following rules: \n1. The CIDR block cannot start with 0. \n2. The subnet mask must be 8 to 24 bits in length.\nThe secondary CIDR block cannot overlap with the primary \nCIDR block or an existing secondary CIDR block."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The secondary IPv4 CIDR blocks. \n",
      "zh-cn": "向创建的VPC添加附加的网段。一个VPC最多支持添加5个附加IPv4网段。"
    },
    "Label": {
      "zh-cn": "为VPC添加附加Ipv4网段"
    },
    "MinLength": 0,
    "MaxLength": 5
  }
  EOT
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/8"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "RecommendValues": [
        "10.0.0.0/8",
        "172.16.0.0/12",
        "192.168.0.0/16"
      ],
      "RecommendDescription": {
        "en": "You can choose the following values for quick setup.",
        "zh-cn": "您可以选择以下值进行快速设置。"
      }
    },
    "AssociationProperty": "ALIYUN::VPC::VPC::CidrBlock",
    "Description": {
      "en": "The IP address range of the VPC in the CIDR block form. You can use the following IP address ranges and their subnets:\n10.0.0.0/8\n172.16.0.0/12 (Default)\n192.168.0.0/16",
      "zh-cn": "建议您使用RFC私网地址作为专有网络的网段如10.0.0.0/8，172.16.0.0/12，192.168.0.0/16。"
    },
    "Label": {
      "en": "CidrBlock",
      "zh-cn": "专有网络网段"
    }
  }
  EOT
}

variable "vpc_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the vpc instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "VpcName",
      "zh-cn": "专有网络名称"
    }
  }
  EOT
}

variable "ipv6_cidr_block" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${EnableIpv6}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "IPv6 network cidr of the VPC."
    },
    "Label": {
      "en": "Ipv6CidrBlock",
      "zh-cn": "专有网络的IPv6网段"
    },
    "MinLength": 1
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
      "en": "Tags to attach to vpc. Max support 20 tags to add during create vpc. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "enable_ipv6" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable an IPv6 network cidr, the value is:False (default): not turned on.True: On."
    },
    "Label": {
      "en": "EnableIpv6",
      "zh-cn": "是否开启IPv6网段"
    }
  }
  EOT
}

variable "user_cidr" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The user CIDR block. Separate multiple CIDR blocks with commas (,). At most three CIDR blocks are supported."
    },
    "Label": {
      "en": "UserCidr",
      "zh-cn": "用户网段"
    }
  }
  EOT
}

resource "alicloud_vpc" "vpc" {
  ipv6_isp              = var.ipv6_isp
  description           = var.description
  resource_group_id     = var.resource_group_id
  secondary_cidr_blocks = var.secondary_cidr_blocks
  cidr_block            = var.cidr_block
  vpc_name              = var.vpc_name
  ipv6_cidr_block       = var.ipv6_cidr_block
  tags                  = var.tags
  enable_ipv6           = var.enable_ipv6
}

output "vrouter_id" {
  // Could not transform ROS Attribute VRouterId to Terraform attribute.
  value       = null
  description = "Router id of created VPC."
}

output "route_table_id" {
  value       = alicloud_vpc.vpc.route_table_id
  description = "The router table id of created VPC."
}

output "vpc_id" {
  value       = alicloud_vpc.vpc.id
  description = "Id of created VPC."
}

output "vpc_name" {
  value       = alicloud_vpc.vpc.vpc_name
  description = "The name of VPC"
}

