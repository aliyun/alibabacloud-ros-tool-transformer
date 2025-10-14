resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${var.common_name}-vpc"
}

resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = var.zone_id1
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = var.zone_id2
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = var.zone_id1
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch4" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = var.zone_id2
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch5" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.5.0/24"
  zone_id      = var.zone_id1
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch6" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.6.0/24"
  zone_id      = var.zone_id2
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${var.common_name}-sg"
}

resource "alicloud_ecs_instance_set" "ecs_instance1" {
  zone_id                    = var.zone_id1
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  security_group_ids         = [alicloud_security_group.security_group.id]
  image_id                   = "aliyun_3_x64_20G_alibase_20240528.vhd"
  instance_name              = "${var.common_name}-ecs-1"
  instance_type              = var.instance_type1
  system_disk_category       = "cloud_essd"
  amount                     = 1
  internet_max_bandwidth_out = 0
  password                   = var.instance_password
}

resource "alicloud_ecs_instance_set" "ecs_instance2" {
  zone_id                    = var.zone_id2
  vswitch_id                 = alicloud_vswitch.vswitch2.id
  security_group_ids         = [alicloud_security_group.security_group.id]
  image_id                   = "aliyun_3_x64_20G_alibase_20240528.vhd"
  instance_name              = "${var.common_name}-ecs-2"
  instance_type              = var.instance_type2
  system_disk_category       = "cloud_essd"
  amount                     = 1
  internet_max_bandwidth_out = 0
  password                   = var.instance_password
}

resource "alicloud_alb_load_balancer" "alb" {
  load_balancer_name     = "${var.common_name}-alb"
  load_balancer_edition  = "Basic"
  vpc_id                 = alicloud_vpc.vpc.id
  address_type           = "Internet"
  address_allocated_mode = "Fixed"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    zone_id    = var.zone_id1
    vswitch_id = alicloud_vswitch.vswitch3.id
  }
  zone_mappings {
    zone_id    = var.zone_id2
    vswitch_id = alicloud_vswitch.vswitch4.id
  }
}

resource "alicloud_alb_server_group" "alb_server_group" {
  vpc_id            = alicloud_vpc.vpc.id
  server_group_type = "Instance"
  server_group_name = "${var.common_name}-server-group"
  health_check_config {
    health_check_connect_port = 80
    health_check_protocol     = "HTTP"
    health_check_enabled      = true
    health_check_path         = "/"
    health_check_codes = [
      "http_2xx",
      "http_3xx"
    ]
  }
}

resource "alicloud_alb_listener" "alb_listener" {
  listener_port     = 80
  load_balancer_id  = alicloud_alb_load_balancer.alb.id
  listener_protocol = "HTTP"
  default_actions {
    type = "ForwardGroup"
  }
}

resource "alicloud_db_instance" "rds_instance" {
  instance_type            = var.dbinstance_class
  zone_id                  = var.zone_id1
  instance_storage         = 40
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  vswitch_id               = alicloud_vswitch.vswitch5.id
  engine                   = "MySQL"
  vpc_id                   = alicloud_vpc.vpc.id
  engine_version           = "8.0"
  security_ips             = ["192.168.0.0/16"]
}

resource "alicloud_db_database" "rds_database" {
  character_set = "utf8mb4"
  instance_id   = alicloud_db_instance.rds_instance.id
  name          = "high_availability"
}

resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id               = alicloud_vpc.vpc.id
  vswitch_id           = alicloud_vswitch.vswitch6.id
  nat_gateway_name     = "${var.common_name}-nat"
  internet_charge_type = "PayByLcu"
  eip_bind_mode        = "NAT"
}

resource "alicloud_eip_address" "nat_eip" {
  address_name         = "${var.common_name}-nat-eip"
  deletion_protection  = false
  isp                  = "BGP"
  bandwidth            = 10
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_eip_association" "nat_eip_association" {
  instance_id   = alicloud_nat_gateway.nat_gateway.id
  allocation_id = alicloud_eip_address.nat_eip.id
}

