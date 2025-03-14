variable "enable_asm" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether enable ASM."
    },
    "Label": {
      "en": "EnableAsm",
      "zh-cn": "是否开启服务网格ASM"
    }
  }
  EOT
}

variable "namespace_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the namespace to which the cluster that you want to import belongs."
    },
    "Label": {
      "en": "NamespaceId",
      "zh-cn": "命名空间ID"
    }
  }
  EOT
}

variable "cs_cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CS cluster."
    },
    "Label": {
      "en": "CsClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

resource "alicloud_edas_k8s_cluster" "k8s_cluster" {
  namespace_id  = var.namespace_id
  cs_cluster_id = var.cs_cluster_id
}

output "vpc_id" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.vpc_id
  description = "The ID of the cluster."
}

output "node_num" {
  // Could not transform ROS Attribute NodeNum to Terraform attribute.
  value       = null
  description = "Number of nodes."
}

output "cluster_id" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.id
  description = "The ID of the cluster."
}

output "cluster_name" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.cluster_name
  description = "The name of the cluster."
}

output "sub_net_cidr" {
  // Could not transform ROS Attribute SubNetCidr to Terraform attribute.
  value       = null
  description = "Sub net CIDR."
}

output "network_mode" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.network_mode
  description = <<EOT
  "Network node:\n1: Classic network\n2: VPC"
  EOT
}

output "cluster_type" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.cluster_type
  description = <<EOT
  "The type of the cluster:\n2: ECS cluster\n5: Container Service K8s cluster or Serverless K8s cluster"
  EOT
}

output "cs_cluster_id" {
  value       = alicloud_edas_k8s_cluster.k8s_cluster.cs_cluster_id
  description = "The ID of the K8s cluster."
}

output "vswitch_id" {
  // Could not transform ROS Attribute VswitchId to Terraform attribute.
  value       = null
  description = "The ID of the cluster."
}

