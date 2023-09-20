data "alicloud_zones" "example" {
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "example" {
  availability_zone = data.alicloud_zones.example.zones.0.id
  cpu_core_count    = 4
  memory_size       = 8
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.example.zones.0.id
}

resource "alicloud_security_group" "example" {
  name        = "terraform-example"
  description = "New security group"
  vpc_id      = alicloud_vpc.example.id
}

resource "alicloud_ecs_disk" "example" {
  disk_name = "terraform-example"
  zone_id   = data.alicloud_instance_types.example.instance_types.0.availability_zones.0
  category  = "cloud_efficiency"
  size      = "20"
}

data "alicloud_images" "example" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

resource "alicloud_instance" "example" {
  availability_zone = data.alicloud_zones.example.zones.0.id
  instance_name     = "terraform-example"
  image_id          = data.alicloud_images.example.images.0.id
  instance_type     = data.alicloud_instance_types.example.instance_types.0.id
  security_groups   = [alicloud_security_group.example.id]
  vswitch_id        = alicloud_vswitch.example.id
}

resource "alicloud_ecs_disk_attachment" "example" {
  disk_id     = alicloud_ecs_disk.example.id
  instance_id = alicloud_instance.example.id
}

resource "alicloud_ecs_snapshot" "example" {
  category       = "standard"
  description    = "terraform-example"
  disk_id        = alicloud_ecs_disk.example.id
  retention_days = "20"
  snapshot_name  = "terraform-example"
  tags = {
    Created = "TF"
    For     = "example"
  }
}