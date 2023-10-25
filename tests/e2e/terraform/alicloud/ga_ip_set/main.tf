resource "alicloud_ga_accelerator" "default" {
  duration        = 1
  auto_use_coupon = true
  spec            = "1"
}

resource "alicloud_ga_bandwidth_package" "default" {
  bandwidth      = 100
  type           = "Basic"
  bandwidth_type = "Basic"
  payment_type   = "PayAsYouGo"
  billing_type   = "PayBy95"
  ratio          = 30
}

resource "alicloud_ga_bandwidth_package_attachment" "default" {
  accelerator_id       = alicloud_ga_accelerator.default.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.default.id
}

resource "alicloud_ga_ip_set" "example" {
  accelerate_region_id = "cn-beijing"
  bandwidth            = "5"
  accelerator_id       = alicloud_ga_bandwidth_package_attachment.default.accelerator_id
}

output "ip_set_id" {
  value = alicloud_ga_ip_set.example.id
}

output "accelerate_region_id" {
  value = alicloud_ga_ip_set.example.accelerate_region_id
}

output "ip_version" {
  value = alicloud_ga_ip_set.example.ip_version
}