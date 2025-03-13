variable "default_rule" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to set the defense rule as the default rule. \nValid values:\n- true: yes\n- false: no"
    },
    "Label": {
      "en": "DefaultRule",
      "zh-cn": "防暴力破解规则是否设置为默认规则"
    }
  }
  EOT
}

variable "anti_brute_force_rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the defense rule."
    },
    "Label": {
      "en": "AntiBruteForceRuleName",
      "zh-cn": "防暴力破解规则的名称"
    }
  }
  EOT
}

variable "forbidden_time" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      5,
      15,
      30,
      60,
      120,
      360,
      720,
      1440,
      10080,
      52560000
    ],
    "Description": {
      "en": "The period of time during which logons from an account are not allowed.\nUnit: minutes. Valid values:\n- 5: 5 minutes\n- 15: 15 minutes\n- 30: 30 minutes\n- 60: 1 hour\n- 120: 2 hours\n- 360: 6 hours\n- 720: 12 hours\n- 1440: 24 hours\n- 10080: 7 days\n- 52560000: permanent"
    },
    "Label": {
      "en": "ForbiddenTime",
      "zh-cn": "设置禁止账号登录的时长"
    }
  }
  EOT
}

variable "uuid_list" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The UUID of the server that configures the brute-force defense rule."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The UUIDs of the servers to which you want to apply the defense rule."
    },
    "Label": {
      "en": "UuidList",
      "zh-cn": "防暴力破解规则生效的服务器的UUID列表"
    }
  }
  EOT
}

variable "fail_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      2,
      3,
      4,
      5,
      10,
      50,
      80,
      100
    ],
    "Description": {
      "en": "The maximum number of failed logon attempts from an account. \nValid values: 2, 3, 4, 5, 10, 50, 80, and 100."
    },
    "Label": {
      "en": "FailCount",
      "zh-cn": "设置账号登录失败次数的阈值"
    }
  }
  EOT
}

variable "span" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      1,
      2,
      5,
      10,
      15
    ],
    "Description": {
      "en": "The maximum period of time during which failed logon attempts from an account can occur.\nUnit: minutes. Valid values:\n- 1\n- 2\n- 5\n- 10\n- 15"
    },
    "Label": {
      "en": "Span",
      "zh-cn": "设置账号登录失败的时间的阈值"
    }
  }
  EOT
}

resource "alicloud_threat_detection_anti_brute_force_rule" "extension_resource" {
  default_rule               = var.default_rule
  anti_brute_force_rule_name = var.anti_brute_force_rule_name
  forbidden_time             = var.forbidden_time
  uuid_list                  = var.uuid_list
  fail_count                 = var.fail_count
  span                       = var.span
}

output "default_rule" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.default_rule
  description = <<EOT
  "Specifies whether to set the defense rule as the default rule. \nValid values:\n- true: yes\n- false: no"
  EOT
}

output "anti_brute_force_rule_name" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.anti_brute_force_rule_name
  description = "The name of the defense rule."
}

output "forbidden_time" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.forbidden_time
  description = "The period of time during which logons from an account are not allowed. Unit: minutes."
}

output "anti_brute_force_rule_id" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.id
  description = "The ID of the defense rule."
}

output "uuid_list" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.uuid_list
  description = "The UUIDs of the server to which the defense rule is applied."
}

output "fail_count" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.fail_count
  description = "The threshold for the number of failed user logins when the brute-force defense rule takes effect."
}

output "span" {
  value       = alicloud_threat_detection_anti_brute_force_rule.extension_resource.span
  description = "The period of time during which logon failures from an account are measured. Unit: minutes. If Span is set to 10, the defense rule takes effect when the logon failures measured within 10 minutes reaches the specified threshold. The IP addresses of attackers cannot be used to log on to the server within the specified period of time."
}

