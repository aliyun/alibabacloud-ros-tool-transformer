variable "eip_mask" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      28,
      27,
      26,
      25,
      24
    ],
    "Description": {
      "en": "The mask of the contiguous EIP group. Valid values:\n28: 16 contiguous EIPs are allocated for one call.\n27: 32 contiguous EIPs are allocated for one call.\n26: 64 contiguous EIPs are allocated for one call.\n25: 128 contiguous EIPs are allocated for one call.\n24: 256 contiguous EIPs are allocated for one call.\nNote The actual number of assigned EIPs may be less than the expected number because one,\nthree, or four EIPs may be reserved."
    },
    "Label": {
      "en": "EipMask",
      "zh-cn": "连续EIP的掩码"
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
      "en": "The ID of the resource group to which the EIPs belong."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "netmode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The network type. Valid values:\npublic: the Internet. This is the default value. After contiguous EIPs are associated with\ncloud resources, the cloud resources can access the Internet by using the EIPs.\nhybrid: the hybrid cloud. After contiguous EIPs are associated with cloud resources, the\ncloud resources can access the hybrid cloud by using the EIPs.\nNote This network type is available only to users who are added to the whitelist. To use\nthis network type, contact your customer manager."
    },
    "AllowedValues": [
      "public",
      "hybrid"
    ],
    "Label": {
      "en": "Netmode",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum bandwidth of the contiguous EIPs. Unit: Mbit/s. Default value: 5."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "EIP的带宽峰值"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "The metering method of the contiguous EIPs. Valid values:\nPayByBandwidth: Fees are charged based on bandwidth usage. This is the default value.\nPayByTraffic: Fees are charged based on data transfer.\nNote If the Netmode parameter is set to hybrid, InternetChargeType is set to PayByBandwidth."
    },
    "AllowedValues": [
      "PayByTraffic",
      "PayByBandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "连续EIP的计费方式"
    }
  }
  EOT
}

resource "alicloud_eip_segment_address" "eipsegment" {
  eip_mask             = var.eip_mask
  resource_group_id    = var.resource_group_id
  netmode              = var.netmode
  bandwidth            = var.bandwidth
  internet_charge_type = var.internet_charge_type
}

output "eip_segment_instance_id" {
  value       = alicloud_eip_segment_address.eipsegment.id
  description = "The ID of the contiguous EIP group."
}

output "eip_addresses" {
  // Could not transform ROS Attribute EipAddresses to Terraform attribute.
  value       = null
  description = "List of EIP addresses. like [{\"AllocationId\": \"eip-xxx\", \"IpAddress\": \"xx.xx.xx.xx\"}]"
}

