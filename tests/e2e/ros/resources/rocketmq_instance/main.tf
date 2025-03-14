variable "instance_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the instance, which contains 3 to 64 characters in Chinese or English."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    },
    "MinLength": 3,
    "MaxLength": 64
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether delete all topics and groups of the instance and then delete instance. Default is false"
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除"
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remark of instance."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "备注"
    }
  }
  EOT
}

resource "alicloud_ons_instance" "instance" {
  instance_name = var.instance_name
  tags          = var.tags
  remark        = var.remark
}

output "instance_name" {
  value       = alicloud_ons_instance.instance.instance_name
  description = "Instance name"
}

output "http_internal_endpoint" {
  // Could not transform ROS Attribute HttpInternalEndpoint to Terraform attribute.
  value       = null
  description = "The internal HTTP endpoint for the Message Queue for Apache RocketMQ instance."
}

output "instance_id" {
  value       = alicloud_ons_instance.instance.id
  description = "Instance ID created"
}

output "tcp_endpoint" {
  // Could not transform ROS Attribute TcpEndpoint to Terraform attribute.
  value       = null
  description = "The TCP endpoint for the Message Queue for Apache RocketMQ instance."
}

output "http_internet_endpoint" {
  // Could not transform ROS Attribute HttpInternetEndpoint to Terraform attribute.
  value       = null
  description = "The Internet HTTP endpoint for the Message Queue for Apache RocketMQ instance."
}

output "instance_type" {
  value       = alicloud_ons_instance.instance.instance_type
  description = "Instance Type"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "http_internet_secure_endpoint" {
  // Could not transform ROS Attribute HttpInternetSecureEndpoint to Terraform attribute.
  value       = null
  description = "The Internet HTTPS endpoint for the Message Queue for Apache RocketMQ instance."
}

