variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of the instance."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "EAIS实例的名称"
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
      "zh-cn": "实例所属的资源组ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security group ID."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "实例所属的安全组ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "Switch ID."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "实例所属的虚拟交换机ID"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The payment type of the resource."
    },
    "AllowedValues": [
      "PayAsYouGo"
    ],
    "Label": {
      "en": "PaymentType",
      "zh-cn": "支付类型"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "EAIS instance type."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "EAIS实例的规格"
    }
  }
  EOT
}

variable "environment_var" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "Values of environment variables."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Keys for environment variables."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Setting environment variables in eais instance on Initialization."
    },
    "Label": {
      "en": "EnvironmentVar",
      "zh-cn": "初始化时在实例中设置环境变量"
    }
  }
  EOT
}

variable "create_with_notebook" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "When the value is true, CreateEaiJupyter is called to create an eais instance, and when the value is false, CreateEai is called to create an eais instance."
    },
    "Label": {
      "en": "CreateWithNotebook",
      "zh-cn": "是否部署Notebook的弹性加速计算实例"
    }
  }
  EOT
}

resource "alicloud_eais_instance" "extension_resource" {
  instance_name     = var.instance_name
  security_group_id = var.security_group_id
  vswitch_id        = var.vswitch_id
  instance_type     = var.instance_type
}

output "instance_name" {
  value       = alicloud_eais_instance.extension_resource.instance_name
  description = "Name of the instance."
}

output "client_instance_type" {
  // Could not transform ROS Attribute ClientInstanceType to Terraform attribute.
  value       = null
  description = "The type of the ECS instance bound to the EAIS instance."
}

output "client_instance_name" {
  // Could not transform ROS Attribute ClientInstanceName to Terraform attribute.
  value       = null
  description = "The name of the ECS instance bound to the EAIS instance."
}

output "zone_id" {
  // Could not transform ROS Attribute ZoneId to Terraform attribute.
  value       = null
  description = "The ID of the region to which the EAIS instance belongs."
}

output "resource_group_id" {
  // Could not transform ROS Attribute ResourceGroupId to Terraform attribute.
  value       = null
  description = "The ID of the resource group."
}

output "instance_id" {
  value       = alicloud_eais_instance.extension_resource.id
  description = "Elastic accelerated instance ID."
}

output "security_group_id" {
  // Could not transform ROS Attribute SecurityGroupId to Terraform attribute.
  value       = null
  description = "Security group ID."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The creation time of the resource."
}

output "vswitch_id" {
  // Could not transform ROS Attribute VSwitchId to Terraform attribute.
  value       = null
  description = "Switch ID."
}

output "client_instance_id" {
  // Could not transform ROS Attribute ClientInstanceId to Terraform attribute.
  value       = null
  description = "The ID of the ECS instance to be bound."
}

output "instance_type" {
  value       = alicloud_eais_instance.extension_resource.instance_type
  description = "EAIS instance type."
}

output "jupyter_url" {
  // Could not transform ROS Attribute JupyterUrl to Terraform attribute.
  value       = null
  description = "The address of the Eais Notebook."
}

