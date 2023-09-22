variable "name" {
  default = "terraform-example"
}

variable "domain" {
  default = "terraform-example.com"
}

resource "alicloud_vpc_dhcp_options_set" "example" {
  dhcp_options_set_name        = var.name
  dhcp_options_set_description = var.name
  domain_name                  = var.domain
  domain_name_servers          = "100.100.2.136"
}