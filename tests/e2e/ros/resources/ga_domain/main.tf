variable "accelerator_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of the GA instance to be disassociated."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the GA instance to be disassociated. You can specify up to 50 IDs."
    },
    "Label": {
      "en": "AcceleratorIds",
      "zh-cn": "全球加速实例 ID列表"
    },
    "MinLength": 1,
    "MaxLength": 50
  }
  EOT
}

variable "domain" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The accelerated domain name to be disassociated."
    },
    "Label": {
      "en": "Domain",
      "zh-cn": "待添加的加速域名"
    }
  }
  EOT
}

resource "alicloud_ga_domain" "extension_resource" {
  domain = var.domain
}

output "accelerator_ids" {
  // Could not transform ROS Attribute AcceleratorIds to Terraform attribute.
  value       = null
  description = "The IDs of GA instances."
}

output "domain" {
  value       = alicloud_ga_domain.extension_resource.domain
  description = "The accelerated domain name."
}

