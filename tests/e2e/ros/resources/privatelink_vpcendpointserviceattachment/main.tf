variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Zone id of the service resource. "
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "服务资源所属的可用区"
    }
  }
  EOT
}

variable "resource_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resource id. "
    },
    "Label": {
      "en": "ResourceId",
      "zh-cn": "服务资源ID"
    }
  }
  EOT
}

variable "resource_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resource type. Allowed values:\n- slb: indicates a Classic Load Balancer (CLB) instance whose service resource type is a private network and supports the PrivateLink function.\n- alb: indicates an Application Load Balancer (ALB) instance whose service resources are private networks and which supports the PrivateLink function.\n- nlb: indicates a Network Load Balancer (NLB) instance that uses private network resources and supports the PrivateLink function."
    },
    "Label": {
      "en": "ResourceType",
      "zh-cn": "服务资源类型"
    }
  }
  EOT
}

variable "service_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The endpoint service that is associated with the endpoint. "
    },
    "Label": {
      "en": "ServiceId",
      "zh-cn": "要添加服务资源的终端节点服务ID"
    }
  }
  EOT
}

resource "alicloud_privatelink_vpc_endpoint_connection" "vpc_endpoint_service_attachment" {
  endpoint_id = var.resource_id
  service_id  = var.service_id
}

