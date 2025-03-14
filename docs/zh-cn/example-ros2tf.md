# ROS 模板模板转 Terraform 模版
## 命令
使用以下命令把 ROS 模板转换为 Terraform 模版：

```bash
rostran transform ros-template.yml -S ros
```

可以通过 `--target-path ` 显式指定生成 Terraform 模板的路径

```bash
rostran transform ros-template.yml -S ros --target-path ./terraform
```

## ROS 模板
- ros-template

```yaml
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  VpcName:
    Type: String
Resources:  
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      VpcName:
        Ref: VpcName
      CidrBlock: 10.0.0.0/8
Outputs:
  VpcId:
    Value:
      Ref: Vpc
```

## 转换后的 Terraform 模板
- main.tf

```hcl
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_name
  cidr_block = "10.0.0.0/8"
}
```

- variables.tf
```hcl
variable "vpc_name" {
  type = string
}
```

- output.tf

```hcl
output "vpc_id" {
  value = alicloud_vpc.vpc.id
}
```