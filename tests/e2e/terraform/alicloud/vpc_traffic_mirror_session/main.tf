variable "name" {
  default = "tf-example"
}
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
}

data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
  available_instance_type     = data.alicloud_instance_types.default.instance_types.0.id
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name        = var.name
  description = var.name
  vpc_id      = alicloud_vpc.default.id
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}

resource "alicloud_instance" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  instance_name        = var.name
  host_name            = var.name
  image_id             = data.alicloud_images.default.images.0.id
  instance_type        = data.alicloud_instance_types.default.instance_types.0.id
  security_groups      = [alicloud_security_group.default.id]
  vswitch_id           = alicloud_vswitch.default.id
  system_disk_category = "cloud_essd"
}

resource "alicloud_ecs_network_interface" "default" {
  network_interface_name = var.name
  vswitch_id             = alicloud_vswitch.default.id
  security_group_ids     = [alicloud_security_group.default.id]
}

resource "alicloud_ecs_network_interface_attachment" "default" {
  instance_id          = alicloud_instance.default.id
  network_interface_id = alicloud_ecs_network_interface.default.id
}

resource "alicloud_vpc_traffic_mirror_filter" "default" {
  traffic_mirror_filter_name        = var.name
  traffic_mirror_filter_description = var.name
}


resource "alicloud_vpc_traffic_mirror_session" "default" {
  priority                           = 1
  virtual_network_id                 = 10
  traffic_mirror_session_description = var.name
  traffic_mirror_session_name        = var.name
  traffic_mirror_target_id           = alicloud_ecs_network_interface_attachment.default.network_interface_id
  traffic_mirror_source_ids          = [alicloud_ecs_network_interface_attachment.default.network_interface_id]
  traffic_mirror_filter_id           = alicloud_vpc_traffic_mirror_filter.default.id
  traffic_mirror_target_type         = "NetworkInterface"
}