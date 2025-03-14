variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Describe information, do not enter the space without more than 255 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "data" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Configmap key value pairs of data, json format.The format is as follows:\n{\"k1\":\"v1\", \"k2\":\"v2\"}\nK means key, V represents value.For more information about configuration items, see management and use of configuration items."
    },
    "Label": {
      "en": "Data",
      "zh-cn": "ConfigMap 数据"
    }
  }
  EOT
}

variable "namespace_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the namespace to which this config map instance belongs."
    },
    "Label": {
      "en": "NamespaceId",
      "zh-cn": "ConfigMap 实例所在命名空间 ID"
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
      "en": "The name of the config map."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "ConfigMap 实例名称"
    }
  }
  EOT
}

resource "alicloud_sae_config_map" "config_map" {
  description  = var.description
  namespace_id = var.namespace_id
  name         = var.name
}

output "config_map_id" {
  value       = alicloud_sae_config_map.config_map.id
  description = "The ID of the config map."
}

output "namespace_id" {
  value       = alicloud_sae_config_map.config_map.namespace_id
  description = "The ID of the namespace to which this config map instance belongs."
}

