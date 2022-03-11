# Configure the AliCloud Provider
provider "alicloud" {}

variable "system_disk" {
  type = map
  default = {
    "category" = "cloud_efficiency"
  }
}

data "alicloud_instance_types" "c2g4" {
  cpu_core_count = 2
  memory_size    = 4
}

data "alicloud_images" "centos_image" {
  name_regex  = "^centos"
  most_recent = true
  owners      = "system"
}

# Create VPC and VSwitch
resource "alicloud_vpc" "myvpc" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = "myvpc"
}

resource "alicloud_vswitch" "myvswitch" {
  vpc_id            = alicloud_vpc.myvpc.id
  cidr_block        = "172.16.0.0/21"
  zone_id           = "cn-beijing-g"
  vswitch_name      = "myvswitch"
}

# Create security group
resource "alicloud_security_group" "mysg" {
  name   = "mysg"
  vpc_id = alicloud_vpc.myvpc.id
}

# Create a web server
resource "alicloud_instance" "myinstance" {
  instance_name        = "myinstance"
  image_id             = data.alicloud_images.centos_image.images.0.id
  instance_type        = data.alicloud_instance_types.c2g4.instance_types.0.id
  security_groups      = alicloud_security_group.mysg.*.id
  vswitch_id           = alicloud_vswitch.myvswitch.id
  system_disk_category = var.system_disk["category"]
  depends_on = [
    alicloud_security_group.mysg
  ]
  data_disks {
    name        = "mydisk1"
    size        = 20
    category    = "cloud_efficiency"
    description = sha1(alicloud_vswitch.myvswitch.id)  # just for test
  }
  data_disks {
    name        = "mydisk2"
    size        = 25
    category    = "cloud_essd"
    description = "disk 2"
  }
}

resource "alicloud_log_project" "sls" {
  name        = "tf-log"
  description = "created by terraform"
}

resource "alicloud_log_machine_group" "sls_machine_group" {
  project       = alicloud_log_project.sls.name
  name          = "tf-machine-group"
  identify_type = "ip"
  topic         = "terraform"
  identify_list = ["10.0.0.1", "10.0.0.2"]
  depends_on    = [
    alicloud_log_project.sls
  ]
}