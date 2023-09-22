variable "name" {
  default = "terraform-example"
}

resource "alicloud_resource_manager_resource_group" "default3iXhoa" {
  display_name        = "testname03"
  resource_group_name = var.name
}

resource "alicloud_resource_manager_resource_group" "defaultdNz2qk" {
  display_name        = "testname04"
  resource_group_name = "${var.name}1"
}


resource "alicloud_vpc_traffic_mirror_filter" "default" {
  traffic_mirror_filter_description = "test"
  traffic_mirror_filter_name        = var.name
  resource_group_id                 = alicloud_resource_manager_resource_group.default3iXhoa.id
  egress_rules {
    priority               = 1
    protocol               = "TCP"
    action                 = "accept"
    destination_cidr_block = "32.0.0.0/4"
    destination_port_range = "80/80"
    source_cidr_block      = "16.0.0.0/4"
    source_port_range      = "80/80"
  }
  ingress_rules {
    priority               = 1
    protocol               = "TCP"
    action                 = "accept"
    destination_cidr_block = "10.64.0.0/10"
    destination_port_range = "80/80"
    source_cidr_block      = "10.0.0.0/8"
    source_port_range      = "80/80"
  }
}