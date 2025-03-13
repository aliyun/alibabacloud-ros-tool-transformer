variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of IPv6 gateway.\nLength of 2 to 256 characters, must begin with a letter or Chinese, may contain numbers, numbers, underscore (_) and dot dash (-), but not at the http (.): // or https: // at the beginning ."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "IPv6网关的描述信息"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "To open VPC ID IPv6 gateway."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "要开通IPv6网关的专有网络ID"
    }
  }
  EOT
}

variable "spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifications IPv6 gateway, the value:\nSmall (default): Free.\nMedium: Enterprise Edition.\nLarge: Enterprise Enhanced Edition.\nDifferent specifications of the IPv6 forwarding capability of the gateway is different. For more information, see IPv6 gateway specification."
    },
    "Label": {
      "en": "Spec",
      "zh-cn": "IPv6网关的规格"
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

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of the IPv6 gateway.\nLength of 2 to 128 characters, beginning with a letter or Chinese, can contain numbers, dot, underscore (_) and dash (-), but not at http (.): // or with https: // ."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "IPv6网关的名称"
    }
  }
  EOT
}

resource "alicloud_vpc_ipv6_gateway" "ipv6_gateway" {
  description = var.description
  vpc_id      = var.vpc_id
  spec        = var.spec
  tags        = var.tags
}

output "ipv6_gateway_id" {
  value       = alicloud_vpc_ipv6_gateway.ipv6_gateway.id
  description = "ID IPv6 gateway."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

