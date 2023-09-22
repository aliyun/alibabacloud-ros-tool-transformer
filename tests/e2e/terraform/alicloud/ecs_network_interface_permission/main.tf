data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_account" "default" {}
data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ecs_network_interface" "default" {
  network_interface_name = "terraform-example"
  vswitch_id             = alicloud_vswitch.default.id
  security_group_ids     = [alicloud_security_group.default.id]
  description            = "terraform-example"
  primary_ip_address     = cidrhost(alicloud_vswitch.default.cidr_block, 100)
  tags = {
    Created = "TF",
    For     = "example",
  }
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
}

resource "alicloud_ecs_network_interface_permission" "example" {
  account_id           = data.alicloud_account.default.id
  network_interface_id = alicloud_ecs_network_interface.default.id
  permission           = "InstanceAttach"
  force                = true
}