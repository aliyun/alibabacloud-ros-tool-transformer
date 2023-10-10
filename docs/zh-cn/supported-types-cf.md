# CloudFormation

## 资源

针对 CloudFormation 资源的转换，支持如下：

| Terraform                                                                                                                                                  | ROS                                                                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup)             | [ALIYUN::ESS::ScalingGroup](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ess-scalinggroup)                             |
| [AWS::AutoScaling::LifecycleHook](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-lifecyclehook)                   | [ALIYUN::ESS::LifecycleHook](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ess-lifecyclehook)                           |
| [AWS::CloudFormation::Stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stack)                             | [ALIYUN::ROS::Stack](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ros-stack)                                           |
| [AWS::CloudFormation::WaitCondition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-waitcondition)             | [AWS::ROS::WaitCondition](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aws-ros-waitcondition)                                 |
| [AWS::CloudFormation::WaitConditionHandle](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-waitconditionhandle) | [AWS::ROS::WaitConditionHandle](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aws-ros-waitconditionhandle)                     |
| [AWS::EC2::EIP](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-eip)                                                       | [ALIYUN::VPC::EIP](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-eip)                                               |
| [AWS::EC2::EIPAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-eipassociation)                                 | [ALIYUN::VPC::EIPAssociation](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-eipassociation)                         |
| [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-instance)                                             | [ALIYUN::ECS::Instance](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-instance)                                     |
| [AWS::EC2::InternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway)                               | [ALIYUN::VPC::NatGateway](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-natgateway)                                 |
| [AWS::EC2::NatGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway)                                         | [ALIYUN::VPC::NatGateway](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-natgateway)                                 |
| [AWS::EC2::NetworkInterface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterface)                             | [ALIYUN::ECS::NetworkInterface](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-networkinterface)                     |
| [AWS::EC2::NetworkInterfaceAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfaceattachment)         | [ALIYUN::ECS::NetworkInterfaceAttachment](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-networkinterfaceattachment) |
| [AWS::EC2::Route](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route)                                                   | [ALIYUN::ECS::Route](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-route)                                           |
| [AWS::EC2::RouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-routetable)                                         | [ALIYUN::VPC::RouteTable](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-routetable)                                 |
| [AWS::EC2::SecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup)                                   | [ALIYUN::ECS::SecurityGroup](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-securitygroup)                           |
| [AWS::EC2::Subnet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet)                                                 | [ALIYUN::ECS::VSwitch](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-vswitch)                                       |
| [AWS::EC2::SubnetRouteTableAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnetroutetableassociation)       | [ALIYUN::VPC::RouteTableAssociation](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-routetableassociation)           |
| [AWS::EC2::VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc)                                                       | [ALIYUN::ECS::VPC](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-vpc)                                               |
| [AWS::EC2::VPNGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpngateway)                                         | [ALIYUN::VPC::VpnGateway](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-vpc-vpngateway)                                 |
| [AWS::EC2::Volume](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volume)                                                 | [ALIYUN::ECS::Disk](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-disk)                                             |
| [AWS::EC2::VolumeAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volumeattachment)                             | [ALIYUN::ECS::DiskAttachment](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ecs-diskattachment)                         |
| [AWS::ElasticLoadBalancing::LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancing-loadbalancer)   | [ALIYUN::SLB::LoadBalancer](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-slb-loadbalancer)                             |
| [AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-accesskey)                                           | [ALIYUN::RAM::AccessKey](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-accesskey)                                   |
| [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-group)                                                   | [ALIYUN::RAM::Group](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-group)                                           |
| [AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy)                                   | [ALIYUN::RAM::ManagedPolicy](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-managedpolicy)                           |
| [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role)                                                     | [ALIYUN::RAM::Role](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-role)                                             |
| [AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-user)                                                     | [ALIYUN::RAM::User](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-user)                                             |
| [AWS::IAM::UserToGroupAddition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-usertogroupaddition)                       | [ALIYUN::RAM::UserToGroupAddition](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-ram-usertogroupaddition)               |
| [AWS::RDS::DBInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbinstance)                                         | [ALIYUN::RDS::DBInstance](https://www.alibabacloud.com/help/resource-orchestration-service/latest/aliyun-rds-dbinstance)                                 |

## 伪参数

针对 CloudFormation 伪参数的转换，支持如下：

| Terraform      | ROS               |
| -------------- | ----------------- |
| AWS::AccountId | ALIYUN::TenantId  |
| AWS::NoValue   | ALIYUN::NoValue   |
| AWS::Region    | ALIYUN::Region    |
| AWS::StackId   | ALIYUN::StackId   |
| AWS::StackName | ALIYUN::StackName |

## 函数

针对 CloudFormation 函数的转换，支持如下：

| Terraform     | ROS              |
| ------------- | ---------------- |
| Fn::And       | Fn::And          |
| Fn::Base64    | Fn::Base64Encode |
| Fn::Equals    | Fn::Equals       |
| Fn::FindInMap | Fn::FindInMap    |
| Fn::GetAZs    | Fn::GetAZs       |
| Fn::GetAtt    | Fn::GetAtt       |
| Fn::If        | Fn::If           |
| Fn::Join      | Fn::Join         |
| Fn::Not       | Fn::Not          |
| Fn::Or        | Fn::Or           |
| Fn::Select    | Fn::Select       |
| Fn::Split     | Fn::Split        |
| Fn::Sub       | Fn::Sub          |
| Ref           | Ref              |

## AssociationProperty

针对 CloudFormation AssociationProperty 的转换，支持如下：

| Terraform                                | ROS                                         |
| ---------------------------------------- | ------------------------------------------- |
| AWS::EC2::AvailabilityZone::Name         | ALIYUN::ECS::Instance::ZoneId               |
| AWS::EC2::Image::Id                      | ALIYUN::ECS::Instance::ImageId              |
| AWS::EC2::KeyPair::KeyName               | ALIYUN::ECS::KeyPair::KeyPairName           |
| AWS::EC2::SecurityGroup::Id              | ALIYUN::ECS::SecurityGroup::SecurityGroupId |
| AWS::EC2::VPC::Id                        | ALIYUN::ECS::VPC::VPCId                     |
| List\<AWS::EC2::AvailabilityZone::Name\> | ALIYUN::ECS::Instance::ZoneId               |
| List\<AWS::EC2::Image::Id\>              | ALIYUN::ECS::Instance::ImageId              |
| List\<AWS::EC2::SecurityGroup::Id\>      | ALIYUN::ECS::SecurityGroup::SecurityGroupId |
| List\<AWS::EC2::VPC::Id\>                | ALIYUN::ECS::VPC::VPCId                     |

## Metadata

针对 CloudFormation Metadata 的转换，支持如下：

| Terraform                      | ROS                    |
| ------------------------------ | ---------------------- |
| AWS::CloudFormation::Interface | ALIYUN::ROS::Interface |
