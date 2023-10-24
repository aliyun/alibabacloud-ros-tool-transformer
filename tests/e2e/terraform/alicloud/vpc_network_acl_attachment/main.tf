data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = cidrsubnet(alicloud_vpc.default.cidr_block, 8, 2)
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_network_acl" "default" {
  vpc_id = alicloud_vswitch.default.vpc_id
}

resource "alicloud_vpc_network_acl_attachment" "default" {
  network_acl_id = alicloud_network_acl.default.id
  resource_id    = alicloud_vswitch.default.id
  resource_type  = "VSwitch"
}