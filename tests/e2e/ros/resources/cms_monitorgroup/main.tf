variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the application group."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "应用分组名称"
    }
  }
  EOT
}

variable "contact_groups" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The alert contact group. Alert notifications for the application group are sent to\nthe specified alert contact group.",
      "zh-cn": "报警联系人组。应用分组的报警通知会发送给此处指定的报警联系人组。"
    },
    "Label": {
      "en": "ContactGroups",
      "zh-cn": "报警联系人组"
    }
  }
  EOT
}

resource "alicloud_cms_monitor_group" "monitor_group" {}

output "group_id" {
  value       = alicloud_cms_monitor_group.monitor_group.id
  description = "Application group ID generated after the group is created. "
}

