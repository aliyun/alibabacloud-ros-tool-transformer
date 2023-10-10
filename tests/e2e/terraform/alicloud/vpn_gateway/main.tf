data "alicloud_zones" "foo" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "foo" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "foo" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.16.0.0/21"
  vpc_id       = alicloud_vpc.foo.id
  zone_id      = data.alicloud_zones.foo.zones.0.id
}

resource "alicloud_vpn_gateway" "foo" {
  name                 = "terraform-example"
  vpc_id               = alicloud_vpc.foo.id
  bandwidth            = "10"
  enable_ssl           = true
  instance_charge_type = "PrePaid"
  description          = "test_create_description"
  vswitch_id           = alicloud_vswitch.foo.id
}