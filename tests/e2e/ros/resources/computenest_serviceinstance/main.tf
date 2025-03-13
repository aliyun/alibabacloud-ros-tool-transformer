variable "specification_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Commodity specification Code."
    },
    "Label": {
      "en": "SpecificationCode",
      "zh-cn": "商品规格码"
    }
  }
  EOT
}

variable "parameters" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The parameters entered by the deployment service instance."
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "用户实例部署的参数"
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

variable "operation_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Change operation name."
    },
    "Label": {
      "en": "OperationName",
      "zh-cn": "操作名称"
    }
  }
  EOT
}

variable "enable_instance_ops" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the service instance has the O & M function. Possible values:\n- true: The service instance has a generation O & M function.\n- false: The service instance does not have the O & M function."
    },
    "Label": {
      "en": "EnableInstanceOps",
      "zh-cn": "服务实例是否有代运维功能"
    }
  }
  EOT
}

variable "service" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Version": {
          "Type": "String",
          "Description": {
            "en": "Service version."
          },
          "Required": false
        },
        "ServiceId": {
          "Type": "String",
          "Description": {
            "en": "The service ID."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Service details."
    },
    "Label": {
      "en": "Service",
      "zh-cn": "服务详情"
    }
  }
  EOT
}

variable "predefined_parameter_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Package name."
    },
    "Label": {
      "en": "PredefinedParameterName",
      "zh-cn": "套餐名称"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the service instance."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "服务名称"
    }
  }
  EOT
}

variable "commodity" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PayPeriod": {
          "Type": "Number",
          "Description": {
            "en": "Cloud Market Goods Purchase Duration."
          },
          "Required": false
        },
        "PayPeriodUnit": {
          "Type": "String",
          "Description": {
            "en": "Cloud market goods purchase time unit, possible value:\n- Month: monthly purchase\n- Year: buy on an annual basis."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Cloud market commodity purchase parameters.",
      "zh-cn": "云市场购买订单信息，服务未上云市场或按量计费不必传。"
    },
    "Label": {
      "en": "Commodity",
      "zh-cn": "云市场购买订单信息"
    }
  }
  EOT
}

variable "enable_user_prometheus" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether Prometheus monitoring is enabled. Possible values:\n- true: enabled.\n- false: not enabled."
    },
    "Label": {
      "en": "EnableUserPrometheus",
      "zh-cn": "是否启用Prometheus监控"
    }
  }
  EOT
}

variable "template_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Template name."
    },
    "Label": {
      "en": "TemplateName",
      "zh-cn": "模板名称"
    }
  }
  EOT
}

variable "market_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cloud marketplace instance."
    },
    "Label": {
      "en": "MarketInstanceId",
      "zh-cn": "云市场实例ID"
    }
  }
  EOT
}

variable "contact_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Alarm Contact Group."
    },
    "Label": {
      "en": "ContactGroup",
      "zh-cn": "接收告警的云监控联系人组"
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
      "en": "Tags of service instance."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_compute_nest_service_instance" "extension_resource" {
  resource_group_id      = var.resource_group_id
  enable_instance_ops    = var.enable_instance_ops
  enable_user_prometheus = var.enable_user_prometheus
  template_name          = var.template_name
  tags                   = var.tags
}

output "progress" {
  // Could not transform ROS Attribute Progress to Terraform attribute.
  value       = null
  description = "The deployment progress of the service instance. Unit:%."
}

output "parameters" {
  // Could not transform ROS Attribute Parameters to Terraform attribute.
  value       = null
  description = "The parameters entered by the deployment service instance."
}

output "resource_group_id" {
  value       = alicloud_compute_nest_service_instance.extension_resource.resource_group_id
  description = "The ID of the resource group."
}

output "enable_instance_ops" {
  value       = alicloud_compute_nest_service_instance.extension_resource.enable_instance_ops
  description = "Whether the service instance has the O & M function."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "Creation time."
}

output "network_config" {
  // Could not transform ROS Attribute NetworkConfig to Terraform attribute.
  value       = null
  description = "Network configuration information."
}

output "service" {
  // Could not transform ROS Attribute Service to Terraform attribute.
  value       = null
  description = "Service details."
}

output "predefined_parameter_name" {
  // Could not transform ROS Attribute PredefinedParameterName to Terraform attribute.
  value       = null
  description = "Package name."
}

output "source" {
  // Could not transform ROS Attribute Source to Terraform attribute.
  value       = null
  description = "The source of the service instance."
}

output "name" {
  value       = alicloud_compute_nest_service_instance.extension_resource.service_instance_name
  description = "The name of the service instance."
}

output "components" {
  // Could not transform ROS Attribute Components to Terraform attribute.
  value       = null
  description = "Additional billing items."
}

output "license_end_time" {
  // Could not transform ROS Attribute LicenseEndTime to Terraform attribute.
  value       = null
  description = "License expiration time."
}

output "service_instance_id" {
  value       = alicloud_compute_nest_service_instance.extension_resource.id
  description = "The ID of the service instance."
}

output "user_id" {
  // Could not transform ROS Attribute UserId to Terraform attribute.
  value       = null
  description = "AliUid of the user."
}

output "enable_user_prometheus" {
  value       = alicloud_compute_nest_service_instance.extension_resource.enable_user_prometheus
  description = "Whether Prometheus monitoring is enabled."
}

output "service_type" {
  // Could not transform ROS Attribute ServiceType to Terraform attribute.
  value       = null
  description = "Service type."
}

output "status_detail" {
  // Could not transform ROS Attribute StatusDetail to Terraform attribute.
  value       = null
  description = "The status description of the deployment instance."
}

output "update_time" {
  // Could not transform ROS Attribute UpdateTime to Terraform attribute.
  value       = null
  description = "Update time."
}

output "outputs" {
  // Could not transform ROS Attribute Outputs to Terraform attribute.
  value       = null
  description = "Create the output Field returned by the service instance."
}

output "template_name" {
  value       = alicloud_compute_nest_service_instance.extension_resource.template_name
  description = "Template name."
}

output "is_operated" {
  // Could not transform ROS Attribute IsOperated to Terraform attribute.
  value       = null
  description = "Whether the generation O & M function of the service instance is enabled."
}

output "supplier_uid" {
  // Could not transform ROS Attribute SupplierUid to Terraform attribute.
  value       = null
  description = "Service provider AliUid."
}

output "tags" {
  value       = alicloud_compute_nest_service_instance.extension_resource.tags
  description = "User-defined labels."
}

