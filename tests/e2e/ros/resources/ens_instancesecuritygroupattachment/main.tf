variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance ID."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security group ID."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

resource "alicloud_ens_instance_security_group_attachment" "extension_resource" {
  instance_id       = var.instance_id
  security_group_id = var.security_group_id
}

output "instance_id" {
  value       = alicloud_ens_instance_security_group_attachment.extension_resource.instance_id
  description = "Instance ID."
}

output "security_group_id" {
  value       = alicloud_ens_instance_security_group_attachment.extension_resource.security_group_id
  description = "Security group ID."
}

