output "single_vpc_id" {
  value = alicloud_vpc.single_vpc.id
}

output "multi_vsws_ids" {
  value = alicloud_vswitch.multi_vsws.*.id
}

output "mutil_vsws_first_id" {
  value = alicloud_vswitch.multi_vsws.0.id
}
