variable "endpoint_region" {
  default = "cn-hangzhou"
}

resource "alicloud_ga_basic_accelerator" "default" {
  duration               = 1
  basic_accelerator_name = "terraform-example"
  description            = "terraform-example"
  bandwidth_billing_type = "CDT"
  auto_use_coupon        = "true"
  auto_pay               = true
}

resource "alicloud_ga_basic_ip_set" "default" {
  accelerator_id       = alicloud_ga_basic_accelerator.default.id
  accelerate_region_id = var.endpoint_region
  isp_type             = "BGP"
  bandwidth            = "5"
}

resource "alicloud_ga_basic_accelerate_ip" "default" {
  accelerator_id = alicloud_ga_basic_accelerator.default.id
  ip_set_id      = alicloud_ga_basic_ip_set.default.id
}
