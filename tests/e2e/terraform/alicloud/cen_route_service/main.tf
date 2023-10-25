
resource "alicloud_cen_route_service" "example" {
  access_region_id = "cn-beijing"
  host_region_id   = "cn-beijing"
  host_vpc_id      = "fake-id"
  cen_id           = "fake-id"
  host             = "100.118.28.52/32"
}

output "id" {
  value = alicloud_cen_route_service.example.id
}