variable "child_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "VPC",
      "VBR"
    ],
    "Description": {
      "en": "The type of the network, value: VPC VBR"
    },
    "Label": {
      "en": "ChildInstanceType",
      "zh-cn": "网络实例类型"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CEN instance where the route entry is published."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例的ID"
    }
  }
  EOT
}

variable "destination_cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The destination CIDR block of the route entry to publish."
    },
    "Label": {
      "en": "DestinationCidrBlock",
      "zh-cn": "要发布的网段"
    }
  }
  EOT
}

variable "child_instance_route_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The route table of the attached VBR or VPC."
    },
    "Label": {
      "en": "ChildInstanceRouteTableId",
      "zh-cn": "网络实例的路由表ID"
    }
  }
  EOT
}

variable "child_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the attached network (VPC or VBR)."
    },
    "Label": {
      "en": "ChildInstanceId",
      "zh-cn": "加载的网络实例ID（VPC或VBR的ID）"
    }
  }
  EOT
}

variable "child_instance_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region where the attached VBR or VPC is located."
    },
    "Label": {
      "en": "ChildInstanceRegionId",
      "zh-cn": "加载的网络实例的地域ID"
    }
  }
  EOT
}

resource "alicloud_cen_route_entry" "route_entry" {}

