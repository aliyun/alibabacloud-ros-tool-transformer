resource "alicloud_ram_user" "ram_user" {
  name = "create_by_solution-8b4b55fb089340f7a91494f9a87de189"
}

resource "alicloud_ram_access_key" "ramak" {
  user_name = alicloud_ram_user.ram_user.name
  depends_on = [
    alicloud_ram_user.ram_user
  ]
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  policy_type = "System"
  user_name   = alicloud_ram_user.ram_user.name
  policy_name = "AliyunYundunGreenWebFullAccess"
  depends_on = [
    alicloud_ram_access_key.ramak
  ]
}

resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "SG_${var.common_name}"
}

resource "alicloud_ecs_command" "instance_run_command_alicloud_ecs_command" {
  command_content = base64encode("#!/bin/bash\ncat << EOF >> ~/.bash_profile\nexport ROS_DEPLOY=true\nexport BAILIAN_API_KEY=${var.bai_lian_api_key.Key}\nexport ALIBABA_CLOUD_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}\nexport ALIBABA_CLOUD_ACCESS_KEY_SECRET=// Could not transform ROS Attribute AccessKeySecret to Terraform attribute.\nEOF\nsource ~/.bash_profile\ncurl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/ai-security/install.sh | bash\n")
  type            = "RunShellScript"
  timeout         = "2400"
  name            = "auto-682b3bb8"
}

resource "alicloud_ecs_invocation" "instance_run_command_alicloud_ecs_invocation" {
  instance_id = alicloud_ecs_instance_set.ecs_instance.instance_ids
  command_id  = alicloud_ecs_command.instance_run_command_alicloud_ecs_command.id
}

resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = var.zone_id1
  vswitch_name = "VSW_${var.common_name}"
}

resource "alicloud_ecs_instance_set" "ecs_instance" {
  amount                     = 1
  system_disk_category       = "cloud_essd"
  security_group_ids         = alicloud_security_group.security_group.id
  image_id                   = "aliyun_3_x64_20G_alibase_"
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  password                   = var.instance_password
  instance_type              = var.instance_type
  internet_max_bandwidth_out = 5
  zone_id                    = var.zone_id1
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "VPC_${var.common_name}"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_security_group_rule" "security_group_security_group_ingress_0_1d6f9388" {
  priority          = 100
  port_range        = "80/80"
  nic_type          = "internet"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
}

