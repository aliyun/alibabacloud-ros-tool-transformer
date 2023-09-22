variable "name" {
  default = "tf-example"
}

resource "alicloud_vpc_bgp_group" "example" {
  auth_key       = "YourPassword+12345678"
  bgp_group_name = var.name
  description    = var.name
  peer_asn       = 1111
  router_id      = "router_id"
  is_fake_asn    = true
}