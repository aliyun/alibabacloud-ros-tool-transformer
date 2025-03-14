variable "instance_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the instance."
    },
    "AllowedPattern": "[a-zA-Z][-a-zA-Z0-9]{1,14}[a-zA-Z0-9]",
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
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
      "en": "Instance description."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述"
    },
    "MaxLength": 256
  }
  EOT
}

variable "network" {
  type        = string
  default     = "NORMAL"
  description = <<EOT
  {
    "Description": {
      "en": "Instance network type, default is NORMAL."
    },
    "AllowedValues": [
      "NORMAL",
      "VPC",
      "VPC_CONSOLE"
    ],
    "Label": {
      "en": "Network",
      "zh-cn": "实例网络类型"
    }
  }
  EOT
}

variable "cluster_type" {
  type        = string
  default     = "SSD"
  description = <<EOT
  {
    "Description": {
      "en": "Cluster type, the default is SSD. \nThis parameter specifies the specification of the ots instance.\n When the value is SSD, the ots instance is a high-performance instance.\n When the value is Hybid, the ots instance is a capacity instance"
    },
    "AllowedValues": [
      "SSD",
      "HYBRID"
    ],
    "Label": {
      "en": "ClusterType",
      "zh-cn": "实例规格"
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
      "en": "Tags to attach to instance. Max support 5 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例标签"
    },
    "MaxLength": 5
  }
  EOT
}

resource "alicloud_ots_instance" "instance" {
  name          = var.instance_name
  description   = var.description
  accessed_by   = var.network
  instance_type = var.cluster_type
  tags          = var.tags
}

output "instance_name" {
  value       = alicloud_ots_instance.instance.id
  description = "Instance name"
}

output "vpc_endpoint" {
  // Could not transform ROS Attribute VpcEndpoint to Terraform attribute.
  value       = null
  description = "Vpc endpoint"
}

output "public_endpoint" {
  // Could not transform ROS Attribute PublicEndpoint to Terraform attribute.
  value       = null
  description = "Public endpoint"
}

output "private_endpoint" {
  // Could not transform ROS Attribute PrivateEndpoint to Terraform attribute.
  value       = null
  description = "Private endpoint"
}

