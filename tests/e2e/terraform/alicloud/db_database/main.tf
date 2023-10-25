variable "name" {
  default = "tf-example"
}
data "alicloud_db_zones" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_db_instance" "default" {
  engine           = "MySQL"
  engine_version   = "5.6"
  instance_type    = "rds.mysql.s1.small"
  instance_storage = "10"
  vswitch_id       = alicloud_vswitch.default.id
  instance_name    = var.name
}

resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.default.id
  name        = var.name
}

output "id" {
  value = alicloud_db_database.default.id
}