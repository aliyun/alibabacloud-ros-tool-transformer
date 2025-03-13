variable "parameters" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ParamValue": {
          "Type": "String",
          "Description": {
            "en": "Parameter value."
          },
          "Required": true
        },
        "ParamName": {
          "Type": "String",
          "Description": {
            "en": "Parameter name."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of the parameters."
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "参数详情列表"
    }
  }
  EOT
}

variable "db_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of the database engine."
    },
    "Label": {
      "en": "DbVersion",
      "zh-cn": "数据库引擎版本号"
    }
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
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "parameter_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the parameter template."
    },
    "Label": {
      "en": "ParameterGroupName",
      "zh-cn": "参数模板的名称"
    }
  }
  EOT
}

variable "parameter_group_desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the parameter template."
    },
    "Label": {
      "en": "ParameterGroupDesc",
      "zh-cn": "参数模板的描述"
    }
  }
  EOT
}

variable "db_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the database engine."
    },
    "Label": {
      "en": "DbType",
      "zh-cn": "数据库引擎类型"
    }
  }
  EOT
}

resource "alicloud_polardb_parameter_group" "extension_resource" {
  parameters  = var.parameters
  db_version  = var.db_version
  name        = var.parameter_group_name
  description = var.parameter_group_desc
  db_type     = var.db_type
}

output "parameters" {
  value       = alicloud_polardb_parameter_group.extension_resource.parameters
  description = "The list of the parameters."
}

output "parameter_group_id" {
  value       = alicloud_polardb_parameter_group.extension_resource.id
  description = "The ID of the parameter group."
}

output "db_version" {
  value       = alicloud_polardb_parameter_group.extension_resource.db_version
  description = "The version of the database engine."
}

output "force_restart" {
  // Could not transform ROS Attribute ForceRestart to Terraform attribute.
  value       = null
  description = "Indicates whether to restart the cluster when this parameter template is applied."
}

output "parameter_group_name" {
  value       = alicloud_polardb_parameter_group.extension_resource.name
  description = "The name of the parameter template."
}

output "parameter_group_desc" {
  value       = alicloud_polardb_parameter_group.extension_resource.description
  description = "The description of the parameter template."
}

output "parameter_group_type" {
  // Could not transform ROS Attribute ParameterGroupType to Terraform attribute.
  value       = null
  description = "The type of the parameter template."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The time when the parameter template was created."
}

output "parameter_counts" {
  // Could not transform ROS Attribute ParameterCounts to Terraform attribute.
  value       = null
  description = "The number of parameters in the parameter template."
}

output "db_type" {
  value       = alicloud_polardb_parameter_group.extension_resource.db_type
  description = "The type of the database engine."
}

