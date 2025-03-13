variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the ECS instance to be associated with the HAVIP."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "ECS实例ID"
    }
  }
  EOT
}

variable "ha_vip_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the HAVIP."
    },
    "Label": {
      "en": "HaVipId",
      "zh-cn": "高可用虚拟IP ID"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the instance to be associated with the HAVIP. Valid values:\nEcsInstance: an ECS instance\nNetworkInterface: an ENI. If you want to associate the HAVIP with an ENI, this parameter is required."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "要绑定 HaVip 的实例类型"
    }
  }
  EOT
}

resource "alicloud_havip_attachment" "ha_vip_association" {
  instance_id   = var.instance_id
  ha_vip_id     = var.ha_vip_id
  instance_type = var.instance_type
}

