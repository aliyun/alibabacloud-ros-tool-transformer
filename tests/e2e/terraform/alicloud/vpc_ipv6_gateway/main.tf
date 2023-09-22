variable "name" {
  default = "tf-testacc-example"
}

resource "alicloud_vpc" "defaultVpc" {
  description = "tf-testacc"
  enable_ipv6 = true
}

resource "alicloud_resource_manager_resource_group" "defaultRg" {
  display_name        = "tf-testacc-ipv6gateway503"
  resource_group_name = "${var.name}1"
}

resource "alicloud_resource_manager_resource_group" "changeRg" {
  display_name        = "tf-testacc-ipv6gateway311"
  resource_group_name = "${var.name}2"
}


resource "alicloud_vpc_ipv6_gateway" "default" {
  description       = "test"
  ipv6_gateway_name = var.name
  vpc_id            = alicloud_vpc.defaultVpc.id
  resource_group_id = alicloud_resource_manager_resource_group.defaultRg.id
}