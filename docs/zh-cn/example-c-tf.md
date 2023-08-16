# Terraform 模板转 ROS 模板（兼容模式）
## 命令
使用以下命令可使用兼容模式将 Terraform 模板转换为 ROS 模板，并在当前目录生成模板文件：

```bash
rostran transform templates/terraform/alicloud/main.tf --compatible
```

也可以通过 `--source-format/-S terraform` 显式指定原始模板的类别：

```bash
rostran transform templates/terraform/alicloud -S terraform  --compatible
```

## 原始 Terraform 模板
- main.tf

```hcl
# Configure the AliCloud Provider
provider "alicloud" {}

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
```

- output.tf

```hcl
output "vpc_id" {
  value = alicloud_vpc.myvpc.id
}

output "vswitch_id" {
  value = alicloud_vswitch.myvswitch.id
}

```
## 转换后的 ROS 模板
```yaml
ROSTemplateFormatVersion: '2015-09-01'
Transform: Aliyun::Terraform-v1.2
Workspace:
  main.tf: |
    # Configure the AliCloud Provider
    provider "alicloud" {}

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
  output.tf: |
    output "vpc_id" {
      value = alicloud_vpc.myvpc.id
    }

    output "vswitch_id" {
      value = alicloud_vswitch.myvswitch.id
    }
```
