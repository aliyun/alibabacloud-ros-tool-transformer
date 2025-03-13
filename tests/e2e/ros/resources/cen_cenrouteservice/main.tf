variable "conflict_ignore" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to ignore conflict when creating. If true, when the CloudRoute.Conflict error code is encountered during creation, it will be ignored as the creation is successful, and the deletion phase will be skipped.\nDefault false.",
      "zh-cn": "为云企业网设置访问云服务，遇到错误冲突时是否忽略冲突。"
    },
    "Label": {
      "en": "ConflictIgnore",
      "zh-cn": "为云企业网设置访问云服务"
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
      "en": "The description of the cloud service."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "云服务的描述信息"
    }
  }
  EOT
}

variable "host_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The region where the cloud service is deployed.\nYou can call the DescribeRegions operation to query region IDs.\nNote The HostRegionId and AccessRegionIds.N must be set to the same value."
    },
    "Label": {
      "en": "HostRegionId",
      "zh-cn": "云服务所在的地域ID"
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
      "en": "The ID of the Cloud Enterprise Network (CEN) instance."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例ID"
    }
  }
  EOT
}

variable "access_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The region where the cloud service is deployed."
    },
    "Label": {
      "en": "AccessRegionId",
      "zh-cn": "访问云服务的地域ID"
    }
  }
  EOT
}

variable "host" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The domain or IP address of the cloud service."
    },
    "Label": {
      "en": "Host",
      "zh-cn": "云服务IP地址或地址段"
    }
  }
  EOT
}

variable "host_vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The virtual private cloud (VPC) that is associated with the cloud service."
    },
    "Label": {
      "en": "HostVpcId",
      "zh-cn": "云服务关联的VPC实例ID"
    }
  }
  EOT
}

resource "alicloud_cen_route_service" "cen_route_service" {
  description      = var.description
  host_region_id   = var.host_region_id
  cen_id           = var.cen_id
  access_region_id = var.access_region_id
  host             = var.host
  host_vpc_id      = var.host_vpc_id
}

output "id" {
  value       = alicloud_cen_route_service.cen_route_service.id
  description = "The ID of the cloud service. It is formatted to {CenId}/{HostRegionId}/{Host}/{AccessRegionId}"
}

