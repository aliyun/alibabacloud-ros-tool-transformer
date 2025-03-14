variable "domain_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the domain."
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "域名"
    }
  }
  EOT
}

resource "alicloud_direct_mail_domain" "extension_resource" {
  domain_name = var.domain_name
}

output "spf_record" {
  // Could not transform ROS Attribute SpfRecord to Terraform attribute.
  value       = null
  description = "SPF record."
}

output "spf_auth_status" {
  // Could not transform ROS Attribute SpfAuthStatus to Terraform attribute.
  value       = null
  description = "SPF auth status."
}

output "cname_auth_status" {
  // Could not transform ROS Attribute CnameAuthStatus to Terraform attribute.
  value       = null
  description = "Cname auth status."
}

output "domain_name" {
  value       = alicloud_direct_mail_domain.extension_resource.domain_name
  description = "The name of the domain."
}

output "dns_mx" {
  // Could not transform ROS Attribute DnsMx to Terraform attribute.
  value       = null
  description = "DNS MX."
}

output "cname_record" {
  // Could not transform ROS Attribute CnameRecord to Terraform attribute.
  value       = null
  description = "Cname record."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The creation time of the domain."
}

output "dns_txt" {
  // Could not transform ROS Attribute DnsTxt to Terraform attribute.
  value       = null
  description = "DNS txt."
}

output "cname_confirm_status" {
  // Could not transform ROS Attribute CnameConfirmStatus to Terraform attribute.
  value       = null
  description = "Cname confirm status."
}

output "icp_status" {
  // Could not transform ROS Attribute IcpStatus to Terraform attribute.
  value       = null
  description = "ICP status."
}

output "mx_record" {
  // Could not transform ROS Attribute MxRecord to Terraform attribute.
  value       = null
  description = "MX Record."
}

output "dns_spf" {
  // Could not transform ROS Attribute DnsSpf to Terraform attribute.
  value       = null
  description = "DNS SPF."
}

output "default_domain" {
  // Could not transform ROS Attribute DefaultDomain to Terraform attribute.
  value       = null
  description = "Default domain."
}

output "domain_id" {
  value       = alicloud_direct_mail_domain.extension_resource.id
  description = "The ID of the domain."
}

output "domain_type" {
  // Could not transform ROS Attribute DomainType to Terraform attribute.
  value       = null
  description = "The type of the domain."
}

output "tl_domain_name" {
  // Could not transform ROS Attribute TlDomainName to Terraform attribute.
  value       = null
  description = "TL domain name."
}

output "mx_auth_status" {
  // Could not transform ROS Attribute MxAuthStatus to Terraform attribute.
  value       = null
  description = "MX auth status."
}

output "tracef_record" {
  // Could not transform ROS Attribute TracefRecord to Terraform attribute.
  value       = null
  description = "Tracef Record."
}

