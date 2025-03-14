variable "traffic_mirror_target_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the traffic mirror destination. You can specify only an elastic network interface (ENI) or a Server Load Balancer (SLB) instance as a traffic mirror destination."
    },
    "Label": {
      "en": "TrafficMirrorTargetId",
      "zh-cn": "镜像目的的实例ID"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the mirrored traffic belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "流量镜像所属的资源组ID"
    }
  }
  EOT
}

variable "virtual_network_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The VXLAN network identifier (VNI). Valid values: **0 to 16777215**. \nYou can use VNIs to identify mirrored traffic from different sessions at the traffic mirror destination. You can specify a custom VNI or use a random VNI allocated by the system. If you want the system to randomly allocate a VNI, do not enter a value."
    },
    "MinValue": 0,
    "Label": {
      "en": "VirtualNetworkId",
      "zh-cn": "指定VNI（VXLAN Network Identifier）"
    },
    "MaxValue": 16777215
  }
  EOT
}

variable "traffic_mirror_source_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of the traffic mirror source. You can specify only an ENI as the traffic mirror source. The default value of N is 1, which means that you can add only one traffic mirror source to a traffic mirror session."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "TrafficMirrorSourceIds",
      "zh-cn": "镜像源的实例ID"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the traffic mirror session. Valid values: **1 to 32766**.\nA smaller value indicates a higher priority. You cannot specify identical priorities for traffic mirror sessions that are created in the same region by using the same account."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "镜像会话的优先级"
    },
    "MaxValue": 32766
  }
  EOT
}

variable "packet_length" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum transmission unit (MTU). Default value: **1500**."
    },
    "Label": {
      "en": "PacketLength",
      "zh-cn": "最大传输单元MTU（Maximum Transmission Unit）"
    }
  }
  EOT
}

variable "enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the traffic mirror session. Valid values:\n- **false** (default): does not enable the traffic mirror session.\n- **true**: enables the traffic mirror session."
    },
    "Label": {
      "en": "Enabled",
      "zh-cn": "是否开启流量会话"
    }
  }
  EOT
}

variable "traffic_mirror_session_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the traffic mirror session.\nThe description must be 1 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "TrafficMirrorSessionDescription",
      "zh-cn": "镜像会话的描述信息"
    },
    "MinLength": 1,
    "MaxLength": 256
  }
  EOT
}

variable "tag" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Tag",
      "zh-cn": "镜像会话的标签"
    }
  }
  EOT
}

variable "traffic_mirror_session_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the traffic mirror session.\nThe name must be 1 to 128 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "TrafficMirrorSessionName",
      "zh-cn": "镜像会话的名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "traffic_mirror_filter_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the filter."
    },
    "Label": {
      "en": "TrafficMirrorFilterId",
      "zh-cn": "流量镜像筛选条件的实例ID"
    }
  }
  EOT
}

variable "traffic_mirror_target_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the traffic mirror destination. Valid values:\n- **NetworkInterface**: an ENI\n- **SLB**: an SLB instance"
    },
    "Label": {
      "en": "TrafficMirrorTargetType",
      "zh-cn": "镜像目的类型"
    }
  }
  EOT
}

resource "alicloud_vpc_traffic_mirror_session" "traffic_mirror_session" {
  traffic_mirror_target_id           = var.traffic_mirror_target_id
  resource_group_id                  = var.resource_group_id
  virtual_network_id                 = var.virtual_network_id
  traffic_mirror_source_ids          = var.traffic_mirror_source_ids
  priority                           = var.priority
  packet_length                      = var.packet_length
  enabled                            = var.enabled
  traffic_mirror_session_description = var.traffic_mirror_session_description
  tags                               = var.tag
  traffic_mirror_session_name        = var.traffic_mirror_session_name
  traffic_mirror_filter_id           = var.traffic_mirror_filter_id
  traffic_mirror_target_type         = var.traffic_mirror_target_type
}

output "traffic_mirror_session_id" {
  value       = alicloud_vpc_traffic_mirror_session.traffic_mirror_session.id
  description = "The ID of the traffic mirror session."
}

