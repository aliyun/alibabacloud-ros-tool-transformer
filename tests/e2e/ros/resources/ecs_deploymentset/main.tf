variable "on_unable_to_redeploy_failed_instance" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The emergency solution to redeploy failed instances in the deployment set. Valid values:\nCancelMembershipAndStart: restarts the instances immediately after they are shut down\nand migrated to other deployment sets. This is the default value.\nKeepStopped: keeps the instances shut down and restarts them after the deployment\nset is replenished.",
      "zh-cn": "部署集内实例宕机迁移后，缺乏可供打散的实例库存的紧急处理方案。"
    },
    "AllowedValues": [
      "CancelMembershipAndStart",
      "KeepStopped"
    ],
    "Label": {
      "en": "OnUnableToRedeployFailedInstance",
      "zh-cn": "部署集内实例宕机迁移后"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the deployment set. It must be 2 to 256 characters in length. It\ncannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "部署集描述信息"
    }
  }
  EOT
}

variable "group_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Set the number of groups for the deployment set group high availability policy. Value range: 1~7.\nDefault value: 3.\nThis parameter only takes effect when Strategy=AvailabilityGroup."
    },
    "MinValue": 1,
    "Label": {
      "en": "GroupCount",
      "zh-cn": "为部署集组高可用策略设置分组数量"
    },
    "MaxValue": 7
  }
  EOT
}

variable "strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Deployment strategy. Ranges:\nAvailability: High availability strategy.\nAvailabilityGroup: Deployment group high availability strategy.\nLowLatency: Network low latency strategy."
    },
    "AllowedValues": [
      "Availability",
      "AvailabilityGroup",
      "LowLatency"
    ],
    "Label": {
      "en": "Strategy",
      "zh-cn": "部署策略"
    }
  }
  EOT
}

variable "deployment_set_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the deployment set. It must be 2 to 128 characters in length. It must\nstart with a letter and cannot start with http:// or https://. It can contain letters,\ndigits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "DeploymentSetName",
      "zh-cn": "部署集名称"
    }
  }
  EOT
}

resource "alicloud_ecs_deployment_set" "deployment_set" {
  on_unable_to_redeploy_failed_instance = var.on_unable_to_redeploy_failed_instance
  description                           = var.description
  strategy                              = var.strategy
  deployment_set_name                   = var.deployment_set_name
}

output "deployment_set_id" {
  value       = alicloud_ecs_deployment_set.deployment_set.id
  description = "The ID of the deployment set."
}

