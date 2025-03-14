variable "desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the namespace."
    },
    "Label": {
      "en": "Desc",
      "zh-cn": "命名空间描述"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The custom ID of the namespace. If you do not specify this parameter, the automatically generated Universally Unique Identifier (UUID) is returned."
    },
    "Label": {
      "en": "Id",
      "zh-cn": "命名空间自定义ID"
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
      "en": "The display name of the namespace."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "命名空间展示名字"
    }
  }
  EOT
}

resource "alicloud_mse_engine_namespace" "namespace" {
  instance_id = var.instance_id
}

output "namespace_id" {
  value       = alicloud_mse_engine_namespace.namespace.id
  description = "The ID of the namespace."
}

