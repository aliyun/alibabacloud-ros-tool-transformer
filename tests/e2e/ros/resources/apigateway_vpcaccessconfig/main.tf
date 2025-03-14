variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The id of the VPC."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
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
      "en": "The id of the instance (ECS/SLB/ALB/NLB)."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "ECS或SLB的实例ID"
    }
  }
  EOT
}

variable "port" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The port of the VPC."
    },
    "MinValue": 1,
    "Label": {
      "en": "Port",
      "zh-cn": "实例对应的端口号"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of one VPC access configuration."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "自定义授权名称"
    }
  }
  EOT
}

resource "alicloud_api_gateway_vpc_access" "vpc_access_config" {
  vpc_id      = var.vpc_id
  instance_id = var.instance_id
  port        = var.port
  name        = var.name
}