resource "alicloud_snat_entry" "snat_entry" {
  // SnatIp transform failed: Could not transform ROS Attribute NatEipAssociation.EipAddress to Terraform attribute. Args: ['NatEipAssociation', 'EipAddress']
  snat_entry_name = "public-network-access-in-vpc"
  snat_table_id   = alicloud_nat_gateway.nat_gateway.snat_table_ids
  source_cidr     = "0.0.0.0/0"
}

resource "alicloud_ecs_command" "prepare_data_alicloud_ecs_command" {
  type            = "RunShellScript"
  timeout         = 3600
  command_content = "#!/bin/bash\n\nyum install -y mysql\n\nmkdir /data\ncat << \"EOF\" > /data/script.sql\n-- script.sql\nUSE high_availability;\nCREATE TABLE `todo_list` (\n`id` bigint NOT NULL COMMENT 'id',\n`title` varchar(128) NOT NULL COMMENT 'title',\n`desc` text NOT NULL COMMENT 'description',\n`status` varchar(128) NOT NULL COMMENT 'status 未开始、进行中、已完成、已取消',\n`priority` varchar(128) NOT NULL COMMENT 'priority 高、中、低',\n`expect_time` datetime COMMENT 'expect time',\n`actual_completion_time` datetime COMMENT 'actual completion time',\n`gmt_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',\n`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modified time',\nPRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci\n;\nINSERT INTO todo_list\n(id, title, `desc`, `status`, priority, expect_time)\nvalue(1,  \"创建一个应用\", \"使用阿里云解决方案搭建一个应用\", \"进行中\", \"高\", \"2024-04-01 00:00:00\")\n\nEOF\n\nmysql -h${alicloud_db_instance.rds_instance.connection_string} -u${var.dbuser_name} -p${var.dbpassword} < /data/script.sql"
  name            = "auto-a98f8e2b"
}

resource "alicloud_ecs_invocation" "prepare_data_alicloud_ecs_invocation" {
  instance_id = alicloud_ecs_instance_set.ecs_instance1.id
  command_id  = alicloud_ecs_command.prepare_data_alicloud_ecs_command.id
}

resource "alicloud_ecs_command" "install_app_alicloud_ecs_command" {
  type            = "RunShellScript"
  timeout         = 3600
  command_content = "#!/bin/bash\n\ncat << EOF >> ~/.bash_profile\nexport APPLETS_RDS_ENDPOINT=${alicloud_db_instance.rds_instance.connection_string}\nexport APPLETS_RDS_USER=${var.dbuser_name}\nexport APPLETS_RDS_PASSWORD=${var.dbpassword}\nexport APPLETS_RDS_DB_NAME=high_availability\nexport ROS_DEPLOY=true\nEOF\n\nsource ~/.bash_profile\n\ncurl -fsS https://help-static-aliyun-doc.aliyuncs.com/install-script/hablog/install-hablog.sh|bash"
  name            = "auto-52205a6c"
  depends_on = [
    alicloud_ecs_command, alicloud_ecs_invocation.prepare_data,
    alicloud_snat_entry.snat_entry
  ]
}

resource "alicloud_ecs_invocation" "install_app_alicloud_ecs_invocation" {
  command_id = alicloud_ecs_command.install_app_alicloud_ecs_command.id
  instance_id = [
    alicloud_ecs_instance_set.ecs_instance1.id,
    alicloud_ecs_instance_set.ecs_instance2.id
  ]
  depends_on = [
    alicloud_ecs_command, alicloud_ecs_invocation.prepare_data,
    alicloud_snat_entry.snat_entry
  ]
}

resource "alicloud_security_group_rule" "security_group_security_group_ingress_0_d41d8476" {
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
}

resource "alicloud_security_group_rule" "security_group_security_group_ingress_1_74f966c6" {
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
}

