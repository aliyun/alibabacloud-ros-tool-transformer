variable "vbr_instance_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region where the VBR instance is deployed. You can call the DescribeRegionsoperation to query region IDs."
    },
    "Label": {
      "en": "VbrInstanceRegionId",
      "zh-cn": "VBR实例所在的地域"
    }
  }
  EOT
}

variable "health_check_interval" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the time interval at which probe packets are sent during the health check.  Default value: 2. Valid values: 2 to 3.  Unit: second."
    },
    "Label": {
      "en": "HealthCheckInterval",
      "zh-cn": "健康检查发送连续探测报文的时间间隔"
    }
  }
  EOT
}

variable "vbr_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the VBR instance."
    },
    "Label": {
      "en": "VbrInstanceId",
      "zh-cn": "VBR实例ID"
    }
  }
  EOT
}

variable "vbr_instance_owner_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The User ID (UID) of the account to which the VBR instance belongs."
    },
    "Label": {
      "en": "VbrInstanceOwnerId",
      "zh-cn": "VBR所属账号的UID"
    }
  }
  EOT
}

variable "health_check_source_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "You can use either of the following methods to specify the source IP address of the health check.  Automatic IP Address: The system automatically assigns an IP address within the CIDR block 100.96.0.0/16 (recommended).  Custom IP Address: You can specify a source IP address that is available within the CIDR block 10.0.0.0/8, 192.168.0.0/16, or 172.16.0.0/12. The specified source IP address must not overlap with the IP addresses of the Alibaba Cloud-facing and client-facing interfaces on the VBR instance, or the IP addresses of the instances with which the VBR instance needs to communicate in the CEN."
    },
    "Label": {
      "en": "HealthCheckSourceIp",
      "zh-cn": "健康检查的源IP地址"
    }
  }
  EOT
}

variable "healthy_threshold" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the number of probe packets to be sent during the health check.  Default value: 8. Valid values: 3 to 8.  Unit: packet."
    },
    "Label": {
      "en": "HealthyThreshold",
      "zh-cn": "健康检查发送探测报文的个数"
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
      "en": "The ID of the CEN instance."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例ID"
    }
  }
  EOT
}

variable "health_check_target_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the destination IP address of the health check. The destination IP address is the IP address of the client-facing interface on the VBR instance."
    },
    "Label": {
      "en": "HealthCheckTargetIp",
      "zh-cn": "健康检查的目标IP地址"
    }
  }
  EOT
}

resource "alicloud_cen_vbr_health_check" "cencen_vbr_health_check" {
  vbr_instance_region_id = var.vbr_instance_region_id
  health_check_interval  = var.health_check_interval
  vbr_instance_id        = var.vbr_instance_id
  vbr_instance_owner_id  = var.vbr_instance_owner_id
  health_check_source_ip = var.health_check_source_ip
  healthy_threshold      = var.healthy_threshold
  cen_id                 = var.cen_id
  health_check_target_ip = var.health_check_target_ip
}

output "vbr_instance_region_id" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.vbr_instance_region_id
  description = "The ID of the region where the VBR instance is deployed. You can call the DescribeRegionsoperation to query region IDs."
}

output "health_check_interval" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.health_check_interval
  description = "Specifies the time interval at which probe packets are sent during the health check.  Default value: 2. Valid values: 2 to 3.  Unit: second."
}

output "vbr_instance_id" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.vbr_instance_id
  description = "The ID of the VBR instance."
}

output "vbr_instance_owner_id" {
  // Could not transform ROS Attribute VbrInstanceOwnerId to Terraform attribute.
  value       = null
  description = "The User ID (UID) of the account to which the VBR instance belongs."
}

output "health_check_source_ip" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.health_check_source_ip
  description = "You can use either of the following methods to specify the source IP address of the health check.  Automatic IP Address: The system automatically assigns an IP address within the CIDR block 100.96.0.0/16 (recommended).  Custom IP Address: You can specify a source IP address that is available within the CIDR block 10.0.0.0/8, 192.168.0.0/16, or 172.16.0.0/12. The specified source IP address must not overlap with the IP addresses of the Alibaba Cloud-facing and client-facing interfaces on the VBR instance, or the IP addresses of the instances with which the VBR instance needs to communicate in the CEN."
}

output "healthy_threshold" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.healthy_threshold
  description = "Specifies the number of probe packets to be sent during the health check.  Default value: 8. Valid values: 3 to 8.  Unit: packet."
}

output "cen_id" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.cen_id
  description = "The ID of the CEN instance."
}

output "health_check_target_ip" {
  value       = alicloud_cen_vbr_health_check.cencen_vbr_health_check.health_check_target_ip
  description = "Specifies the destination IP address of the health check. The destination IP address is the IP address of the client-facing interface on the VBR instance."
}

