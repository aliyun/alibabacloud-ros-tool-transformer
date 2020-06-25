output "instance_id" {
  value = alicloud_instance.myinstance.id
}

output "const_map" {
  value = {
    foo = "bar"
  }
}
