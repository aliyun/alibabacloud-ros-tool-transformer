# Configure the AliCloud Provider
provider "alicloud" {}

variable "system_disk" {
  type = "map"
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
  name       = "myvpc"
}

resource "alicloud_vswitch" "myvswitch" {
  vpc_id            = alicloud_vpc.myvpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = "cn-beijing-g"
  name              = "myvswitch"
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
    "alicloud_security_group.mysg"
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
