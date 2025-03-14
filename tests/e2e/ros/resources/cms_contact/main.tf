variable "describe" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The description of the alert contact."
    },
    "Label": {
      "en": "Describe",
      "zh-cn": "描述详情"
    }
  }
  EOT
}

variable "contact_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the alarm contact."
    },
    "Label": {
      "en": "ContactName",
      "zh-cn": "报警联系人姓名"
    }
  }
  EOT
}

variable "channels" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Mail": {
          "Type": "String",
          "Description": {
            "en": "The email address of the contact."
          },
          "Required": false
        },
        "AliIM": {
          "Type": "String",
          "Description": {
            "en": "The TradeManager ID."
          },
          "Required": false
        },
        "DingWebHook": {
          "Type": "String",
          "Description": {
            "en": "The DingTalk Chatbot address."
          },
          "Required": false
        },
        "SMS": {
          "Type": "String",
          "Description": {
            "en": "The mobile phone number of the contact."
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "Channels",
      "zh-cn": "联系方式"
    }
  }
  EOT
}

resource "alicloud_cms_alarm_contact" "contact" {
  describe = var.describe
}

output "contact_name" {
  value       = alicloud_cms_alarm_contact.contact.id
  description = "The name of the alarm contact."
}

