variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "An IP address in the CIDR block of the VSwitch.\nIf you leave the option empty, the system allocates a private IP address according to the VPC ID and VSwitch ID."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "交换机网段内的一个私网IP地址"
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
      "en": "ECS/SLB/NAT/HaVip/ENI instance id to bid the EIP."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "云产品实例的ID"
    },
    "MinLength": 1
  }
  EOT
}

variable "mode" {
  type        = string
  default     = "NAT"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "DescriptionMapping": {
        "NAT": {
          "en": "<b>NAT Mode</b><br/>1. If you associate an EIP with an ENI in NAT mode, the private IP address and public IP address of the ENI are both available.<br/>2. You cannot view the EIP on the operating system. However, you can query the EIP associated with a specific ENI by using OpenAPI.<br/>3. This mode does not support NAT ALG protocols such as H.323, SIP, DNS, RTSP, or TFTP.",
          "zh-cn": "<b>普通模式</b><br/>1. EIP以NAT模式和弹性网卡绑定，弹性网卡的私网IP地址和公网IP地址同时可用。<br/>2. EIP在OS内部不可见，需要通过Open API查询出具体网卡上绑定的公网IP地址。<br/>3. 不支持需要做NAT ALG的协议，如H.323、SIP、DNS、RTSP、TFTP等协议。"
        },
        "BINDED": {
          "en": "<b>Cut-Through Mode</b><br/>1. You can query the EIP of the ENI by running the ifconfig/ipconfig command. This facilitates O&M.<br/>2. If you associate an EIP with an ENI, all IP protocols are supported, such as FTP, H.323, SIP, DNS, RTSP, and TFTP.<br/>3. If you replace the private IP address of an ENI with an EIP, the private network feature of the ENI is unavailable.<br/>4. In this mode, an EIP can be associated only with an ENI that is not associated with an ECS instance. If the ENI is already associated with an ECS instance, disassociate the ENI from the ECS instance first.",
          "zh-cn": "<b>EIP网卡可见模式</b><br/>1. EIP将在OS内部的弹性网卡上可见，可直接通过ifconfig/ipconfig获取出网卡上的公网IP地址，更易于运维。<br/>2. 和网卡直接绑定，支持全部IP协议类型，支持FTP、H.323、SIP、DNS、RTSP、TFTP等协议。<br/>3. EIP将替换掉弹性网卡的私网IP，网卡将变为一个纯公网网卡，私网功能不再可用。<br/>4. 该模式下只支持绑定到未和ECS关联的弹性网卡。如网卡已和ECS关联，请先解关联后再绑定EIP。"
        },
        "MULTI_BINDED": {
          "en": "<b>Multi-EIP-to-ENI Mode</b><br/>1. In this mode, you can associate an EIP only with a secondary ENI that is not associated with an EIP in NAT or cut-through mode.<br/>2. After you associate an EIP with a secondary ENI, you can view the EIP on the ENI.<br/>3. After you associate an EIP with a secondary ENI, all IP protocols are supported.",
          "zh-cn": "<b>多EIP网卡可见模式</b><br/>1. 该模式EIP只支持绑定到辅助弹性网卡，且该弹性网卡未绑定NAT模式、网卡直通模式的EIP。<br/>2. EIP和网卡直接绑定后，将在OS内部的弹性网卡上可见。<br/>3. EIP和网卡直接绑定后，将支持全部IP协议类型。"
        }
      }
    },
    "Description": {
      "en": "The mode of association. Valid values:\nNAT(Default): NAT mode.\nBINDED: Cut-through mode.\nMULTI_BINDED: Multi-EIP to ENI mode.\nThis is required only when the value of InstanceType is NetworkInterface."
    },
    "AllowedValues": [
      "NAT",
      "MULTI_BINDED",
      "BINDED"
    ],
    "Label": {
      "en": "Mode",
      "zh-cn": "绑定模式"
    }
  }
  EOT
}

variable "allocation_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "EIP instance id to bind."
    },
    "Label": {
      "en": "AllocationId",
      "zh-cn": "弹性公网IP的ID"
    },
    "MinLength": 1
  }
  EOT
}

resource "alicloud_eip_association" "elastic_ip_association" {
  private_ip_address = var.private_ip_address
  instance_id        = var.instance_id
  mode               = var.mode
  allocation_id      = var.allocation_id
}

output "allocation_id" {
  value       = alicloud_eip_association.elastic_ip_association.allocation_id
  description = "ID that Aliyun assigns to represent the allocation of the address for use with VPC. Returned only for VPC elastic IP addresses."
}

output "eip_address" {
  // Could not transform ROS Attribute EipAddress to Terraform attribute.
  value       = null
  description = "IP address of created EIP."
}

