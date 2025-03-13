variable "auto_renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The auto-renewal period. This parameter is required only when you set AutoRenew to true. Unit: months. Valid values: 1, 3, 6, 12, 24, and 36."
    },
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "自动续费的时长"
    }
  }
  EOT
}

variable "plan_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The plan ID. You can call the ListPlans operation to query all plans provided by Simple Application Server in the specified region."
    },
    "Label": {
      "en": "PlanId",
      "zh-cn": "套餐ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal. Valid values:\ntrue\nfalse\nDefault value: false."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否开启到期自动续费"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The image ID. You can call the ListImages operation to query the available images in the specified region."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "period" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period of the servers. Unit: months. Valid values: 1, 3, 6, 12, 24, and 36."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "data_disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the data disk that is attached to the server. Unit: GB. Valid values: 0 to 16380. The value must be an integral multiple of 20.\nA value of 0 indicates that no data disk is attached.\nIf the disk included in the specified plan is a standard SSD, the data disk must be 20 GB or larger in size.\nDefault value: 0."
    },
    "Label": {
      "en": "DataDiskSize",
      "zh-cn": "挂载的数据盘容量大小"
    }
  }
  EOT
}

resource "alicloud_simple_application_server_instance" "instance" {
  auto_renew_period = var.auto_renew_period
  plan_id           = var.plan_id
  auto_renew        = var.auto_renew
  image_id          = var.image_id
  period            = var.period
  data_disk_size    = var.data_disk_size
}

output "public_ip_address" {
  // Could not transform ROS Attribute PublicIpAddress to Terraform attribute.
  value       = null
  description = "The public IP address of simple application server."
}

output "inner_ip_address" {
  // Could not transform ROS Attribute InnerIpAddress to Terraform attribute.
  value       = null
  description = "The inner IP address of simple application server."
}

output "instance_id" {
  value       = alicloud_simple_application_server_instance.instance.id
  description = "The ID of the simple application server."
}

