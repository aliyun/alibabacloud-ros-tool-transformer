variable "vpc_cidr_blocks" {
  type = list(string)
  default = [
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}

variable "vsw_cidr_blocks" {
  type = list(string)
  default = [
    "172.16.0.0/24",
    "192.168.0.0/24",
  ]
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "single_vpc" {
  vpc_name   = "singlevpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vpc" "multi_vpcs" {
  count = length(var.vpc_cidr_blocks)

  vpc_name   = "multivpc-${count.index}"
  cidr_block = var.vpc_cidr_blocks[count.index]
}

resource "alicloud_vswitch" "multi_vsws" {
  count = length(var.vsw_cidr_blocks)

  vpc_id = alicloud_vpc.multi_vpcs[count.index].id
  cidr_block = var.vsw_cidr_blocks[count.index]
  zone_id = data.alicloud_zones.default.zones[count.index].id
}