variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Group.It must be 4 to 128 characters in length, and can contain letters, digits, underscores (_), dashes (-), spaces and dots (.), It must start with a letter."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "API分组名称"
    }
  }
  EOT
}

variable "internet_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enable or disable internet subdomain. True for enable. "
    },
    "Label": {
      "en": "InternetEnable",
      "zh-cn": "是否启用公网子域名"
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
      "en": "Description of the Group, less than 180 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "API分组描述"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "API gateway instance ID. For example, \"api-shared-vpc-001\" means vpc instance, while \"api-shared-classic-001\" means classic instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "API网关实例类型"
    }
  }
  EOT
}

variable "vpc_intranet_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enable or disable VPC intranet subdomain. True for enable. "
    },
    "Label": {
      "en": "VpcIntranetEnable",
      "zh-cn": "是否启用私网子域名"
    }
  }
  EOT
}

variable "base_path" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The base path of API."
    },
    "Label": {
      "en": "BasePath",
      "zh-cn": "API根路径"
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
      "en": "Tags to attach to group. Max support 20 tags to add during create group. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "passthrough_headers" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Pass through headers setting. values:\nhost: pass through host headers"
    },
    "Label": {
      "en": "PassthroughHeaders",
      "zh-cn": "配置透传"
    }
  }
  EOT
}

resource "alicloud_api_gateway_group" "group" {
  name        = var.group_name
  description = var.description
  instance_id = var.instance_id
  base_path   = var.base_path
}

output "sub_domain" {
  value       = alicloud_api_gateway_group.group.sub_domain
  description = "The sub domain assigned to the Group by the system"
}

output "tags" {
  // Could not transform ROS Attribute Tags to Terraform attribute.
  value       = null
  description = "Tags of app"
}

output "group_id" {
  value       = alicloud_api_gateway_group.group.id
  description = "The id of the created Group resource"
}

