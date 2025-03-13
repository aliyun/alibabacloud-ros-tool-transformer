variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The default instance name prefix. The instance name prefix must be 2 to 50 characters in length. It must start with a letter and cannot start with http:// or https://. It can contain letters, digits, periods (.), underscores (_), hyphens (-), and colons (:). If you use the activation code that is created by calling this operation (CreateActivation) to register managed instances, the instances are assigned sequential names that are prefixed by the value of this parameter. You can also specify a new instance name to replace the assigned sequential name when you register a managed instance.If you specify InstanceName when you register a managed instance, an instance name in theformat of <InstanceName>-<Number> is generated. The number of digits in the <Number> value isdetermined by that in the InstanceCount value. Example: 001. If you do not specify InstanceName, the hostname (Hostname) is used as the instance name."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "默认的实例名称前缀"
    }
  }
  EOT
}

variable "instance_count" {
  type        = number
  default     = 10
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of times that you can use the activation code to register managed instances. Valid values: 1 to 1000.Default value: 10."
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceCount",
      "zh-cn": "激活码用于注册托管实例的使用次数上限"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the activation code. It must be 1 to 100 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "激活码对应的描述"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group."
    }
  }
  EOT
}

variable "time_to_live_in_hours" {
  type        = number
  default     = 4
  description = <<EOT
  {
    "Description": {
      "en": "The validity period of the activation code. The activation code can no longer be used to register instances after the period ends. Unit: hours. Valid values: 1 to 876576, which represents a range of time from 1 hour to 100 years.Default value: 4."
    },
    "MinValue": 1,
    "Label": {
      "en": "TimeToLiveInHours",
      "zh-cn": "激活码的有效使用时间"
    },
    "MaxValue": 876576
  }
  EOT
}

variable "ip_address_range" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP addresses of hosts that are allowed to use the activation code. The value can be IPv4 addresses, IPv6 addresses, or CIDR blocks."
    },
    "Label": {
      "en": "IpAddressRange",
      "zh-cn": "允许使用该激活码的主机IP"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_activation" "activation" {
  instance_name         = var.instance_name
  instance_count        = var.instance_count
  description           = var.description
  time_to_live_in_hours = var.time_to_live_in_hours
  ip_address_range      = var.ip_address_range
}

output "deregistered_count" {
  // Could not transform ROS Attribute DeregisteredCount to Terraform attribute.
  value       = null
  description = "The number of instances that have been logged out."
}

output "activation_id" {
  value       = alicloud_ecs_activation.activation.id
  description = "Activation code ID."
}

output "registered_count" {
  // Could not transform ROS Attribute RegisteredCount to Terraform attribute.
  value       = null
  description = "The number of registered instances."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "activation_code" {
  // Could not transform ROS Attribute ActivationCode to Terraform attribute.
  value       = null
  description = "Activation code."
}

