variable "describe" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The description of the alert contact group."
    },
    "Label": {
      "en": "Describe",
      "zh-cn": "报警联系组描述信息"
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
      "en": "The name of the alert contact group."
    },
    "Label": {
      "en": "ContactGroupName",
      "zh-cn": "报警联系组名称"
    }
  }
  EOT
}

variable "contact_names" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The name of the alert contact."
    },
    "Label": {
      "en": "ContactNames",
      "zh-cn": "报警联系人名称"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_cms_alarm_contact_group" "contact_group" {
  describe = var.describe
}

output "contact_group_name" {
  value       = alicloud_cms_alarm_contact_group.contact_group.id
  description = "The name of the alert contact group."
}

