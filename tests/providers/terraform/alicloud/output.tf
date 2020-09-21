output "instance_id" {
  value = alicloud_instance.myinstance.id
}

output "const_map" {
  value = {
    foo = "bar"
  }
}

output "log_machine_group_id" {
  value = alicloud_log_machine_group.sls_machine_group.id
}
