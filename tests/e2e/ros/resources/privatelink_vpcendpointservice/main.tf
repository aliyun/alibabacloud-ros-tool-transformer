variable "payer" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The payer of the endpoint service. Valid values: \nEndpoint: the service consumer. \nEndpointService: the service provider."
    },
    "AllowedValues": [
      "Endpoint",
      "EndpointService"
    ],
    "Label": {
      "en": "Payer",
      "zh-cn": "付费方"
    }
  }
  EOT
}

variable "user" {
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
      "en": "Account IDs to the whitelist of an endpoint service."
    },
    "Label": {
      "en": "User",
      "zh-cn": "终端节点服务的白名单"
    },
    "MinLength": 1,
    "MaxLength": 20
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to delete the endpoint service even if it has endpoint connections.\n- True\n- False (default)"
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除"
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
      "zh-cn": "资源组 ID"
    }
  }
  EOT
}

variable "service_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description for the endpoint service."
    },
    "Label": {
      "en": "ServiceDescription",
      "zh-cn": "终端节点服务的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "resource" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "The zone to which the service resource belongs."
          },
          "Required": true
        },
        "ResourceId": {
          "Type": "String",
          "Description": {
            "en": "Service resources added to the endpoint service."
          },
          "Required": true
        },
        "ResourceType": {
          "Type": "String",
          "Description": {
            "en": "The type of service resource. Supports slb, nlb, vpcNat."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Resource",
      "zh-cn": "添加到终端节点服务中的服务资源"
    },
    "MinLength": 1,
    "MaxLength": 500
  }
  EOT
}

variable "connect_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The default maximum bandwidth of the endpoint connection. Valid values: 100 to 1024. Unit: Mbit/s."
    },
    "MinValue": 100,
    "Label": {
      "en": "ConnectBandwidth",
      "zh-cn": "默认连接带宽峰值"
    },
    "MaxValue": 1024
  }
  EOT
}

variable "service_resource_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Service resource type."
    },
    "Label": {
      "en": "ServiceResourceType",
      "zh-cn": "服务资源类型"
    }
  }
  EOT
}

variable "zone_affinity_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to resolve domain names to IP addresses in the nearest zone.\ntrue: yes. \nfalse (default): no"
    },
    "Label": {
      "en": "ZoneAffinityEnabled",
      "zh-cn": "是否支持可用区就近解析"
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
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "auto_accept_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically accept endpoint connection requests. Valid values:\ntrue: automatically accepts endpoint connection requests.\nfalse: does not automatically accept endpoint connection requests."
    },
    "Label": {
      "en": "AutoAcceptEnabled",
      "zh-cn": "是否自动接受终端节点连接"
    }
  }
  EOT
}

resource "alicloud_privatelink_vpc_endpoint_service" "vpc_endpoint_service" {
  payer                  = var.payer
  resource_group_id      = var.resource_group_id
  service_description    = var.service_description
  connect_bandwidth      = var.connect_bandwidth
  service_resource_type  = var.service_resource_type
  zone_affinity_enabled  = var.zone_affinity_enabled
  tags                   = var.tags
  auto_accept_connection = var.auto_accept_enabled
}

output "service_name" {
  // Could not transform ROS Attribute ServiceName to Terraform attribute.
  value       = null
  description = "The name of the endpoint service."
}

output "service_description" {
  value       = alicloud_privatelink_vpc_endpoint_service.vpc_endpoint_service.service_description
  description = "The description of the endpoint service."
}

output "max_bandwidth" {
  // Could not transform ROS Attribute MaxBandwidth to Terraform attribute.
  value       = null
  description = "The maximum bandwidth of the endpoint connection."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "service_domain" {
  value       = alicloud_privatelink_vpc_endpoint_service.vpc_endpoint_service.service_domain
  description = "The domain name of the endpoint service."
}

output "min_bandwidth" {
  // Could not transform ROS Attribute MinBandwidth to Terraform attribute.
  value       = null
  description = "The minimum bandwidth of the endpoint connection."
}

output "service_id" {
  value       = alicloud_privatelink_vpc_endpoint_service.vpc_endpoint_service.id
  description = "The ID of the endpoint service."
}

