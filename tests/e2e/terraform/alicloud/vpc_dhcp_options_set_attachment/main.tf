variable "name" {
  default = "tf-example"
}
resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vpc_dhcp_options_set" "example" {
  dhcp_options_set_name        = var.name
  dhcp_options_set_description = var.name
  domain_name                  = "example.com"
  domain_name_servers          = "100.100.2.136"
}
resource "alicloud_vpc_dhcp_options_set_attachment" "example" {
  vpc_id              = alicloud_vpc.example.id
  dhcp_options_set_id = alicloud_vpc_dhcp_options_set.example.id
}