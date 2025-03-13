variable "endpoint_group_region" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region to which the endpoint group belongs."
    },
    "Label": {
      "en": "EndpointGroupRegion",
      "zh-cn": "基础型全球加速实例的终端节点组所在的地域ID"
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
      "en": "The description of the endpoint group. The description can be up to 200 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "基础型全球加速实例的终端节点组描述信息"
    },
    "MinLength": 0,
    "MaxLength": 200
  }
  EOT
}

variable "endpoint_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the endpoint. Valid values:\nENI\nSLB\nECS"
    },
    "AllowedValues": [
      "ENI",
      "SLB",
      "ECS"
    ],
    "Label": {
      "en": "EndpointType",
      "zh-cn": "终端节点类型"
    }
  }
  EOT
}

variable "endpoint_sub_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secondary address of the endpoint. You must specify this parameter when the accelerated IP address is associated with the secondary private IP address of an Elastic Compute Service (ECS) instance or an elastic network interface (ENI).\nWhen the endpoint type is ECS, you can set EndpointSubAddress to the secondary private IP address of the primary ENI. If the parameter is left empty, the primary private IP address of the primary ENI is used.\nIf the endpoint type is ENI, you can set EndpointSubAddress to the secondary private IP address of the secondary ENI. If the parameter is left empty, the primary private IP address of the secondary ENI is used."
    },
    "Label": {
      "en": "EndpointSubAddress",
      "zh-cn": "终端节点辅助地址"
    }
  }
  EOT
}

variable "accelerator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the basic GA instance."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "基础型全球加速实例ID"
    }
  }
  EOT
}

variable "endpoint_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The endpoint address."
    },
    "Label": {
      "en": "EndpointAddress",
      "zh-cn": "终端节点的地址"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the endpoint group. The name must be 2 to 128 characters in length, and can contain letters, digits, underscores (_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "基础型全球加速实例的终端节点组的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_ga_basic_endpoint_group" "extension_resource" {
  endpoint_group_region = var.endpoint_group_region
  description           = var.description
  endpoint_type         = var.endpoint_type
  endpoint_sub_address  = var.endpoint_sub_address
  accelerator_id        = var.accelerator_id
  endpoint_address      = var.endpoint_address
}

output "endpoint_group_id" {
  value       = alicloud_ga_basic_endpoint_group.extension_resource.id
  description = "The endpoint group ID."
}

