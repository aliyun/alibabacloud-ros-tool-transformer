variable "name" {
  default = "tf-testacc-example"
}

resource "alicloud_vpc_prefix_list" "default" {
  max_entries             = 50
  resource_group_id       = "resource_group_id"
  prefix_list_description = "test"
  ip_version              = "IPV4"
  prefix_list_name        = var.name
  entrys {
    cidr        = "192.168.0.0/16"
    description = "test"
  }
}