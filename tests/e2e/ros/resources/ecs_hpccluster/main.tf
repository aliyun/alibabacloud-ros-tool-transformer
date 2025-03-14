variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the HPC cluster. The description must be 2 to 256 characters in\nlength. It cannot start with http:// or https://. Default value: empty string."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "HPC集群描述"
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
      "en": "The name of the HPC cluster. The name must be 2 to 128 characters in length. It must\nstart with a letter but cannot start with http:// or https://. It can contain letters,\ndigits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "HPC集群名称"
    }
  }
  EOT
}

resource "alicloud_ecs_hpc_cluster" "hpc_cluster" {
  description = var.description
  name        = var.name
}

output "hpc_cluster_id" {
  value       = alicloud_ecs_hpc_cluster.hpc_cluster.id
  description = "The ID of the HPC cluster."
}

output "name" {
  value       = alicloud_ecs_hpc_cluster.hpc_cluster.name
  description = "The name of the HPC cluster."
}

