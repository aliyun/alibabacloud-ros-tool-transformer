resource "alicloud_vpc_bgp_network" "example" {
  dst_cidr_block = "192.168.0.0/24"
  router_id      = "rouer_id"
}