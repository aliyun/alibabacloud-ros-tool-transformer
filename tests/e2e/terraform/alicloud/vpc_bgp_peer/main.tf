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

resource "alicloud_vpc_bgp_peer" "example" {
  bfd_multi_hop   = "10"
  bgp_group_id    = alicloud_vpc_bgp_group.example.id
  enable_bfd      = true
  ip_version      = "IPV4"
  peer_ip_address = "1.1.1.1"
}