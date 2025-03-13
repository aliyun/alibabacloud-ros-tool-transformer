variable "eips" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Bandwidth": {
          "Type": "Number",
          "Description": {
            "en": "The maximum allocatable bandwidth value in Mbps within the shared bandwidth.\n0 which means no limit.\nDefault to no limit."
          },
          "Required": false,
          "MinValue": 0
        },
        "AllocationId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the EIP instance."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of eip associated with the Internet Shared Bandwidth instance."
    },
    "Label": {
      "en": "Eips",
      "zh-cn": "要添加的EIP"
    }
  }
  EOT
}

variable "bandwidth_package_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Internet Shared Bandwidth instance."
    },
    "Label": {
      "en": "BandwidthPackageId",
      "zh-cn": "共享带宽的ID"
    }
  }
  EOT
}

resource "alicloud_common_bandwidth_package_attachment" "common_bandwidth_package_ip" {
  bandwidth_package_id = var.bandwidth_package_id
}

output "ip_addresses" {
  // Could not transform ROS Attribute IpAddresses to Terraform attribute.
  value       = null
  description = "All eip addresses of common bandwidth package."
}

output "allocation_ids" {
  // Could not transform ROS Attribute AllocationIds to Terraform attribute.
  value       = null
  description = "All eip allocation ids of common bandwidth package."
}

