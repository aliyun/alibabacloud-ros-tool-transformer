variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance. You can call the DescribeInstances operation to query the ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "retention" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The retention period of audit logs. Valid values: 1 to 365. Unit: days.\nNote: The value of this parameter takes effect for all ApsaraDB for Redis instances in the current region."
    },
    "MinValue": 1,
    "Label": {
      "en": "Retention",
      "zh-cn": "审计日志保留天数"
    },
    "MaxValue": 365
  }
  EOT
}

resource "alicloud_kvstore_audit_log_config" "audit_log_config" {
  instance_id = var.instance_id
  retention   = var.retention
}

output "instance_id" {
  value       = alicloud_kvstore_audit_log_config.audit_log_config.id
  description = "IP address whitelist to be modified"
}

