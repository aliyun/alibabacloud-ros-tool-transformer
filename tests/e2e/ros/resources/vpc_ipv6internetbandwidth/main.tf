variable "bandwidth" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Public IPv6 address of bandwidth, unit: Mbps, range: 1-5000.\nWhen InternetChargeType is PayByBandwidth, the bandwidth of the public network is the IPv6 address 1-5000.\nWhen InternetChargeType is PayByTraffic, public network bandwidth IPv6 addresses while IPv6 gateway restricted specifications.\nSmall (default free version), the public network bandwidth range 1-500.\nMedium (Enterprise Edition), the public network bandwidth range from 1 to 1000.\nLarge (Enterprise Edition), the public network bandwidth range 1-2000."
    },
    "MinValue": 1,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "IPv6地址的公网带宽"
    },
    "MaxValue": 5000
  }
  EOT
}

variable "ipv6_address_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ID of IPv6 address."
    },
    "Label": {
      "en": "Ipv6AddressId",
      "zh-cn": "IPv6地址的实例ID"
    }
  }
  EOT
}

variable "ipv6_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ID of IPv6 gateway."
    },
    "Label": {
      "en": "Ipv6GatewayId",
      "zh-cn": "IPv6网关的ID"
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
      "en": "IPv6 public network bandwidth billing, value:\n- **PayByTraffic**: by using the traffic accounting.\n- **PayByBandwidth** (default): Bandwidth billing."
    },
    "AllowedValues": [
      "PayByTraffic",
      "PayByBandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "IPv6公网带宽的计费方式"
    }
  }
  EOT
}

resource "alicloud_vpc_ipv6_internet_bandwidth" "ipv6_internet_bandwidth" {
  bandwidth            = var.bandwidth
  ipv6_address_id      = var.ipv6_address_id
  ipv6_gateway_id      = var.ipv6_gateway_id
  internet_charge_type = var.internet_charge_type
}

output "internet_bandwidth_id" {
  value       = alicloud_vpc_ipv6_internet_bandwidth.ipv6_internet_bandwidth.id
  description = "Purchase of public network bandwidth."
}

