variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones[0].id
  cpu_core_count    = 4
  memory_size       = 8
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ecs_instance_set" "instance_set" {
  amount                        = 10
  image_id                      = data.alicloud_images.default.images[0].id
  instance_type                 = data.alicloud_instance_types.default.instance_types[0].id
  instance_name                 = var.name
  instance_charge_type          = "PostPaid"
  system_disk_performance_level = "PL1"
  system_disk_category          = "cloud_essd"
  system_disk_size              = 200
  vswitch_id                    = alicloud_vswitch.default.id
  security_group_ids            = alicloud_security_group.default.*.id
  zone_id                       = data.alicloud_zones.default.zones[0].id
}