variable "cen_uid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the account to which the CEN instance belongs."
    },
    "Label": {
      "en": "CenUid",
      "zh-cn": "云企业网的UID"
    }
  }
  EOT
}

variable "ccn_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CCN instance."
    },
    "Label": {
      "en": "CcnInstanceId",
      "zh-cn": "云连接网的实例ID"
    }
  }
  EOT
}

variable "cen_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CEN instance."
    },
    "Label": {
      "en": "CenInstanceId",
      "zh-cn": "云企业网实例的ID"
    }
  }
  EOT
}

resource "alicloud_cloud_connect_network_grant" "grant_ccn_to_cen" {
  cen_uid = var.cen_uid
}

output "ccn_instance_id" {
  value       = alicloud_cloud_connect_network_grant.grant_ccn_to_cen.ccn_id
  description = "The ID of the CCN instance."
}

output "cen_instance_id" {
  value       = alicloud_cloud_connect_network_grant.grant_ccn_to_cen.cen_id
  description = "The ID of the CEN instance."
}

