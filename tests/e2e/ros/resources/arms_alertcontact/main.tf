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

variable "email" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The email address of the contact."
    },
    "Label": {
      "en": "Email",
      "zh-cn": "报警联系人邮箱"
    }
  }
  EOT
}

variable "ding_robot_webhook_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The DingTalk Chatbot address of the contact."
    },
    "Label": {
      "en": "DingRobotWebhookUrl",
      "zh-cn": "钉钉机器人Webhook URL"
    }
  }
  EOT
}

variable "phone_num" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The phone number of the contact."
    },
    "Label": {
      "en": "PhoneNum",
      "zh-cn": "报警联系人手机号码"
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

variable "system_noc" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to receive system alerts."
    },
    "Label": {
      "en": "SystemNoc",
      "zh-cn": "是否接收系统通知"
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
      "en": "The name of the alert contact that you want to create."
    },
    "Label": {
      "en": "ContactName",
      "zh-cn": "报警联系人姓名"
    }
  }
  EOT
}

resource "alicloud_arms_alert_contact" "alert_contact" {
  email                  = var.email
  ding_robot_webhook_url = var.ding_robot_webhook_url
  phone_num              = var.phone_num
  system_noc             = var.system_noc
}

output "contact_id" {
  value       = alicloud_arms_alert_contact.alert_contact.id
  description = "The ID of the alert contact that you created."
}

