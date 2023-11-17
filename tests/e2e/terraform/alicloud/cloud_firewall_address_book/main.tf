resource "alicloud_cloud_firewall_address_book" "example" {
  description      = "example_value"
  group_name       = "example_value"
  group_type       = "tag"
  tag_relation     = "and"
  auto_add_tag_ecs = 1
  ecs_tags {
    tag_key   = "created"
    tag_value = "tfTestAcc0"
  }
  address_list     = ["10.168.1.12", "10.168.1.11"]
}