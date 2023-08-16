# Transform AWS CloudFormation Terraform to ROS Terraform
## Command
Use the following command to transform AWS CloudFormation template into ROS template 
and generate template file in the current directory:

```bash
rostran transform templates/cloudformation/vpc_sg.json --target-format json
```

## Original AWS CloudFormation Template
```json
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "This template create vpc security group.",
  "Metadata": {
    "AWS::CloudFormation::Interface": {
      "ParameterGroups": {
        "Parameters": [
          "CidrBlock"
        ],
        "Label": {
          "default": "VPC"
        }
      },
      "ParameterLabels": {
        "CidrBlock": {
          "default": "Vpc Cidr Block"
        }
      }
    }
  },
  "Parameters": {
    "CidrBlock": {
      "Type": "String",
      "Default": "10.0.0.0/16"
    }
  },
  "Resources": {
    "MyVpc": {
      "DeletionPolicy": "Retain",
      "Type": "AWS::EC2::VPC",
      "Properties": {
        "CidrBlock": {
          "Ref": "CidrBlock"
        },
        "EnableDnsSupport": "false",
        "EnableDnsHostnames": "false",
        "InstanceTenancy": "dedicated",
        "Tags": [
          {
            "Key": "foo",
            "Value": "bar"
          }
        ]
      }
    },
    "MySg": {
      "DependsOn": "MyVpc",
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "Create vpc security group",
        "VpcId": {
          "Ref": "MyVpc"
        }
      }
    }
  },
  "Outputs": {
    "VpcId": {
      "Description": "Vpc ID",
      "Value": {
        "Ref": "MyVpc"
      }
    },
    "SgId": {
      "Description": "SecurityGroup ID",
      "Value": {
        "Fn::GetAtt": [
          "MySg",
          "GroupId"
        ]
      }
    }
  }
}
```
## Transformed ROS Template
```json
{
  "ROSTemplateFormatVersion": "2015-09-01",
  "Description": "This template create vpc security group.",
  "Metadata": {
    "ALIYUN::ROS::Interface": {
      "ParameterGroups": {
        "Parameters": [
          "CidrBlock"
        ],
        "Label": {
          "default": "VPC"
        }
      },
      "ParameterLabels": {
        "CidrBlock": {
          "default": "Vpc Cidr Block"
        }
      }
    }
  },
  "Parameters": {
    "CidrBlock": {
      "Type": "String",
      "Default": "10.0.0.0/16",
      "Label": "Vpc Cidr Block"
    }
  },
  "Resources": {
    "MyVpc": {
      "Type": "ALIYUN::ECS::VPC",
      "Properties": {
        "CidrBlock": {
          "Ref": "CidrBlock"
        },
        "Tags": [
          {
            "Key": "foo",
            "Value": "bar"
          }
        ]
      },
      "DeletionPolicy": "Retain"
    },
    "MySg": {
      "Type": "ALIYUN::ECS::SecurityGroup",
      "Properties": {
        "Description": "Create vpc security group",
        "VpcId": {
          "Ref": "MyVpc"
        }
      },
      "DependsOn": "MyVpc"
    }
  },
  "Outputs": {
    "VpcId": {
      "Value": {
        "Ref": "MyVpc"
      }
    },
    "SgId": {
      "Value": {
        "Fn::GetAtt": [
          "MySg",
          "SecurityGroupId"
        ]
      }
    }
  }
}
```