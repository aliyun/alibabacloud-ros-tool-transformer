variable "name" {
  default = "tf-example"
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}
resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_log_project" "example" {
  name        = "tf-example"
  description = var.name
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = var.name
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_vpc_flow_log" "example" {
  flow_log_name        = var.name
  log_store_name       = alicloud_log_store.example.name
  description          = var.name
  traffic_path         = ["all"]
  project_name         = alicloud_log_project.example.name
  resource_type        = "VPC"
  resource_group_id    = data.alicloud_resource_manager_resource_groups.default.ids.0
  resource_id          = alicloud_vpc.example.id
  aggregation_interval = "1"
  traffic_type         = "All"
}