
resource "alicloud_slb_server_group_server_attachment" "server_attachment" {
  server_group_id = "fake-id"
  server_id       = "fake-id"
  port            = 8080
  weight          = 0
}