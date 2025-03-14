variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the network instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "网络实例ID"
    }
  }
  EOT
}

variable "cen_owner_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The UID of the account to which the target CEN instance belongs."
    },
    "Label": {
      "en": "CenOwnerId",
      "zh-cn": "要授权的云企业网实例所属账号的UID"
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
      "en": "The ID of the CEN instance to be authorized."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "要授权的云企业网的实例ID"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "CCN",
      "VBR",
      "VPC"
    ],
    "Description": {
      "en": "The type of the network instance. Valid values:\nVPC: Virtual Private Cloud (VPC).\nVBR: Virtual Border Router (VBR).\nCCN: Cloud Connect Network (CCN)."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "网络实例类型"
    }
  }
  EOT
}

resource "alicloud_cen_instance_grant" "grant_instance_to_cen" {
  cen_owner_id = var.cen_owner_id
  cen_id       = var.cen_id
}

output "instance_id" {
  // Could not transform ROS Attribute InstanceId to Terraform attribute.
  value       = null
  description = "The ID of the network instance."
}

output "cen_id" {
  value       = alicloud_cen_instance_grant.grant_instance_to_cen.cen_id
  description = "The ID of the CEN instance to be authorized."
}

