variable "sourcevswitch_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Allow which switch can access internet.",
      "zh-cn": "不能同时指定交换机或ECS实例的网段和该参数，但必须指定其中之一。"
    },
    "Label": {
      "zh-cn": "通过NAT网关访问互联网的ECS实例所在的VSwitch ID"
    }
  }
  EOT
}

variable "snat_entry_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "he name of the SNAT rule is 2-128 characters long and must start with a letter or Chinese, but cannot begin with HTTP:// or https://."
    },
    "Label": {
      "en": "SnatEntryName",
      "zh-cn": "SNAT条目的名称"
    }
  }
  EOT
}

variable "sourcecidr" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the network segment of the switch. For example, 10.0.0.1/24. This parameter and the SourceVSwtichId parameter are mutually exclusive and cannot appear at the same time.",
      "zh-cn": "交换机或ECS实例的网段。  交换机粒度：指定交换机的网段（如192.168.1.0/24），当交换机下的ECS实例发起互联网访问请求时，NAT网关会为其提供SNAT服务（代理上网服务）。如果SnatIp仅指定了一个公网IP，ECS实例使用指定的公网IP访问互联网；如果SnatIp指定了多个公网IP，ECS实例随机使用SnatIp中的公网IP访问互联网。  ECS粒度：指定ECS实例的地址（如192.168.1.1/32），当ECS实例发起互联网访问请求时，NAT网关会为其提供SNAT服务（代理上网服务）。如果SnatIp仅指定了一个公网IP，ECS实例使用指定的公网IP访问互联网；如果SnatIp指定了多个公网IP，ECS实例随机使用SnatIp中的公网IP访问互联网。"
    },
    "Label": {
      "en": "SourceCIDR",
      "zh-cn": "交换机或ECS实例的网段"
    }
  }
  EOT
}

variable "snat_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Create SNAT entry in specified SNAT table."
    },
    "Label": {
      "en": "SNatTableId",
      "zh-cn": "源地址转换表ID"
    }
  }
  EOT
}

variable "snat_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source IP, must belongs to bandwidth package internet IP"
    },
    "Label": {
      "en": "SNatIp",
      "zh-cn": "用于源地址转换的公网IP"
    }
  }
  EOT
}

resource "alicloud_snat_entry" "snat_table_entry" {
  source_vswitch_id = var.sourcevswitch_id
  snat_entry_name   = var.snat_entry_name
  snat_table_id     = var.snat_table_id
  snat_ip           = var.snat_ip
}

output "snat_entry_id" {
  value       = alicloud_snat_entry.snat_table_entry.id
  description = "The id of created SNAT entry."
}

