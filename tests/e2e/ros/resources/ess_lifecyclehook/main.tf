variable "lifecycle_hook_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the lifecycle hook. Each name must be unique within a scaling group. The name must be 2 to 64 characters in length and can contain letters, numbers, Chinese characters, and special characters including underscores (_), hyphens (-) and periods (.).\nDefault value: Lifecycle Hook ID",
      "zh-cn": "生命周期挂钩名称，不能与当前伸缩组其他生命周期挂钩重名。"
    },
    "AllowedPattern": "^[a-zA-Z0-9\\u4e00-\\u9fa5][-_.a-zA-Z0-9\\u4e00-\\u9fa5]{1,63}$",
    "Label": {
      "en": "LifecycleHookName",
      "zh-cn": "生命周期挂钩名称"
    }
  }
  EOT
}

variable "notification_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Alibaba Cloud Resource Name (ARN) of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This target can be either an MNS queue or an MNS topic. The format of the parameter value is acs:ess:{region}:{account-id}:{resource-relative-id}.\nregion: the region to which the scaling group locates\naccount-id: Alibaba Cloud ID\nFor example:\nMNS queue: acs:ess:{region}:{account-id}:queue/{queuename}\nMNS topic: acs:ess:{region}:{account-id}:topic/{topicname}\nOOS template: acs:ess:{region}:{account-id}:oos/{templatename}"
    },
    "AllowedPattern": "^acs:ess:([a-zA-Z0-9-]+):(\\d+):(queue|topic|oos)/([a-zA-Z0-9][-_a-zA-Z0-9]{0,255})$",
    "Label": {
      "en": "NotificationArn",
      "zh-cn": "生命周期挂钩通知对象标识符"
    },
    "MaxLength": 300
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the scaling group."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩组ID"
    }
  }
  EOT
}

variable "lifecycle_transition" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "SCALE_OUT",
      "SCALE_IN"
    ],
    "Description": {
      "en": "The scaling activities to which lifecycle hooks apply Value range:\n SCALE_OUT: scale-out event\n SCALE_IN: scale-in event"
    },
    "Label": {
      "en": "LifecycleTransition",
      "zh-cn": "生命周期挂钩适用的伸缩活动类型"
    }
  }
  EOT
}

variable "heartbeat_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The time, in seconds, that can elapse before the lifecycle hook times out. If the lifecycle hook times out, the scaling group performs the default action (DefaultResult). The range is from 30 to 86400 seconds. The default value is 600 seconds.\nYou can prevent the lifecycle hook from timing out by calling the RecordLifecycleActionHeartbeat operation. You can also terminate the lifecycle action by calling the CompleteLifecycleAction operation.",
      "zh-cn": "生命周期挂钩为伸缩组活动设置的等待时间，等待状态超时后会执行下一步动作。创建了生命周期挂钩后，您可以调用RecordLifecycleActionHeartbeat接口延长ECS实例的等待时间，也可以调用CompleteLifecycleAction接口提前结束伸缩活动的等待状态。"
    },
    "MinValue": 30,
    "Label": {
      "en": "HeartbeatTimeout",
      "zh-cn": "生命周期挂钩为伸缩组活动设置的等待时间"
    },
    "MaxValue": 86400
  }
  EOT
}

variable "notification_metadata" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The fixed string that you want to include when Auto Scaling sends a message about the wait state of the scaling activity to the notification target. The length of the parameter can be up to 4096 characters. Auto Scaling will send the specified NotificationMetadata parameter along with the notification message so that you can easily categorize your notifications. The NotificationMetadata parameter will only take effect after you specify the NotificationArn parameter."
    },
    "Label": {
      "en": "NotificationMetadata",
      "zh-cn": "伸缩活动的等待状态的固定字符串信息"
    },
    "MaxLength": 4096
  }
  EOT
}

variable "default_result" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The action that the scaling group takes when the lifecycle hook times out. Value range:\n CONTINUE: the scaling group continues with the scale-in or scale-out process.\n ABANDON: the scaling group stops any remaining action of the scale-in or scale-out event.\nDefault value: CONTINUE\nIf the scaling group has multiple lifecycle hooks and one of them is terminated by the DefaultResult=ABANDON parameter during a scale-in event (SCALE_IN), the remaining lifecycle hooks under the same scaling group will also be terminated. Otherwise, the action following the wait state is the next action, as specified in the parameter DefaultResult, after the last lifecycle event under the same scaling group.",
      "zh-cn": "等待状态结束后的下一步动作。当伸缩组发生弹性收缩活动（SCALE_IN）并触发多个生命周期挂钩时，DefaultResult=ABANDON的生命周期挂钩触发的等待状态结束时，会提前将其他对应的等待状态提前结束。其他情况下，下一步动作均以最后一个结束等待状态的下一步动作为准。"
    },
    "AllowedValues": [
      "CONTINUE",
      "ABANDON",
      "ROLLBACK"
    ],
    "Label": {
      "en": "DefaultResult",
      "zh-cn": "等待状态结束后的下一步动作"
    }
  }
  EOT
}

resource "alicloud_ess_lifecycle_hook" "lifecycle_hook" {
  name                  = var.lifecycle_hook_name
  notification_arn      = var.notification_arn
  scaling_group_id      = var.scaling_group_id
  lifecycle_transition  = var.lifecycle_transition
  heartbeat_timeout     = var.heartbeat_timeout
  notification_metadata = var.notification_metadata
  default_result        = var.default_result
}

output "scaling_group_id" {
  value       = alicloud_ess_lifecycle_hook.lifecycle_hook.scaling_group_id
  description = "The id of the scaling group to which the lifecycle hook belongs."
}

output "lifecycle_hook_id" {
  value       = alicloud_ess_lifecycle_hook.lifecycle_hook.id
  description = "The lifecycle hook ID"
}

