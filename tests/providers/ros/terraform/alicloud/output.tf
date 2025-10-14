output "console__web_url" {
  value       = "http://${alicloud_alb_load_balancer.alb.dns_name}"
  description = <<EOT
  {
    "zh-cn": "Web 访问地址。",
    "en": "The Addresses of Web."
  }
  EOT
}

