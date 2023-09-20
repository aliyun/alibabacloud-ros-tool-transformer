variable "slb_load_balancer_name" {
  default = "forSlbLoadBalancer"
}

data "alicloud_zones" "load_balancer" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "load_balancer" {
  vpc_name = var.slb_load_balancer_name
}

resource "alicloud_vswitch" "load_balancer" {
  vpc_id       = alicloud_vpc.load_balancer.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.load_balancer.zones[0].id
  vswitch_name = var.slb_load_balancer_name
}

resource "alicloud_slb_load_balancer" "load_balancer" {
  load_balancer_name = var.slb_load_balancer_name
  address_type       = "intranet"
  load_balancer_spec = "slb.s2.small"
  vswitch_id         = alicloud_vswitch.load_balancer.id
  tags = {
    info = "create for internet"
  }
  instance_charge_type = "PayBySpec"
}