variable "domain_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The root domain, for example, example.com.\nAfter a DHCP options set is associated with a Virtual Private Cloud (VPC) network, the root domain in the DHCP options set is automatically synchronized to the ECS instances in the VPC network."
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "主机名后缀"
    }
  }
  EOT
}

variable "dhcp_options_set_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the DHCP options set.\nThe name must be 2 to 128 characters in length and can contain letters, Chinese characters, digits, underscores (_), and hyphens (-). It must start with a letter or a Chinese character."
    },
    "Label": {
      "en": "DhcpOptionsSetName",
      "zh-cn": "DHCP选项集的名称"
    }
  }
  EOT
}

variable "dhcp_options_set_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the DHCP options set.\nThe description must be 2 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "DhcpOptionsSetDescription",
      "zh-cn": "DHCP选项集的描述"
    }
  }
  EOT
}

variable "domain_name_servers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The DNS server IP addresses."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The DNS server IP addresses. Note Before you specify any DNS server IP address, all ECS instances in the associated VPC network use the IP addresses of the Alibaba Cloud DNS servers, which are 100.100.2.136 and 100.100.2.138."
    },
    "Label": {
      "en": "DomainNameServers",
      "zh-cn": "DNS服务器IP地址"
    },
    "MinLength": 0,
    "MaxLength": 4
  }
  EOT
}

resource "alicloud_vpc_dhcp_options_set" "dhcp_options_set" {
  domain_name                  = var.domain_name
  dhcp_options_set_name        = var.dhcp_options_set_name
  dhcp_options_set_description = var.dhcp_options_set_description
  domain_name_servers          = var.domain_name_servers
}

output "dhcp_options_set_id" {
  value       = alicloud_vpc_dhcp_options_set.dhcp_options_set.id
  description = "The ID of the DHCP options set that is created."
}

