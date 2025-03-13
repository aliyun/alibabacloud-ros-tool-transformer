variable "bind_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cloud resource instance to be bound."
    },
    "Label": {
      "en": "BindInstanceId",
      "zh-cn": "待绑定的云资源实例ID"
    }
  }
  EOT
}

variable "bind_instance_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The region ID of the cloud resource instance to be bound."
    },
    "Label": {
      "en": "BindInstanceRegionId",
      "zh-cn": "待绑定的云资源实例地域ID"
    }
  }
  EOT
}

variable "bind_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The cloud resource instance type to be bound. Valid value: SlbInstance, SLB instance of private network type."
    },
    "Label": {
      "en": "BindInstanceType",
      "zh-cn": "待绑定的云资源实例类型"
    }
  }
  EOT
}

variable "anycast_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Anycast EIP instance ID."
    },
    "Label": {
      "en": "AnycastId",
      "zh-cn": "Anycast EIP实例ID"
    }
  }
  EOT
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "anycasteipassociation" {
  bind_instance_id        = var.bind_instance_id
  bind_instance_region_id = var.bind_instance_region_id
  bind_instance_type      = var.bind_instance_type
  anycast_id              = var.anycast_id
}

output "bind_instance_id" {
  value       = alicloud_eipanycast_anycast_eip_address_attachment.anycasteipassociation.bind_instance_id
  description = "The ID of the cloud resource instance to be bound."
}

output "bind_instance_region_id" {
  value       = alicloud_eipanycast_anycast_eip_address_attachment.anycasteipassociation.bind_instance_region_id
  description = "The region ID of the cloud resource instance to be bound."
}

output "bind_instance_type" {
  value       = alicloud_eipanycast_anycast_eip_address_attachment.anycasteipassociation.bind_instance_type
  description = "The cloud resource instance type to be bound."
}

output "anycast_id" {
  value       = alicloud_eipanycast_anycast_eip_address_attachment.anycasteipassociation.anycast_id
  description = "Anycast EIP instance ID."
}

