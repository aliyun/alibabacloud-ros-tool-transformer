variable "accelerate_region" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IpVersion": {
          "Type": "String",
          "Description": {
            "en": "IP version. Valid values: IPv4, IPv6"
          },
          "AllowedValues": [
            "IPv4",
            "IPv6"
          ],
          "Required": false
        },
        "IspType": {
          "Type": "String",
          "Description": {
            "en": "Accelerated area public network line type."
          },
          "Required": false
        },
        "Bandwidth": {
          "Type": "Number",
          "Description": {
            "en": "The bandwidth allocated to the acceleration region. Unit: Mbit/s.\nNote\nThe minimum bandwidth allocated to each accelerated region is 2 Mbit/s.\nThe total bandwidth for all regions must not exceed the amount included in your basic\nbandwidth plan."
          },
          "Required": true,
          "MinValue": 2
        },
        "AccelerateRegionId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the region where traffic is to be accelerated."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "AccelerateRegion",
      "zh-cn": "要加速的地域"
    },
    "MaxLength": 5
  }
  EOT
}

variable "accelerator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the GA instance."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "全球加速实例ID"
    }
  }
  EOT
}

resource "alicloud_ga_ip_set" "ip_sets" {
  accelerator_id = var.accelerator_id
}

output "accelerate_region_ids" {
  // Could not transform ROS Attribute AccelerateRegionIds to Terraform attribute.
  value       = null
  description = "The ID list of the accelerate region."
}

output "ip_versions" {
  // Could not transform ROS Attribute IpVersions to Terraform attribute.
  value       = null
  description = "The IP version list of the accelerate region."
}

output "ip_set_ids" {
  // Could not transform ROS Attribute IpSetIds to Terraform attribute.
  value       = null
  description = "The ID list of the ip set."
}

