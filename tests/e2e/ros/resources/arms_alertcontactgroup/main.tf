variable "proxy_user_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Internal parameters"
    }
  }
  EOT
}

variable "contact_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the alert contact group that you want to create."
    },
    "Label": {
      "en": "ContactGroupName",
      "zh-cn": "报警联系人分组名称"
    }
  }
  EOT
}

variable "region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Region ID. Default to region of stack.",
      "zh-cn": "地域ID。默认为资源栈的地域ID。"
    },
    "AllowedValues": [
      "cn-qingdao",
      "cn-beijing",
      "cn-shanghai",
      "cn-hangzhou",
      "cn-shenzhen",
      "cn-hongkong",
      "ap-southeast-1"
    ],
    "Label": {
      "en": "RegionId",
      "zh-cn": "地域ID"
    }
  }
  EOT
}

variable "contact_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "Number",
        "Description": {
          "en": "Alert contact ID"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The list of alert contact ID. "
    },
    "Label": {
      "en": "ContactIds",
      "zh-cn": "报警联系人分组内的联系人ID"
    }
  }
  EOT
}

resource "alicloud_arms_alert_contact_group" "alert_contact_group" {
  contact_ids = var.contact_ids
}

output "contact_group_id" {
  value       = alicloud_arms_alert_contact_group.alert_contact_group.id
  description = "The ID of the alert contact group that you created."
}

