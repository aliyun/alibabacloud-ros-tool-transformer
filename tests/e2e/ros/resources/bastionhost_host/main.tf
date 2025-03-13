variable "comment" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the host that you want to create. The value can be up to 500 characters."
    },
    "Label": {
      "en": "Comment",
      "zh-cn": "指定主机的备注信息"
    },
    "MaxLength": 500
  }
  EOT
}

variable "active_address_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Private",
      "Public"
    ],
    "Description": {
      "en": "The endpoint type of the host that you want to create. Valid values:\nPublic: a public endpoint\nPrivate: an internal endpoint"
    },
    "Label": {
      "en": "ActiveAddressType",
      "zh-cn": "指定新创建主机的地址类型"
    }
  }
  EOT
}

variable "instance_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region where the ECS instance or dedicated cluster host that you want to create resides.\nNote: This parameter is required if the Source parameter is set to Ecs or Rds."
    },
    "Label": {
      "en": "InstanceRegionId",
      "zh-cn": "指定新创建的ECS实例或专属集群主机所属区域ID"
    }
  }
  EOT
}

variable "host_private_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The internal endpoint of the host that you want to create. You can set this parameter to a domain name or an IP address.\nNote: This parameter is required if the ActiveAddressType parameter is set to Private."
    },
    "Label": {
      "en": "HostPrivateAddress",
      "zh-cn": "指定新创建主机的私网地址"
    }
  }
  EOT
}

variable "host_public_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The public endpoint of the host that you want to create. You can set this parameter to a domain name or an IP address.\nNote: This parameter is required if the ActiveAddressType parameter is set to Public."
    },
    "Label": {
      "en": "HostPublicAddress",
      "zh-cn": "指定新创建主机的公网地址"
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
      "en": "The ID of the Bastionhost instance where you want to create the host.\nNote: You can call the DescribeInstances operation to query the ID of the Bastionhost instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "指定新创建主机所在堡垒机的实例ID"
    }
  }
  EOT
}

variable "ostype" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Linux",
      "Windows"
    ],
    "Description": {
      "en": "The operating system of the host that you want to create. Valid values:\n- Linux\n- Windows"
    },
    "Label": {
      "en": "OSType",
      "zh-cn": "指定新创建主机的操作系统"
    }
  }
  EOT
}

variable "source_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the ECS instance or dedicated cluster host that you want to create.\nNote This parameter is required if the Source parameter is set to Ecs or Rds."
    },
    "Label": {
      "en": "SourceInstanceId",
      "zh-cn": "指定新创建的ECS实例ID或专属集群主机ID"
    }
  }
  EOT
}

variable "host_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the host that you want to create. The name can be up to 128 characters in length."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "指定新创建主机的名称"
    },
    "MaxLength": 128
  }
  EOT
}

variable "source_cfe3d353" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Ecs",
      "Local",
      "Rds"
    ],
    "Description": {
      "en": "The source of the host that you want to create. Valid values:\n- Local: an on-premises host\n- Ecs: an Elastic Compute Service (ECS) instance\n- Rds: a host in a dedicated cluster"
    },
    "Label": {
      "en": "Source",
      "zh-cn": "指定新创建主机的来源"
    }
  }
  EOT
}

resource "alicloud_bastionhost_host" "host" {
  comment              = var.comment
  active_address_type  = var.active_address_type
  instance_region_id   = var.instance_region_id
  host_private_address = var.host_private_address
  host_public_address  = var.host_public_address
  instance_id          = var.instance_id
  source_instance_id   = var.source_instance_id
  host_name            = var.host_name
  source               = var.source_cfe3d353
}

output "host_id" {
  value       = alicloud_bastionhost_host.host.id
  description = "The ID of the host that was created."
}

