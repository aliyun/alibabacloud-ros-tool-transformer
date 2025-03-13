variable "sls_group_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the Logstore group."
    },
    "Label": {
      "en": "SlsGroupDescription",
      "zh-cn": "Logstore组描述"
    }
  }
  EOT
}

variable "sls_group_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SlsProject": {
          "Type": "String",
          "Description": {
            "en": "The Simple Log Service project."
          },
          "Required": true
        },
        "SlsRegion": {
          "Type": "String",
          "Description": {
            "en": "The region ID."
          },
          "Required": true
        },
        "SlsUserId": {
          "Type": "String",
          "Description": {
            "en": "The member ID. If you call this operation by using the management account of a resource directory, you can connect the Alibaba Cloud services that are activated for all members in the resource directory to Hybrid Cloud Monitoring. You can use the resource directory to monitor Alibaba Cloud services across enterprise accounts.Note If a member uses CloudMonitor for the first time, you must make sure that the service-linked role AliyunServiceRoleForCloudMonitor is attached to the member. For more information, see Manage the service-linked role for CloudMonitor."
          },
          "Required": false
        },
        "SlsLogstore": {
          "Type": "String",
          "Description": {
            "en": "The Logstore."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The configurations of the Logstore group.Valid values of N: 1 to 25."
    },
    "Label": {
      "en": "SlsGroupConfig",
      "zh-cn": "Logstore组的配置信息"
    }
  }
  EOT
}

variable "sls_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Logstore group.The name must be 2 to 32 characters in length and can contain uppercase letters, lowercase letters, digits, and underscores (_). The name must start with a letter."
    },
    "Label": {
      "en": "SlsGroupName",
      "zh-cn": "Logstore组名称"
    }
  }
  EOT
}

resource "alicloud_cms_sls_group" "extension_resource" {
  sls_group_description = var.sls_group_description
  sls_group_config      = var.sls_group_config
  sls_group_name        = var.sls_group_name
}

output "sls_group_description" {
  value       = alicloud_cms_sls_group.extension_resource.sls_group_description
  description = "The description of the Logstore group."
}

output "sls_group_config" {
  value       = alicloud_cms_sls_group.extension_resource.sls_group_config
  description = "The configurations of the Logstore group."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The creation time of the Logstore group."
}

output "sls_group_name" {
  value       = alicloud_cms_sls_group.extension_resource.id
  description = "The name of the Logstore group."
}

