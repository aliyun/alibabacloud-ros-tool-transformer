variable "name" {
  default = "tf-example"
}

data "alicloud_elasticsearch_zones" "default" {}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.1.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_elasticsearch_zones.default.zones.0.id
}

resource "alicloud_elasticsearch_instance" "default" {
  description                      = var.name
  vswitch_id                       = alicloud_vswitch.default.id
  password                         = "******"
  version                          = "7.10_with_X-Pack"
  instance_charge_type             = "PostPaid"
  data_node_amount                 = "2"
  data_node_spec                   = "elasticsearch.sn2ne.large"
  data_node_disk_size              = "20"
  data_node_disk_type              = "cloud_ssd"
  kibana_node_spec                 = "elasticsearch.sn2ne.large"
  data_node_disk_performance_level = "PL1"
  tags = {
    Created = "TF",
    For     = "example",
  }
}