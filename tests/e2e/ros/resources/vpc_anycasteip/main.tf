variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Anycast EIP instance description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "Anycast EIP实例描述"
    }
  }
  EOT
}

variable "service_location" {
  type        = string
  default     = "international"
  description = <<EOT
  {
    "Description": {
      "en": "Anycast EIP instance access area"
    },
    "AllowedValues": [
      "international"
    ],
    "Label": {
      "en": "ServiceLocation",
      "zh-cn": "Anycast EIP实例接入地域"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "Anycast EIP instance charge type"
    },
    "AllowedValues": [
      "PayAsYouGo"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "Anycast EIP实例付费类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Anycast EIP instance bandwidth"
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "Anycast EIP实例带宽峰值"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Anycast EIP instance name"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "Anycast EIP实例名称"
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
      "en": "Anycast EIP instance access public network billing method"
    },
    "AllowedValues": [
      "PayByTraffic"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "Anycast EIP实例访问公网计费方式"
    }
  }
  EOT
}

resource "alicloud_eipanycast_anycast_eip_address" "anycast_eip" {
  description          = var.description
  service_location     = var.service_location
  payment_type         = var.instance_charge_type
  bandwidth            = var.bandwidth
  internet_charge_type = var.internet_charge_type
}

output "anycast_id" {
  value       = alicloud_eipanycast_anycast_eip_address.anycast_eip.id
  description = "Anycast EIP instance ID"
}

output "ip_address" {
  // Could not transform ROS Attribute IpAddress to Terraform attribute.
  value       = null
  description = "Anycase IP address"
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Order ID"
}

output "name" {
  value       = alicloud_eipanycast_anycast_eip_address.anycast_eip.anycast_eip_address_name
  description = "Anycast EIP instance name"
}

