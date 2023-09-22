variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "default" {
  vpc_name    = var.name
  enable_ipv6 = "true"
  cidr_block  = "172.16.0.0/12"
}

resource "alicloud_vpc_ipv6_gateway" "example" {
  ipv6_gateway_name = "example_value"
  vpc_id            = alicloud_vpc.default.id
}

resource "alicloud_vpc_ipv6_internet_bandwidth" "example" {
  ipv6_address_id      = "ipv6_address_id"
  ipv6_gateway_id      = alicloud_vpc_ipv6_gateway.example.ipv6_gateway_id
  internet_charge_type = "PayByBandwidth"
  bandwidth            = "20"
}