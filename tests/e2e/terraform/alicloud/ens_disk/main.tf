variable "name" {
  default = "terraform-example"
}

resource "alicloud_ens_disk" "default" {
  category      = "cloud_ssd"
  size          = 20
  payment_type  = "PayAsYouGo"
  ens_region_id = "cn-chongqing-11"
}