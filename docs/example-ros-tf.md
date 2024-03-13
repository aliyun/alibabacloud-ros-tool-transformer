# Transform ROS-Wrapped Terraform Template to Terraform Template
## Command
Using the following command generates Terraform files in the current directory 
based on the ROS-Wrapped Terraform template:
```bash
rostran transform template.yaml
```

You can explicitly specify the path to generate the Terraform template through '--target-path'

```bash
rostran transform template.yaml --target-path ./terraform
```

## ROS-Wrapped template
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
## Transformed Terraform template
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