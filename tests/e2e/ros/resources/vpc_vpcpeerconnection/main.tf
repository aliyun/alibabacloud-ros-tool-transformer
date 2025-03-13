variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the VPC peering connection.\nThe description must be 2 to 256 characters in length. It must start with a letter\nbut cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "需要创建的VPC对等连接描述信息"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to forcefully delete the VPC peering connection. Valid values:false (default): notrue: yes If you forcefully delete the VPC peering connection, the system deletes the routes that point to the VPC peering connection from the VPC route table."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除VPC对等连接"
    }
  }
  EOT
}

variable "accepting_vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the acceptor VPC."
    },
    "Label": {
      "en": "AcceptingVpcId",
      "zh-cn": "需要创建的VPC对等连接接收端的VPC ID"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The ID of the requester VPC."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "需要创建的VPC对等连接发起端的VPC ID"
    }
  }
  EOT
}

variable "accepting_region_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::RegionId",
    "Description": {
      "en": "The region ID of the acceptor VPC of the VPC peering connection that you want to create.\nTo create an intra-region VPC peering connection, enter a region ID that is the same\nas that of the requester VPC.\nTo create an inter-region VPC peering connection, enter a region ID that is different\nfrom that of the requester VPC.\nDefault current region."
    },
    "Label": {
      "en": "AcceptingRegionId",
      "zh-cn": "需要创建的VPC对等连接接收端的地域ID"
    }
  }
  EOT
}

variable "accepting_ali_uid" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Alibaba Cloud account to which the acceptor VPC belongs.\nTo create a VPC peering connection within your Alibaba Cloud account, enter the ID\nof your Alibaba Cloud account.\nTo create a VPC peering connection between your Alibaba Cloud account and another\nAlibaba Cloud account, enter the ID of the peer Alibaba Cloud account.\nNote If the acceptor VPC belongs to a Resource Access Management (RAM) user, you must set\nthe value of AcceptingAliUid to the ID of the corresponding Alibaba Cloud account.\nDefault current account ID."
    },
    "Label": {
      "en": "AcceptingAliUid",
      "zh-cn": "需要创建的VPC对等连接接收端的阿里云账号（主账号）ID"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the VPC peering connection.\nThe name must be 2 to 128 characters in length and can contain digits, underscores\n(_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "需要创建的VPC对等连接名称"
    }
  }
  EOT
}

resource "alicloud_vpc_peer_connection" "vpc_peer_connection" {
  description          = var.description
  accepting_vpc_id     = var.accepting_vpc_id
  vpc_id               = var.vpc_id
  accepting_region_id  = var.accepting_region_id
  accepting_ali_uid    = var.accepting_ali_uid
  peer_connection_name = var.name
}

output "instance_id" {
  value       = alicloud_vpc_peer_connection.vpc_peer_connection.id
  description = "The ID of the VPC peering connection."
}

