variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The vpc ID of the cluster."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "集群所对应的VPC ID"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Kubernetes cluster of Alibaba Cloud Container Service for Kubernetes."
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "阿里云容器服务Kubernetes版的Kubernetes集群ID"
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
      "en": "The security group ID of the cluster."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "集群所对应的安全组ID"
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
      "en": "The vswith ID of the cluster."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "集群所对应的交换机ID"
    }
  }
  EOT
}

variable "cluster_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the cluster. Required when the ClusterType is ecs."
    },
    "Label": {
      "en": "ClusterName",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "cluster_type" {
  type        = string
  default     = "ecs"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the cluster. Currently, only ask, ecs and one clusters are supported. Default is ecs."
    },
    "AllowedValues": [
      "ecs",
      "ask",
      "one"
    ],
    "Label": {
      "en": "ClusterType",
      "zh-cn": "集群类型"
    }
  }
  EOT
}

variable "grafana_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the managed Grafana workspace bound to the cluster. When empty or \"free\", binds to the shared version of Grafana."
    },
    "Label": {
      "en": "GrafanaInstanceId",
      "zh-cn": "集群绑定的托管版Grafana工作区ID"
    }
  }
  EOT
}

resource "alicloud_arms_prometheus" "managed_prometheus" {
  vpc_id              = var.vpc_id
  cluster_id          = var.cluster_id
  security_group_id   = var.security_group_id
  vswitch_id          = var.vswitch_id
  cluster_name        = var.cluster_name
  cluster_type        = var.cluster_type
  grafana_instance_id = var.grafana_instance_id
}

output "vpc_id" {
  value       = alicloud_arms_prometheus.managed_prometheus.vpc_id
  description = "The vpc ID of the cluster."
}

output "cluster_type" {
  value       = alicloud_arms_prometheus.managed_prometheus.cluster_type
  description = "The type of the cluster."
}

