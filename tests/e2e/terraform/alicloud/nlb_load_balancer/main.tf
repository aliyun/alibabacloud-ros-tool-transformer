variable "name" {
  default = "tf-example"
}
data "alicloud_resource_manager_resource_groups" "default" {}
data "alicloud_nlb_zones" "default" {}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default1" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.1.0/24"
  zone_id      = data.alicloud_nlb_zones.default.zones.0.id
  vswitch_name = format("${var.name}_1")
}

resource "alicloud_vswitch" "default2" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.2.0/24"
  zone_id      = data.alicloud_nlb_zones.default.zones.1.id
  vswitch_name = format("${var.name}_2")
}

resource "alicloud_nlb_load_balancer" "default" {
  load_balancer_name = var.name
  resource_group_id  = data.alicloud_resource_manager_resource_groups.default.ids.0
  load_balancer_type = "Network"
  address_type       = "Internet"
  address_ip_version = "Ipv4"
  vpc_id             = alicloud_vpc.default.id
  tags = {
    Created = "TF",
    For     = "example",
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.default1.id
    zone_id    = data.alicloud_nlb_zones.default.zones.0.id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.default2.id
    zone_id    = data.alicloud_nlb_zones.default.zones.1.id
  }
}