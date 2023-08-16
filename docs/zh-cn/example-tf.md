# Terraform 模板转 ROS 模板
## 命令
使用以下命令可将 Terraform 模板转换为 ROS 模板，并在当前目录生成模板文件：

```bash
rostran transform templates/terraform/alicloud/main.tf
```

也可以通过 `--source-format/-S terraform` 显式指定原始模板的类别：

```bash
rostran transform templates/terraform/alicloud -S terraform
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
Resources:
  alicloud_vpc.myvpc:
    Properties:
      CidrBlock: 172.16.0.0/12
      VpcName: myvpc
    Type: ALIYUN::ECS::VPC
  alicloud_vswitch.myvswitch:
    Properties:
      CidrBlock: 172.16.0.0/21
      VSwitchName: myvswitch
      VpcId:
        Fn::GetAtt:
        - alicloud_vpc.myvpc
        - VpcId
      ZoneId: cn-beijing-g
    Type: ALIYUN::ECS::VSwitch
Outputs:
  vpc_id:
    Value:
      Fn::GetAtt:
      - alicloud_vpc.myvpc
      - VpcId
  vswitch_id:
    Value:
      Fn::GetAtt:
      - alicloud_vswitch.myvswitch
      - VSwitchId
```
