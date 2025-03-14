variable "child_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "VPC",
      "VBR",
      "CCN"
    ],
    "Description": {
      "en": "The type of the network to attach. Support VPC, VBR or CCN."
    },
    "Label": {
      "en": "ChildInstanceType",
      "zh-cn": "网络实例的类型"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CEN instance."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例的ID"
    }
  }
  EOT
}

variable "child_instance_owner_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The account ID to which the network belongs.",
      "zh-cn": "跨账号加载场景下，网络实例所属账号的UID。"
    },
    "Label": {
      "en": "ChildInstanceOwnerId",
      "zh-cn": "跨账号加载场景下"
    }
  }
  EOT
}

variable "child_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the network to attach."
    },
    "Label": {
      "en": "ChildInstanceId",
      "zh-cn": "指定待加载的网络实例的ID"
    }
  }
  EOT
}

variable "child_instance_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region where the network is located. The ID of the region where the network is located."
    },
    "Label": {
      "en": "ChildInstanceRegionId",
      "zh-cn": "网络实例所在的地域"
    }
  }
  EOT
}

resource "alicloud_cen_instance_attachment" "cen_instance_attachment" {
  child_instance_type      = var.child_instance_type
  instance_id              = var.cen_id
  child_instance_owner_id  = var.child_instance_owner_id
  child_instance_id        = var.child_instance_id
  child_instance_region_id = var.child_instance_region_id
}

