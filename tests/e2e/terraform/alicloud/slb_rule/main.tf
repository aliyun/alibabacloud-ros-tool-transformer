variable "slb_rule_name" {
  default = "terraform-example"
}

data "alicloud_zones" "rule" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "rule" {
  availability_zone = data.alicloud_zones.rule.zones[0].id
  cpu_core_count    = 4
  memory_size       = 8
}

data "alicloud_images" "rule" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

resource "alicloud_vpc" "rule" {
  vpc_name   = var.slb_rule_name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "rule" {
  vpc_id       = alicloud_vpc.rule.id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alicloud_zones.rule.zones[0].id
  vswitch_name = var.slb_rule_name
}

resource "alicloud_security_group" "rule" {
  name   = var.slb_rule_name
  vpc_id = alicloud_vpc.rule.id
}

resource "alicloud_instance" "rule" {
  image_id                   = data.alicloud_images.rule.images[0].id
  instance_type              = data.alicloud_instance_types.rule.instance_types[0].id
  security_groups            = alicloud_security_group.rule.*.id
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = "10"
  availability_zone          = data.alicloud_zones.rule.zones[0].id
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_efficiency"
  vswitch_id                 = alicloud_vswitch.rule.id
  instance_name              = var.slb_rule_name
}

resource "alicloud_slb_load_balancer" "rule" {
  load_balancer_name   = var.slb_rule_name
  vswitch_id           = alicloud_vswitch.rule.id
  instance_charge_type = "PayByCLCU"
}

resource "alicloud_slb_listener" "rule" {
  load_balancer_id          = alicloud_slb_load_balancer.rule.id
  backend_port              = 22
  frontend_port             = 22
  protocol                  = "http"
  bandwidth                 = 5
  health_check_connect_port = "20"
}

resource "alicloud_slb_server_group" "rule" {
  load_balancer_id = alicloud_slb_load_balancer.rule.id
  name             = var.slb_rule_name
}

resource "alicloud_slb_rule" "rule" {
  load_balancer_id          = alicloud_slb_load_balancer.rule.id
  frontend_port             = alicloud_slb_listener.rule.frontend_port
  name                      = var.slb_rule_name
  domain                    = "*.aliyun.com"
  url                       = "/image"
  server_group_id           = alicloud_slb_server_group.rule.id
  cookie                    = "23ffsa"
  cookie_timeout            = 100
  health_check_http_code    = "http_2xx"
  health_check_interval     = 10
  health_check_uri          = "/test"
  health_check_connect_port = 80
  health_check_timeout      = 30
  healthy_threshold         = 3
  unhealthy_threshold       = 5
  sticky_session            = "on"
  sticky_session_type       = "server"
  listener_sync             = "off"
  scheduler                 = "rr"
  health_check_domain       = "test"
  health_check              = "on"
}