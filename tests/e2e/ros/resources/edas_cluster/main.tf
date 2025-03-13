variable "logical_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Custom namespace RegionId (format: Physical Region: custom namespace identifier)"
    },
    "Label": {
      "en": "LogicalRegionId",
      "zh-cn": "自定义命名空间的地域ID"
    }
  }
  EOT
}

variable "oversold_factor" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Docker CPU cluster oversold. Support 2 (1: 2 ratio) / 4 (1: 4) / 8 (1: 8 ratio)"
    },
    "AllowedValues": [
      2,
      4,
      8
    ],
    "Label": {
      "en": "OversoldFactor",
      "zh-cn": "Docker集群CPU超卖"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkMode}",
            2
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VPC network ID. If network selection VPC, this parameter Required"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
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

variable "cluster_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster name"
    },
    "Label": {
      "en": "ClusterName",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "network_mode" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "1": {
          "en": "Classic Network",
          "zh-cn": "经典网络"
        },
        "2": {
          "en": "VPC",
          "zh-cn": "专有网络"
        }
      }
    },
    "Description": {
      "en": "Network Type. 1- classic network, 2-VPC"
    },
    "Label": {
      "en": "NetworkMode",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "cluster_type" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "1": {
          "en": "Swarm Cluster",
          "zh-cn": "Swarm集群"
        },
        "2": {
          "en": "ECS Cluster",
          "zh-cn": "ECS集群"
        },
        "3": {
          "en": "Kubernetes Cluster",
          "zh-cn": "Kubernetes集群"
        }
      }
    },
    "Description": {
      "en": "Cluster type. 1-Swarm cluster, 2-ECS cluster, 3-Kubernetes Cluster"
    },
    "Label": {
      "en": "ClusterType",
      "zh-cn": "集群类型"
    }
  }
  EOT
}

resource "alicloud_edas_cluster" "cluster" {
  logical_region_id = var.logical_region_id
  vpc_id            = var.vpc_id
  cluster_name      = var.cluster_name
  network_mode      = var.network_mode
  cluster_type      = var.cluster_type
}

output "cluster_id" {
  value       = alicloud_edas_cluster.cluster.id
  description = "Cluster ID"
}

output "cluster_name" {
  value       = alicloud_edas_cluster.cluster.cluster_name
  description = "Cluster name"
}

output "iaas_provider" {
  // Could not transform ROS Attribute IaasProvider to Terraform attribute.
  value       = null
  description = "Provider"
}

output "cluster_type" {
  value       = alicloud_edas_cluster.cluster.cluster_type
  description = "Cluster type"
}

