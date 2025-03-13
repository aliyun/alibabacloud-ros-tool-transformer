variable "endpoint_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the endpoint group."
    },
    "Label": {
      "en": "EndpointGroupId",
      "zh-cn": "基础型全球加速实例的终端节点组ID"
    }
  }
  EOT
}

variable "endpoint_zone_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The zone ID of the endpoint. This parameter is required only if the endpoint type is NLB."
    },
    "Label": {
      "en": "EndpointZoneId",
      "zh-cn": "终端节点所在可用区ID"
    }
  }
  EOT
}

variable "endpoint_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the endpoint. Valid values:\nENI: elastic network interface (ENI)\nSLB: Classic Load Balancer (CLB)\nNLB: Network Load Balancer (NLB)\nECS: Elastic Compute Service (ECS)"
    },
    "AllowedValues": [
      "ENI",
      "SLB",
      "NLB",
      "ECS"
    ],
    "Label": {
      "en": "EndpointType",
      "zh-cn": "终端节点类型"
    }
  }
  EOT
}

variable "endpoint_sub_address_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the secondary address of the endpoint. Valid values:\nprimary: a primary private IP address.\nsecondary: a secondary private IP address.\nThis parameter is required if the endpoint type is ECS, ENI, or NLB. If the endpoint type is NLB, only primary is supported."
    },
    "AllowedValues": [
      "primary",
      "secondary"
    ],
    "Label": {
      "en": "EndpointSubAddressType",
      "zh-cn": "终端节点辅助地址的类型"
    }
  }
  EOT
}

variable "endpoint_sub_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secondary address of the endpoint. This parameter is required if the endpoint type is ECS, ENI, or NLB.\nIf the endpoint type is ECS, you can set EndpointSubAddress to the secondary private IP address of the primary ENI. If the parameter is left empty, the primary private IP address of the primary ENI is used.\nIf the endpoint type is ENI, you can set EndpointSubAddress to the secondary private IP address of the secondary ENI. If the parameter is left empty, the primary private IP address of the secondary ENI is used.\nThis parameter is required if the endpoint type is NLB. EndpointSubAddress is the primary private IP address of the NLB backend server.This parameter is required if the endpoint type is NLB. EndpointSubAddress is the primary private IP address of the NLB backend server."
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

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the endpoint that is associated with the basic GA instance. The name must be 1 to 128 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "基础型全球加速实例终端节点的名称"
    }
  }
  EOT
}

variable "endpoint_address" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The address of the endpoint."
    },
    "Label": {
      "en": "EndpointAddress",
      "zh-cn": "终端节点的地址"
    }
  }
  EOT
}

resource "alicloud_ga_basic_endpoint" "extension_resource" {
  endpoint_group_id         = var.endpoint_group_id
  endpoint_zone_id          = var.endpoint_zone_id
  endpoint_type             = var.endpoint_type
  endpoint_sub_address_type = var.endpoint_sub_address_type
  endpoint_sub_address      = var.endpoint_sub_address
  accelerator_id            = var.accelerator_id
  endpoint_address          = var.endpoint_address
}

output "endpoint_id" {
  value       = alicloud_ga_basic_endpoint.extension_resource.id
  description = "The ID of the endpoint."
}

