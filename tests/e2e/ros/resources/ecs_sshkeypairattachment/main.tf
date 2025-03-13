variable "key_pair_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "SSH key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "SSH密钥对的名称 "
    }
  }
  EOT
}

variable "auto_reboot" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "If the instance is running, whether to reboot the instance for the ssh key to take effect.\nDefault: false",
      "zh-cn": "如果实例处于运行状态，是否需要重启实例使ssh密钥生效。"
    },
    "Label": {
      "en": "AutoReboot",
      "zh-cn": "如果实例处于运行状态"
    }
  }
  EOT
}

variable "instance_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The comma delimited ECS instance id list. Only support Linux."
    },
    "Label": {
      "en": "InstanceIds",
      "zh-cn": "要绑定的ECS实例ID列表"
    }
  }
  EOT
}

resource "alicloud_ecs_key_pair_attachment" "sshkey_pair_attachment" {
  key_pair_name = var.key_pair_name
  instance_ids  = var.instance_ids
}

