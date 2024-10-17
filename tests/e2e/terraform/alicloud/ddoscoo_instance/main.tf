variable "name" {
  default = "tf-example"
}

resource "alicloud_ddoscoo_instance" "default" {
  name              = var.name
  base_bandwidth    = "30"
  bandwidth         = "30"
  service_bandwidth = "100"
  port_count        = "50"
  domain_count      = "50"
  product_type      = "ddoscoo"
  period            = "1"
}