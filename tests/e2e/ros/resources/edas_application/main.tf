variable "component_ids" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application component ID (available through the query interface to obtain a list of components to the interface ListComponents), when creating the application runtime environment using Apache Tomcat (war packet format Dubbo\nApplication required) or standard Java application (jar package format Spring Boot / Spring Cloud applications require) you need to specify when the operating environment. Commonly used application component ID and meaning:\n4 represents Apache Tomcat 7.0.91,7 represented Apache Tomcat 8.5.42,5 represented OpenJDK 1.8.x, 6 represents OpenJDK\n1.7.x",
      "zh-cn": "应用组件ID。 说明 设置该参数需要将Java或者Python SDK版本更新到2.57.3及以上。未使用EDAS提供的SDK的用户可直接设置该参数。例如：用户在使用aliyun-python-sdk-core、aliyun-java-sdk-core、aliyun cli等SDK时可以直接设置该参数。"
    },
    "Label": {
      "en": "ComponentIds",
      "zh-cn": "应用组件ID"
    }
  }
  EOT
}

variable "logical_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Namespace ID",
      "zh-cn": "命名空间ID，示例值：cn-beijing:prod。"
    },
    "Label": {
      "en": "LogicalRegionId",
      "zh-cn": "命名空间ID"
    }
  }
  EOT
}

variable "application_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The application name (only allow the use of numbers, letters, -, _, up to 36 characters)"
    },
    "Label": {
      "en": "ApplicationName",
      "zh-cn": "应用名称"
    },
    "MinLength": 1,
    "MaxLength": 36
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Descriptive information"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "ecu_info" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Machine capacity is needed ecu_id (ECS Examples introducing another unique identity EDAS EDAS), the plurality of \",\" separated (by querying ListScaleOutEcu wherein ecu_id\nInterface to obtain)."
    },
    "Label": {
      "en": "EcuInfo",
      "zh-cn": "需要扩容机器的ecu_id（导入EDAS的 ECS实例在EDAS中的唯一身份）"
    }
  }
  EOT
}

variable "health_checkurl" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application Health Check URL"
    },
    "Label": {
      "en": "HealthCheckURL",
      "zh-cn": "健康检查URL"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster ID of ECS application",
      "zh-cn": "向指定集群ID的ECS集群创建应用，不指定则向默认ECS集群创建应用。"
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "向指定集群ID的ECS集群创建应用"
    }
  }
  EOT
}

variable "package_type" {
  type        = string
  default     = "war"
  description = <<EOT
  {
    "Description": {
      "en": "Application packet format, possible values: war or jar"
    },
    "AllowedValues": [
      "war",
      "jar"
    ],
    "Label": {
      "en": "PackageType",
      "zh-cn": "应用包格式"
    }
  }
  EOT
}

variable "deployment" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ReleaseType": {
          "Type": "Number",
          "Description": {
            "en": "Batch mode.\n0 is automatic.\n1 means manual confirmation is required between batches."
          },
          "Required": false,
          "Default": 0
        },
        "Desc": {
          "Type": "String",
          "Description": {
            "en": "Application deployment description information"
          },
          "Required": false
        },
        "Gray": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether Canary Release.\nTrue: Canary Release.\nWhen implementing a gray release, the GroupId that will be used for the gray release must be specified.\nGray release is a batch release.\nAfter the gray release is complete, normal release can be done, and the Batch controls the grouping.\nFalse: Non-Canary Release (single or grouped release)."
          },
          "Required": false
        },
        "AppEnv": {
          "Type": "String",
          "Description": {
            "en": "Deployment environment variables, the format must conform to\n{\"name\":\"x\",\"value\":\"y\"},{\"name\":\"x2\",\"value\":\"y2\"}, \nand the key is fixed as name and value."
          },
          "Required": false
        },
        "Batch": {
          "Type": "Number",
          "Description": {
            "en": "Each group of batches.When the GroupId of the specified application group is a specific application group ID,\nit means to deploy to the specified application group.\n At this time, the minimum number of batches that can be specified is 1,\n and the maximum number of batches is the maximum number of\n ECS instances in the normal state under the application group. \nThe actual number of batches results range: [1, specified number of batches].\nWhen the GroupId of the specified application group is all, \nit means to deploy to all application groups. \nAt this time, the minimum number of batches that can be specified is 1,\nand the maximum number of batches is the number of\nECS instances under the group with the largest number of ECSs in the normal state."
          },
          "Required": false
        },
        "WarUrl": {
          "Type": "String",
          "Description": {
            "en": "The URL address of the application deployment package (WAR or JAR).\nIt is recommended to use the application deployment package path stored in OSS."
          },
          "Required": true
        },
        "TrafficControlStrategy": {
          "Type": "String",
          "Description": {
            "en": "Gray release policy content"
          },
          "Required": false
        },
        "BatchWaitTime": {
          "Type": "Number",
          "Description": {
            "en": "Batch waiting time, unit: minute.\nThe default is 0, which means no waiting.\nThe maximum is 5.\nWhen the actual number of batches is large, a reasonable value needs to be set,\notherwise the change duration of this application deployment will be longer."
          },
          "Required": false,
          "Default": 0
        },
        "PackageVersion": {
          "Type": "String",
          "Description": {
            "en": "Deployed application deployment package version,\nup to 64 characters, it is recommended to use timestamp"
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 64
        },
        "GroupId": {
          "Type": "String",
          "Description": {
            "en": "Deployment group ID.\nIf you want to deploy to all groups, set the parameter to all."
          },
          "Required": false,
          "Default": "all"
        }
      }
    },
    "Description": {
      "en": "Deploy application information to ECS clusters"
    },
    "Label": {
      "en": "Deployment",
      "zh-cn": "部署应用程序信息"
    }
  }
  EOT
}

variable "build_pack_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "EDAS-Container construct a packet number (available version list acquired through the ListBuildPack API (ConfigId of response) or \"container version\" table \"Building packet number\" column acquisition). When creating HSF application, this parameter must be specified",
      "zh-cn": "EDAS-Container构建包号。 您可以通过容器版本列表接口ListBuildPack或者根据容器版本说明 中的构建包序号列查询EDAS-Container构建包号。"
    },
    "Label": {
      "en": "BuildPackId",
      "zh-cn": "EDAS-Container构建包号"
    }
  }
  EOT
}

resource "alicloud_edas_application" "application" {
  logical_region_id = var.logical_region_id
  application_name  = var.application_name
  descriotion       = var.description
  ecu_info          = var.ecu_info
  health_check_url  = var.health_checkurl
  cluster_id        = var.cluster_id
  package_type      = var.package_type
  build_pack_id     = var.build_pack_id
}

output "app_id" {
  value       = alicloud_edas_application.application.id
  description = "Application Id, a unique identifier EDAS application"
}

output "port" {
  // Could not transform ROS Attribute Port to Terraform attribute.
  value       = null
  description = "Application port"
}

