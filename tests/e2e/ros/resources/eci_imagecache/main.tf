variable "image_cache_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the image cache. Unit: GiB. Default value: 20."
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone ID of the image cache."
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

variable "auto_match_image_cache" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable reuse of image cache layers. If you enable this feature, and the image cache that you want to createand an existing image cache contain duplicate image layers, the system reuses the duplicate image layers to create the new image cache.\n This accelerates the creation of the image cache. \nValid values: true: enables reuse of image cache layers.\nfalse: disables reuse of image cache layers.\nDefault value: false."
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
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "image_cache_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Image cache name."
    },
    "Label": {
      "en": "ImageCacheName",
      "zh-cn": "镜像缓存名"
    }
  }
  EOT
}

variable "image_registry_credential" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Private image password. Alibaba Cloud ACR image can be left blank."
    },
    "Label": {
      "en": "ImageRegistryCredential",
      "zh-cn": "镜像仓库登录信息"
    },
    "MaxLength": 10
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
      "en": "VSwitch ID."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "acr_registry_info" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "InstanceName": {
              "Type": "String",
              "Description": {
                "en": "instance name"
              },
              "Required": false
            },
            "InstanceId": {
              "Type": "String",
              "Description": {
                "en": "Instance id"
              },
              "Required": true
            },
            "RegionId": {
              "Type": "String",
              "Description": {
                "en": "The region to which it belongs. Optional, the default is the local region"
              },
              "Required": false
            },
            "Domain": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "Optional, the default is all domain names of the corresponding instance"
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "domain"
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Enterprise Edition access credential configuration information. "
    }
  }
  EOT
}

variable "retention_days" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The retention period of the image cache. Unit: days. When the retention period ends, the image cache expires and is deleted.\n By default, image caches never expire.\nNote: The image caches that fail to be created are only retained for one day."
    }
  }
  EOT
}

variable "image" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The image list to be cached.",
      "zh-cn": "要缓存的镜像，列表内为镜像ID。"
    },
    "Label": {
      "en": "Image",
      "zh-cn": "要缓存的镜像"
    },
    "MaxLength": 20
  }
  EOT
}

variable "eip_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If you want to pull the public network image, you need to configure the public network ip or configure the switch NAT gateway."
    },
    "Label": {
      "en": "EipInstanceId",
      "zh-cn": "弹性公网IP实例ID"
    }
  }
  EOT
}

resource "alicloud_eci_image_cache" "image_cache" {
  image_cache_size          = var.image_cache_size
  zone_id                   = var.zone_id
  resource_group_id         = var.resource_group_id
  security_group_id         = var.security_group_id
  image_cache_name          = var.image_cache_name
  image_registry_credential = var.image_registry_credential
  vswitch_id                = var.vswitch_id
  retention_days            = var.retention_days
  images                    = var.image
  eip_instance_id           = var.eip_instance_id
}

output "image_cache_id" {
  value       = alicloud_eci_image_cache.image_cache.id
  description = "The ID of the image cache."
}

