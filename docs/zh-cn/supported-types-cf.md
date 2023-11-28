# CloudFormation

## 资源

针对 CloudFormation 资源的转换，支持如下：

| CloudFormation                                                                                                                                             | ROS                                                                                                                                                      |
|------------------------------------------------------------------------------------------------------------------------------------------------------------| -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [AWS::ACMPCA::Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-acmpca-certificate) | [ALIYUN::CAS::Certificate](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-cas-certificate) |
| [AWS::ApiGateway::Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment) | [ALIYUN::ApiGateway::Deployment](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-apigateway-deployment) |
| [AWS::ApiGatewayV2::Api](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-api) | [ALIYUN::ApiGateway::Api](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-apigateway-api) |
| [AWS::ApiGatewayV2::Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-deployment) | [ALIYUN::ApiGateway::Deployment](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-apigateway-deployment) |
| [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup) | [ALIYUN::ESS::ScalingGroup](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ess-scalinggroup) |
| [AWS::AutoScaling::LaunchConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-launchconfiguration) | [ALIYUN::ESS::ScalingConfiguration](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ess-scalingconfiguration) |
| [AWS::AutoScaling::LifecycleHook](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-lifecyclehook) | [ALIYUN::ESS::LifecycleHook](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ess-lifecyclehook) |
| [AWS::AutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-scalingpolicy) | [ALIYUN::ESS::ScalingRule](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ess-scalingrule) |
| [AWS::CloudFormation::CustomResource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-customresource) | [ALIYUN::ROS::CustomResource](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ros-customresource) |
| [AWS::CloudFormation::Stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stack) | [ALIYUN::ROS::Stack](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ros-stack) |
| [AWS::CloudFormation::WaitCondition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-waitcondition) | [ALIYUN::ROS::WaitCondition](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ros-waitcondition) |
| [AWS::CloudFormation::WaitConditionHandle](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-waitconditionhandle) | [ALIYUN::ROS::WaitConditionHandle](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ros-waitconditionhandle) |
| [AWS::CloudTrail::Trail](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail) | [ALIYUN::ACTIONTRAIL::Trail](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-actiontrail-trail) |
| [AWS::Config::DeliveryChannel](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-deliverychannel) | [ALIYUN::Config::DeliveryChannel](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-config-deliverychannel) |
| [AWS::DynamoDB::Table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table) | [ALIYUN::OTS::Table](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ots-table) |
| [AWS::EC2::EIP](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-eip) | [ALIYUN::VPC::EIP](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-eip) |
| [AWS::EC2::EIPAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-eipassociation) | [ALIYUN::VPC::EIPAssociation](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-eipassociation) |
| [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-instance) | [ALIYUN::ECS::Instance](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-instance) |
| [AWS::EC2::InternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway) | [ALIYUN::VPC::NatGateway](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-natgateway) |
| [AWS::EC2::KeyPair](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-keypair) | [ALIYUN::ECS::SSHKeyPair](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-sshkeypair) |
| [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate) | [ALIYUN::ECS::LaunchTemplate](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-launchtemplate) |
| [AWS::EC2::NatGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway) | [ALIYUN::VPC::NatGateway](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-natgateway) |
| [AWS::EC2::NetworkAcl](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkacl) | [ALIYUN::VPC::NetworkAcl](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-networkacl) |
| [AWS::EC2::NetworkInterface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterface) | [ALIYUN::ECS::NetworkInterface](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-networkinterface) |
| [AWS::EC2::NetworkInterfaceAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfaceattachment) | [ALIYUN::ECS::NetworkInterfaceAttachment](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-networkinterfaceattachment) |
| [AWS::EC2::NetworkInterfacePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission) | [ALIYUN::ECS::NetworkInterfacePermission](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-networkinterfacepermission) |
| [AWS::EC2::PrefixList](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist) | [ALIYUN::ECS::PrefixList](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-prefixlist) |
| [AWS::EC2::Route](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route) | [ALIYUN::ECS::Route](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-route) |
| [AWS::EC2::RouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-routetable) | [ALIYUN::VPC::RouteTable](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-routetable) |
| [AWS::EC2::SecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup) | [ALIYUN::ECS::SecurityGroup](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-securitygroup) |
| [AWS::EC2::SecurityGroupEgress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroupegress) | [ALIYUN::ECS::SecurityGroupEgress](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-securitygroupegress) |
| [AWS::EC2::SecurityGroupIngress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroupingress) | [ALIYUN::ECS::SecurityGroupIngress](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-securitygroupingress) |
| [AWS::EC2::Subnet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet) | [ALIYUN::ECS::VSwitch](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-vswitch) |
| [AWS::EC2::SubnetRouteTableAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnetroutetableassociation) | [ALIYUN::VPC::RouteTableAssociation](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-routetableassociation) |
| [AWS::EC2::VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc) | [ALIYUN::ECS::VPC](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-vpc) |
| [AWS::EC2::VPNGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpngateway) | [ALIYUN::VPC::VpnGateway](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-vpc-vpngateway) |
| [AWS::EC2::Volume](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volume) | [ALIYUN::ECS::Disk](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-disk) |
| [AWS::EC2::VolumeAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volumeattachment) | [ALIYUN::ECS::DiskAttachment](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ecs-diskattachment) |
| [AWS::ECR::Repository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository) | [ALIYUN::CR::Repository](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-cr-repository) |
| [AWS::EFS::FileSystem](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-filesystem) | [ALIYUN::NAS::FileSystem](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-nas-filesystem) |
| [AWS::EFS::MountTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget) | [ALIYUN::NAS::MountTarget](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-nas-mounttarget) |
| [AWS::EMR::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-cluster) | [ALIYUN::EMR::Cluster](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-emr-cluster) |
| [AWS::ElasticLoadBalancing::LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancing-loadbalancer) | [ALIYUN::SLB::LoadBalancer](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-slb-loadbalancer) |
| [AWS::ElasticLoadBalancingV2::Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener) | [ALIYUN::SLB::Listener](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-slb-listener) |
| [AWS::ElasticLoadBalancingV2::ListenerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate) | [ALIYUN::SLB::Certificate](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-slb-certificate) |
| [AWS::ElasticLoadBalancingV2::ListenerRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule) | [ALIYUN::SLB::Rule](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-slb-rule) |
| [AWS::ElasticLoadBalancingV2::LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer) | [ALIYUN::SLB::LoadBalancer](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-slb-loadbalancer) |
| [AWS::Events::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule) | [ALIYUN::EventBridge::Rule](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-eventbridge-rule) |
| [AWS::GlobalAccelerator::Accelerator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-globalaccelerator-accelerator) | [ALIYUN::GA::Accelerator](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ga-accelerator) |
| [AWS::GlobalAccelerator::EndpointGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-globalaccelerator-endpointgroup) | [ALIYUN::GA::EndpointGroup](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ga-endpointgroup) |
| [AWS::GlobalAccelerator::Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-globalaccelerator-listener) | [ALIYUN::GA::Listener](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ga-listener) |
| [AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-accesskey) | [ALIYUN::RAM::AccessKey](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-accesskey) |
| [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-group) | [ALIYUN::RAM::Group](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-group) |
| [AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy) | [ALIYUN::RAM::ManagedPolicy](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-managedpolicy) |
| [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy) | [ALIYUN::RAM::ManagedPolicy](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-managedpolicy) |
| [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role) | [ALIYUN::RAM::Role](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-role) |
| [AWS::IAM::SAMLProvider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-samlprovider) | [ALIYUN::RAM::SAMLProvider](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-samlprovider) |
| [AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-user) | [ALIYUN::RAM::User](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-user) |
| [AWS::IAM::UserToGroupAddition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-usertogroupaddition) | [ALIYUN::RAM::UserToGroupAddition](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-ram-usertogroupaddition) |
| [AWS::KMS::Alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-alias) | [ALIYUN::KMS::Alias](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-kms-alias) |
| [AWS::KMS::Key](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key) | [ALIYUN::KMS::Key](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-kms-key) |
| [AWS::Lambda::Alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias) | [ALIYUN::FC::Alias](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-fc-alias) |
| [AWS::Lambda::Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function) | [ALIYUN::FC::Function](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-fc-function) |
| [AWS::Lambda::Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version) | [ALIYUN::FC::Version](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-fc-version) |
| [AWS::Organizations::Account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-organizations-account) | [ALIYUN::ResourceManager::Account](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-resourcemanager-account) |
| [AWS::RDS::DBInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbinstance) | [ALIYUN::RDS::DBInstance](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-rds-dbinstance) |
| [AWS::S3::Bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket) | [ALIYUN::OSS::Bucket](https://www.alibabacloud.com/help/ros/developer-reference/aliyun-oss-bucket) |

## 伪参数

针对 CloudFormation 伪参数的转换，支持如下：

| CloudFormation | ROS               |
|----------------| ----------------- |
| AWS::AccountId | ALIYUN::TenantId  |
| AWS::NoValue   | ALIYUN::NoValue   |
| AWS::Region    | ALIYUN::Region    |
| AWS::StackId   | ALIYUN::StackId   |
| AWS::StackName | ALIYUN::StackName |

## 函数

针对 CloudFormation 函数的转换，支持如下：

| CloudFormation | ROS              |
|----------------| ---------------- |
| Fn::And        | Fn::And          |
| Fn::Base64     | Fn::Base64Encode |
| Fn::Equals     | Fn::Equals       |
| Fn::FindInMap  | Fn::FindInMap    |
| Fn::GetAZs     | Fn::GetAZs       |
| Fn::GetAtt     | Fn::GetAtt       |
| Fn::If         | Fn::If           |
| Fn::Join       | Fn::Join         |
| Fn::Not        | Fn::Not          |
| Fn::Or         | Fn::Or           |
| Fn::Select     | Fn::Select       |
| Fn::Split      | Fn::Split        |
| Fn::Sub        | Fn::Sub          |
| Ref            | Ref              |

## AssociationProperty

针对 CloudFormation AssociationProperty 的转换，支持如下：

| CloudFormation                           | ROS                                         |
|------------------------------------------| ------------------------------------------- |
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

| CloudFormation                 | ROS                    |
| ------------------------------ | ---------------------- |
| AWS::CloudFormation::Interface | ALIYUN::ROS::Interface |
