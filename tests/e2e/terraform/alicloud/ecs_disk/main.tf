data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_kms_key" "example" {
  description            = "terraform-example"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

resource "alicloud_ecs_disk" "example" {
  zone_id     = data.alicloud_zones.example.zones.0.id
  disk_name   = "terraform-example"
  description = "terraform-example"
  category    = "cloud_efficiency"
  size        = "30"
  encrypted   = true
  kms_key_id  = alicloud_kms_key.example.id
  tags = {
    Name = "terraform-example"
  }
}