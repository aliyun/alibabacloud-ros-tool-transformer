variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The IDs of the vSwitches in the VPC. This parameter is required when you create a CloudBox-based workspace."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "专有网络VPC中的交换机ID"
    }
  }
  EOT
}

variable "enable_admin_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to grant the permissions of the local administrator to the regular user of the cloud desktop.\nEnumeration Value:\ntrue\nfalse"
    },
    "Label": {
      "en": "EnableAdminAccess",
      "zh-cn": "是否为使用云桌面的用户赋予本地管理员权限"
    }
  }
  EOT
}

variable "cloud_box_office_site" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the workspace is a CloudBox-based workspace.\nEnumeration Value:\ntrue\nfalse"
    },
    "Label": {
      "en": "CloudBoxOfficeSite",
      "zh-cn": "是否为云盒工作区"
    }
  }
  EOT
}

variable "cidr_block" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IPv4 CIDR block in the secure office network of the workspace. The IPv4 CIDR block that the system uses to create a virtual private cloud (VPC) for the workspace. We recommend that you set the IPv4 CIDR block to 10.0.0.0/12, 172.16.0.0/12, 192.168.0.0/16, or a subnet of these CIDR blocks. If you set the IPv4 CIDR block to 10.0.0.0/12 or 172.16.0.0/12, the mask is 1224 bits in length. If you set the IPv4 CIDR block to 192.168.0.0/16, the mask is 1624 bits in length."
    },
    "Label": {
      "en": "CidrBlock",
      "zh-cn": "工作区对应的安全办公网络包含的IPv4网段"
    }
  }
  EOT
}

variable "verify_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The verification code. If the CEN instance that you specify for the CenId parameter belongs to another Alibaba Cloud account, you must call the SendVerifyCode operation to obtain the verification code."
    },
    "Label": {
      "en": "VerifyCode",
      "zh-cn": "验证码"
    }
  }
  EOT
}

variable "vpc_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of office network.\nEnumeration value:\nstandard: Advanced office network.\nbasic: Basic office network."
    },
    "AllowedValues": [
      "standard",
      "basic"
    ],
    "Label": {
      "en": "VpcType",
      "zh-cn": "办公网络的类型"
    }
  }
  EOT
}

variable "need_verify_zero_device" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable trusted device verification.\nEnumeration Value:\ntrue\nfalse"
    },
    "Label": {
      "en": "NeedVerifyZeroDevice",
      "zh-cn": "是否开启可信设备校验"
    }
  }
  EOT
}

variable "cen_owner_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Alibaba Cloud account to which the Cloud Enterprise Network (CEN) instance belongs.\nIf you do not specify the CenId parameter, or the CEN instance that is specified by the CenId parameter belongs to the current Alibaba Cloud account, skip this parameter.\nIf you specify the CenId parameter and the CEN instance that you specify for the CenId parameter belongs to another Alibaba Cloud account, enter the ID of the Alibaba Cloud account."
    },
    "Label": {
      "en": "CenOwnerId",
      "zh-cn": "云企业网实例所属的阿里云账号ID"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum public bandwidth. Value range: 10 to 200. Unit: Mbit/s. This parameter is available if you set EnableInternetAccess to true."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "公网带宽峰值"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Cloud Enterprise Network (CEN) instance.\nNoteIf you want to connect to your cloud desktops over a VPC, you can attach the network of the workspace to the CEN instance. The CEN instance is connected to the on-premises network over VPN Gateway or Express Connect."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网CEN实例ID"
    }
  }
  EOT
}

variable "desktop_access_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The method that is used to connect the client to cloud desktops.\nNoteVPC connections are established by using Alibaba Cloud PrivateLink. You can use PrivateLink for free. When you set this parameter to VPC or Any, PrivateLink is automatically activated."
    },
    "AllowedValues": [
      "VPC",
      "Internet",
      "Any"
    ],
    "Label": {
      "en": "DesktopAccessType",
      "zh-cn": "连接云桌面时允许使用的接入方式"
    }
  }
  EOT
}

variable "office_site_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the workspace. The name must be 2 to 255 characters in length. It must start with a letter and cannot start with http:// or https://. The name can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "OfficeSiteName",
      "zh-cn": "工作区名称"
    }
  }
  EOT
}

variable "enable_internet_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable Internet access. By default, Internet access is not enabled.\nEnumeration Value:\ntrue\nfalse"
    },
    "Label": {
      "en": "EnableInternetAccess",
      "zh-cn": "是否开通公网访问功能"
    }
  }
  EOT
}

resource "alicloud_ecd_simple_office_site" "simple_office_site" {
  enable_admin_access    = var.enable_admin_access
  cidr_block             = var.cidr_block
  cen_owner_id           = var.cen_owner_id
  bandwidth              = var.bandwidth
  cen_id                 = var.cen_id
  desktop_access_type    = var.desktop_access_type
  office_site_name       = var.office_site_name
  enable_internet_access = var.enable_internet_access
}

output "office_site_id" {
  value       = alicloud_ecd_simple_office_site.simple_office_site.id
  description = "The ID of the workspace."
}

