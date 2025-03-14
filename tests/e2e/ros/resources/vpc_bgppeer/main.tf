variable "peer_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP address of the BGP peer."
    },
    "Label": {
      "en": "PeerIpAddress",
      "zh-cn": "BGP邻居的IP地址"
    }
  }
  EOT
}

variable "enable_bfd" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the Bidirectional Forwarding Detection (BFD) feature.\nValid values:\ntrue: enables BFD.\nfalse: disables BFD."
    },
    "Label": {
      "en": "EnableBfd",
      "zh-cn": "是否开启BFD功能"
    }
  }
  EOT
}

variable "bgp_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the BGP group."
    },
    "Label": {
      "en": "BgpGroupId",
      "zh-cn": "BGP组的ID"
    }
  }
  EOT
}

resource "alicloud_vpc_bgp_peer" "bgp_peer" {
  peer_ip_address = var.peer_ip_address
  enable_bfd      = var.enable_bfd
  bgp_group_id    = var.bgp_group_id
}

output "bgp_peer_id" {
  value       = alicloud_vpc_bgp_peer.bgp_peer.id
  description = "The ID of the BGP peer."
}

