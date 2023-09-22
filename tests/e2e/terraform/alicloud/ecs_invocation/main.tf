resource "alicloud_ecs_command" "default" {
  name            = "terraform-example"
  command_content = "bHMK"
  description     = "terraform-example"
  type            = "RunShellScript"
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "default" {
  command_id  = alicloud_ecs_command.default.id
  instance_id = ["i-xxx"]
}