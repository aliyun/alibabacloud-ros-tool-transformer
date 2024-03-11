# ROS 封装的 Terraform 模板转 Terraform 模版
## 命令
使用以下命令会根据ROS封装的 Terraform 模板在当前目录生成 Terraform 文件：

```bash
rostran transform template.yaml
```

可以通过 `--target-path ` 显式指定生成 Terraform 模板的路径

```bash
rostran transform template.yaml --target-path ./terraform
```

## ROS 封装的模板
- template.yaml

```yaml
ROSTemplateFormatVersion: '2015-09-01'
Transform: Aliyun::Terraform-v1.5
Workspace:
  main.tf: |-
    resource "alicloud_vpc" "vpc" {
      vpc_name = "vpc_test"
    }
  outputs.tf: |-
    output "vpc_id" {
      value = alicloud_vpc.vpc.id
    }
```
## 转换后的 Terraform 模板
- main.tf

```hcl
resource "alicloud_vpc" "vpc" {
  vpc_name = "vpc_test"
}
```

- output.tf

```hcl
output "vpc_id" {
  value = alicloud_vpc.vpc.id
}
```