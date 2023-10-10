variable "name" {
  default = "terraform-example"
}

data "alicloud_adb_zones" "default" {
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.0.0/24"
  zone_id      = data.alicloud_adb_zones.default.zones[0].id
  vswitch_name = var.name
}

resource "alicloud_adb_db_cluster" "default" {
  db_cluster_category = "Cluster"
  db_node_class       = "C8"
  db_node_count       = "4"
  db_node_storage     = "400"
  mode                = "reserver"
  db_cluster_version  = "3.0"
  payment_type        = "PayAsYouGo"
  vswitch_id          = alicloud_vswitch.default.id
  description         = var.name
  maintain_time       = "23:00Z-00:00Z"
  resource_group_id   = data.alicloud_resource_manager_resource_groups.default.ids.0
  security_ips        = ["10.168.1.12", "10.168.1.11"]
  tags = {
    Created = "TF",
    For     = "example",
  }
}