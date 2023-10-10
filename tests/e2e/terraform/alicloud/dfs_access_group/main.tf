variable "name" {
  default = "tf-example"
}

resource "alicloud_dfs_access_group" "default" {
  access_group_name = var.name
  network_type      = "VPC"
}