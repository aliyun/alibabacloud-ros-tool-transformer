# Transform ROS Template to Terraform
## Command
Use the following command to convert the ROS template to a Terraform template:

```bash
rostran transform ros-template.yml -S ros
```

The path to generate a Terraform template can be explicitly specified with `--target-path` option.

```bash
rostran transform ros-template.yml -S ros --target-path ./terraform
```

## ROS Template
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

## Transformed Terraform template
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