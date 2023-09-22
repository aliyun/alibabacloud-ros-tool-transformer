resource "alicloud_ecs_activation" "example" {
  description           = "terraform-example"
  instance_count        = 10
  instance_name         = "terraform-example"
  ip_address_range      = "0.0.0.0/0"
  time_to_live_in_hours = 4
}