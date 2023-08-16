# Transform Terraform Template to ROS Template (Compatible Mode)
## Command
Use the following command to transform Terraform template to ROS template in compatible mode
and generate template file in the current directory:

```bash
rostran transform templates/terraform/alicloud/main.tf --compatible
```
You can also use `--source-format/-S terraform` to explicitly specify the category 
of the original template:

```bash
rostran transform templates/terraform/alicloud -S terraform --compatible
```

## Original Terraform Template
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

## Transformed ROS Template
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
