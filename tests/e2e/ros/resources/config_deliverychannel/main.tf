variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the delivery method."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "投递渠道描述"
    }
  }
  EOT
}

variable "delivery_channel_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the delivery method."
    },
    "Label": {
      "en": "DeliveryChannelName",
      "zh-cn": "投递渠道名称"
    }
  }
  EOT
}

variable "delivery_channel_target_arn" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ARN of the delivery destination. This parameter is required when you create a\ndelivery method. The value must be in one of the following formats:\nacs:oss:{RegionId}:{Aliuid}:{bucketName} if your delivery destination is an Object Storage Service (OSS) bucket.\nacs:mns:{RegionId}:{Aliuid}:/topics/{topicName} if your delivery destination is a Message Service (MNS) topic.\nacs:log:{RegionId}:{Aliuid}:project/{projectName}/logstore/{logstoreName} if your delivery destination is a Log Service Logstore."
    },
    "Label": {
      "en": "DeliveryChannelTargetArn",
      "zh-cn": "投递渠道目标地址的ARN"
    }
  }
  EOT
}

variable "delivery_channel_assume_role_arn" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Alibaba Cloud Resource Name (ARN) of the role to be assumed by the delivery method.\nThis parameter is required when you create a delivery method.\nNote If the delivery method assumes the service linked role for Cloud Config, you can specify\nthe ARN in the format of the provided example and replace the account ID with the\nID of your Alibaba Cloud account."
    },
    "Label": {
      "en": "DeliveryChannelAssumeRoleArn",
      "zh-cn": "投递角色ARN"
    }
  }
  EOT
}

variable "delivery_channel_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "MNS",
      "OSS",
      "SLS"
    ],
    "Description": {
      "en": "The type of the delivery method. This parameter is required when you create a delivery\nmethod. Valid values:\nOSS\nMNS\nSLS"
    },
    "Label": {
      "en": "DeliveryChannelType",
      "zh-cn": "投递渠道类型"
    }
  }
  EOT
}

variable "delivery_channel_condition" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule attached to the delivery method. This parameter is applicable only to delivery\nmethods of the MNS type.\nThis parameter allows you to specify the lowest risk level for the events to subscribe\nto and the resource types for which you want to subscribe to events.\nTo specify the lowest risk level for the events to subscribe to, use the following\nformat:{\"filterType\":\"RuleRiskLevel\",\"value\":\"1\",\"multiple\":false}.\nThe value field indicates the lowest risk level and can be set to 1, 2, or 3, which\nindicates the high risk level, the medium risk level, and the low risk level, respectively.\nTo specify the resource types for which you want to subscribe to events, use the following\nformat:{\"filterType\":\"ResourceType\",\"values\":[\"ACS::ACK::Cluster\",\"ACS::ActionTrail::Trail\",\"ACS::CBWP::CommonBandwidthPackage\"],\"multiple\":true}.\nThe values field indicates the resource types. Its value is a JSON array.\nExample: [{\"filterType\":\"ResourceType\",\"values\":[\"ACS::ActionTrail::Trail\",\"ACS::CBWP::CommonBandwidthPackage\",\"ACS::CDN::Domain\",\"ACS::CEN::CenBandwidthPackage\",\"ACS::CEN::CenInstance\",\"ACS::CEN::Flowlog\",\"ACS::DdosCoo::Instance\"],\"multiple\":true}]"
    },
    "Label": {
      "en": "DeliveryChannelCondition",
      "zh-cn": "投递渠道附加规则"
    }
  }
  EOT
}

resource "alicloud_config_delivery_channel" "delivery_channel" {
  description                      = var.description
  delivery_channel_name            = var.delivery_channel_name
  delivery_channel_target_arn      = var.delivery_channel_target_arn
  delivery_channel_assume_role_arn = var.delivery_channel_assume_role_arn
  delivery_channel_type            = var.delivery_channel_type
  delivery_channel_condition       = var.delivery_channel_condition
}

output "delivery_channel_id" {
  value       = alicloud_config_delivery_channel.delivery_channel.id
  description = "The ID of the delivery method. "
}

