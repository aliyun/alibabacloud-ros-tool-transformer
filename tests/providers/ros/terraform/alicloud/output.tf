output "vpc_name1" {
  value = local.CreateProdRes ? alicloud_vpc.vpc1.vpc_name : null
}

output "vpc_id2" {
  value = length(alicloud_vpc.vpc2[*].id) > 0 ? alicloud_vpc.vpc2[*].id : null
}

output "vpc_id3" {
  value = length(alicloud_vpc.vpc3[*].id) > 0 ? alicloud_vpc.vpc3[*].id : null
}

