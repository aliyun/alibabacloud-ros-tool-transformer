variable "base_image_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "IMAGE",
      "IMAGE_FAMILY"
    ],
    "Description": {
      "en": "The type of the source image. Valid values:\nIMAGE: image\nIMAGE_FAMILY: image family"
    },
    "Label": {
      "en": "BaseImageType",
      "zh-cn": "源镜像类型"
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
      "en": "The description of the image template. The description must be 2 to 256 characters in length. It cannot start with http:// or https://."
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The system disk size of the intermediate instance. Unit: GiB. Valid values: 20 to 500.\nDefault value: 40."
    },
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "中转实例的系统盘大小"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the vSwitch.\nIf you do not specify this parameter, a new VPC and vSwitch are created. Make sure that the VPC quota in your account is sufficient. For more information, see Limits and quotas."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "VPC的交换机ID"
    }
  }
  EOT
}

variable "add_account" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of Ali account."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of Alibaba Cloud accounts to which to share the image that will be created based on the image template. You can specify up to 20 account IDs."
    },
    "Label": {
      "en": "AddAccount",
      "zh-cn": "目标镜像共享的阿里云账号ID"
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
      "en": "The name of the image template. The name must be 2 to 128 characters in length. It must start with a letter and cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), periods (.), and hyphens (-).\nNote If you do not specify the Name parameter, the return value of ImagePipelineId is used."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "模板名称"
    }
  }
  EOT
}

variable "execute_pipeline" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether execute pipeline. Default value is true"
    },
    "Label": {
      "en": "ExecutePipeline",
      "zh-cn": "是否执行构建镜像的任务"
    }
  }
  EOT
}

variable "delete_instance_on_failure" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to release the intermediate instance when the image cannot be created. Valid values:\ntrue\nfalse\nDefault value: true.\nNote If the intermediate instance cannot be started, the instance is released by default."
    },
    "Label": {
      "en": "DeleteInstanceOnFailure",
      "zh-cn": "镜像构建失败后是否释放中转实例"
    }
  }
  EOT
}

variable "image_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the image name. The prefix must be 2 to 64 characters in length. It must start with a letter and cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), periods (.), and hyphens (-).\nThe system generates the final complete image name that consists of the specified prefix and the ID of the build task (ExecutionId) in the format of {ImageName}_{ExecutionId}."
    },
    "Label": {
      "en": "ImageName",
      "zh-cn": "目标镜像名称前缀"
    }
  }
  EOT
}

variable "to_region_id" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The region ID."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of regions to which you want to distribute the image that is created based on the image template. You can specify up to 20 region IDs.\nIf you do not specify this parameter, the image is created only in the current region."
    },
    "Label": {
      "en": "ToRegionId",
      "zh-cn": "目标镜像待分发的地域列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "internet_max_bandwidth_out" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the outbound public bandwidth for the intermediate instance. Unit: Mbit/s. Valid values: 0 to 100.\nDefault value: 0."
    },
    "Label": {
      "en": "InternetMaxBandwidthOut",
      "zh-cn": "中转实例的公网出带宽大小"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The instance type. You can call the  DescribeInstanceTypes  to query instance types.\nIf you do not configure this parameter, an instance type that provides the fewest vCPUs and memory resources is automatically selected. This configuration is subject to resource availability of instance types. For example, the ecs.g6.large instance type is automatically selected. If available ecs.g6.large resources are insufficient, the ecs.g6.xlarge instance type is selected."
    },
    "Label": {
      "en": "InstanceType",
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
          "Description": {
            "en": "The value of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag value can be an empty string. The tag value can be up to 128 characters in length and cannot start with acs:. The tag value cannot contain http:// or https://."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The key of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag key cannot be an empty string. The tag key can be up to 128 characters in length and cannot contain http:// or https://. It cannot start with acs: or aliyun."
          },
          "Required": false
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
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "build_content" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The content of the image template. The content cannot exceed 16 KB in size and can contain up to 127 commands. For more information about the commands that are supported, see the \"Usage notes\" section of this topic."
    },
    "Label": {
      "en": "BuildContent",
      "zh-cn": "镜像模板内容"
    }
  }
  EOT
}

variable "base_image" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source image.\nIf you set BaseImageType to IMAGE, set the BaseImage parameter to the ID of a custom image.\nIf you set BaseImageType to IMAGE_FAMILY, set the BaseImage parameter to the name of an image family."
    },
    "Label": {
      "en": "BaseImage",
      "zh-cn": "源镜像"
    }
  }
  EOT
}

resource "alicloud_ecs_image_pipeline" "image_pipeline" {
  base_image_type            = var.base_image_type
  description                = var.description
  resource_group_id          = var.resource_group_id
  system_disk_size           = var.system_disk_size
  vswitch_id                 = var.vswitch_id
  add_account                = var.add_account
  name                       = var.name
  delete_instance_on_failure = var.delete_instance_on_failure
  image_name                 = var.image_name
  to_region_id               = var.to_region_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  instance_type              = var.instance_type
  build_content              = var.build_content
  base_image                 = var.base_image
}

output "image_pipeline_id" {
  value       = alicloud_ecs_image_pipeline.image_pipeline.id
  description = "The ID of the image template."
}

