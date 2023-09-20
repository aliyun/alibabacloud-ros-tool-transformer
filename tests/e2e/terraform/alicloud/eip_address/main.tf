variable "name" {
  default = "terraform-example"
}


resource "alicloud_eip_address" "default" {
  description               = "test"
  isp                       = "BGP"
  address_name              = var.name
  netmode                   = "public"
  bandwidth                 = "1"
  security_protection_types = ["AntiDDoS_Enhanced"]
  payment_type              = "PayAsYouGo"
}
