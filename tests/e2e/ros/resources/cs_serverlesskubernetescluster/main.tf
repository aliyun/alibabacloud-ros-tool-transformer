variable "kubernetes_version" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::CS::Cluster::KubernetesVersion",
    "Description": {
      "en": "The version of the Kubernetes cluster."
    },
    "Label": {
      "en": "KubernetesVersion",
      "zh-cn": "集群版本"
    }
  }
  EOT
}

variable "endpoint_public_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable the public network API Server:\ntrue: which means that the public network API Server is open.\nfalse: If set to false, the API server on the public network will not be created, only the API server on the private network will be created."
    },
    "Label": {
      "en": "EndpointPublicAccess",
      "zh-cn": "是否开启公网API Server"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The zone ID."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
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
      "en": "The ID of resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "集群所属的资源组ID"
    }
  }
  EOT
}

variable "vswitch_ids" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The IDs of VSwitches. If you leave this property empty, the system automatically creates a VSwitch.\nNote You must specify both the VpcId and VSwitchIds or leave both of them empty."
    },
    "Label": {
      "en": "VSwitchIds",
      "zh-cn": "交换机ID列表"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Specifies the ID of the security group to which the cluster ECS instance belongs."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "集群ECS实例所属的安全组ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If not set, the system will automatically create a switch, and the network segment of the switch created by the system is 192.168.0.0/18."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "addons" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Config": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, no configuration is required."
          },
          "Required": false,
          "Label": {
            "en": "Config",
            "zh-cn": "组件配置"
          }
        },
        "Disabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to disable default installation."
          },
          "Required": false,
          "Label": {
            "en": "Disabled",
            "zh-cn": "是否禁止默认安装组件"
          }
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the add-on."
          },
          "Required": true,
          "Label": {
            "en": "Name",
            "zh-cn": "组件名称"
          }
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The add-ons to be installed for the cluster."
    },
    "Label": {
      "en": "Addons",
      "zh-cn": "集群安装的组件列表"
    }
  }
  EOT
}

variable "nat_gateway" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to create a NAT gateway. The value can be true or false. If not set, the system defaults to false."
    },
    "Label": {
      "en": "NatGateway",
      "zh-cn": "是否创建NAT网关"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the cluster. The cluster name can use uppercase and lowercase letters, Chinese characters, numbers, and dashes."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "VPC ID. If not set, the system will automatically create a VPC, and the VPC network segment created by the system is 192.168.0.0/16. \nVpcId and VSwitchId can only be empty at the same time or set the corresponding values at the same time."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "service_cidr" {
  type        = string
  default     = "172.19.0.0/20"
  description = <<EOT
  {
    "Description": {
      "en": "The service network segment cannot conflict with the VPC network segment and the container network segment. When the system is selected to automatically create a VPC, the network segment 172.19.0.0/20 is used by default."
    },
    "Label": {
      "zh-cn": "Service Cidr"
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
            "en": "Tag value."
          },
          "Required": false,
          "Label": {
            "en": "Value",
            "zh-cn": "标签值"
          }
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Tag key."
          },
          "Required": true,
          "Label": {
            "en": "Key",
            "zh-cn": "标签键"
          }
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
      "en": "Tag the cluster."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "集群标签"
    }
  }
  EOT
}

variable "private_zone" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable PrivateZone for service discovery."
    },
    "Label": {
      "en": "PrivateZone",
      "zh-cn": "是否开启云解析PrivateZone用于服务发现"
    }
  }
  EOT
}

resource "alicloud_cs_serverless_kubernetes" "serverless_kubernetes_cluster" {
  zone_id           = var.zone_id
  resource_group_id = var.resource_group_id
  security_group_id = var.security_group_id
  vswitch_id        = var.vswitch_id
  addons            = var.addons
  new_nat_gateway   = var.nat_gateway
  name              = var.name
  vpc_id            = var.vpc_id
  service_cidr      = var.service_cidr
  tags              = var.tags
  private_zone      = var.private_zone
}

output "task_id" {
  // Could not transform ROS Attribute TaskId to Terraform attribute.
  value       = null
  description = "Task ID. Automatically assigned by the system, the user queries the task status."
}

output "cluster_id" {
  value       = alicloud_cs_serverless_kubernetes.serverless_kubernetes_cluster.id
  description = "Cluster instance ID."
}

output "apiserverslbid" {
  // Could not transform ROS Attribute APIServerSLBId to Terraform attribute.
  value       = null
  description = "The id of API server SLB"
}

output "scaling_group_id" {
  // Could not transform ROS Attribute ScalingGroupId to Terraform attribute.
  value       = null
  description = "Scaling group id"
}

output "ingressslbid" {
  // Could not transform ROS Attribute IngressSLBId to Terraform attribute.
  value       = null
  description = "The id of ingress SLB"
}

output "scaling_rule_id" {
  // Could not transform ROS Attribute ScalingRuleId to Terraform attribute.
  value       = null
  description = "Scaling rule id"
}

output "default_user_kube_config" {
  // Could not transform ROS Attribute DefaultUserKubeConfig to Terraform attribute.
  value       = null
  description = "Default user kubernetes config which is used for configuring cluster credentials."
}

output "worker_ram_role_name" {
  // Could not transform ROS Attribute WorkerRamRoleName to Terraform attribute.
  value       = null
  description = "Worker ram role name."
}

output "scaling_configuration_id" {
  // Could not transform ROS Attribute ScalingConfigurationId to Terraform attribute.
  value       = null
  description = "Scaling configuration id"
}

output "private_user_kub_config" {
  // Could not transform ROS Attribute PrivateUserKubConfig to Terraform attribute.
  value       = null
  description = "Private user kubernetes config which is used for configuring cluster credentials."
}

output "nodes" {
  // Could not transform ROS Attribute Nodes to Terraform attribute.
  value       = null
  description = "The list of cluster nodes."
}

