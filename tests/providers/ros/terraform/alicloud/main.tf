resource "alicloud_vpc" "vpc1" {
  vpc_name   = local.CreateProdRes ? "ProdVpc" : var.env_type
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vpc" "vpc2" {
  count       = local.CreateProdRes ? 1 : 0
  vpc_name    = "prod"
  cidr_block  = "192.168.0.0/16"
  description = "Test description"
}

resource "alicloud_vpc" "vpc3" {
  count = local.CreateProdRes ? var.count_becd3406 : 0
  depends_on = [
    alicloud_vpc.vpc2
  ]
}

