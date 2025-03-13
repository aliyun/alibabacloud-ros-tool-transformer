variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the BGP group. The description must be 2 to 256 characters in length.\nIt must start with a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "BGP组的描述信息"
    }
  }
  EOT
}

variable "local_asn" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The AS number on the Alibaba Cloud side."
    },
    "Label": {
      "en": "LocalAsn",
      "zh-cn": "云上设备的AS号码"
    }
  }
  EOT
}

variable "ip_version" {
  type        = string
  default     = "IPv4"
  description = <<EOT
  {
    "Description": {
      "en": "The IP version of the BGP group. Valid values: IPv4 and IPv6."
    },
    "AllowedValues": [
      "IPv4",
      "IPv6"
    ],
    "Label": {
      "en": "IpVersion",
      "zh-cn": "IP 版本"
    }
  }
  EOT
}

variable "auth_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The authentication key of the BGP group."
    },
    "Label": {
      "en": "AuthKey",
      "zh-cn": "BGP组的认证密钥"
    }
  }
  EOT
}

variable "router_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the VBR."
    },
    "Label": {
      "en": "RouterId",
      "zh-cn": "边界路由器ID"
    }
  }
  EOT
}

variable "peer_asn" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The AS number of the BGP peer."
    },
    "Label": {
      "en": "PeerAsn",
      "zh-cn": "本地设备的AS号码"
    }
  }
  EOT
}

variable "is_fake_asn" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "A router that runs BGP typically belongs to only one AS. In some cases, for example,\nthe AS needs to be migrated or is merged with another AS, a new AS number replaces\nthe original one."
    },
    "Label": {
      "en": "IsFakeAsn",
      "zh-cn": "AS号码是否为假"
    }
  }
  EOT
}

variable "route_quota" {
  type        = number
  default     = 110
  description = <<EOT
  {
    "Description": {
      "en": "The upper limit of the BGP neighbor's route entries. Unit: entries, default value: 110."
    },
    "MinValue": 1,
    "Label": {
      "en": "RouteQuota",
      "zh-cn": "BGP 邻居的路由条目上限"
    },
    "MaxValue": 110
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the BGP group. The name must be 2 to 128 characters in length and can\ncontain digits, periods (.), underscores (_), and hyphens (-). The name must start\nwith a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "BGP组的名称"
    }
  }
  EOT
}

resource "alicloud_vpc_bgp_group" "bgp_group" {
  description    = var.description
  local_asn      = var.local_asn
  auth_key       = var.auth_key
  router_id      = var.router_id
  peer_asn       = var.peer_asn
  is_fake_asn    = var.is_fake_asn
  bgp_group_name = var.name
}

output "bgp_group_id" {
  value       = alicloud_vpc_bgp_group.bgp_group.id
  description = "The ID of the BGP group."
}

output "name" {
  value       = alicloud_vpc_bgp_group.bgp_group.bgp_group_name
  description = "The name of the BGP group."
}

