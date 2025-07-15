import os

from libterraform import TerraformCommand
from libterraform.exceptions import TerraformCommandError

from rostran.providers.ros.template import ROS2TerraformTemplate
from rostran.providers.ros.yaml_util import yaml


RESULT_PATH = os.path.abspath("terraform/alicloud")
ROS_TEMPLATE_DIR = os.path.abspath("ros_templates")


tpl = '''
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  Name:
    Type: String
    Default: demo
  AvailabilityZoneId:
    AssociationProperty: ALIYUN::ECS::ZoneId
    Type: String
    Description: 可用区ID
    Label:
      zh-cn: 交换机可用区
      en: VSwitch Availability Zone
  InstanceType:
    Type: String
    Required: true
  Category:
    Type: String
  Password:
    Type: String
    NoEcho: true
  Tags:
    Type: Json
    Default:
      - Key: key1
        Value: value1
  MaxAmount:
    Type: Number
    Default: 1
  AllocatePublicIP:
    Type: Boolean
    Default: false
Resources:
  MyDemoVpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      VpcName: 
        Ref: Name
      CidrBlock: 192.168.0.0/16
      Description: Test description
      Tags:
        - Key: key1
          Value: value1
        - Key: key2
          Value: value2
  MyVSwitch:
    Type: ALIYUN::ECS::VSwitch
    Properties:
      VSwitchName: !Ref Name
      VpcId: !Ref MyDemoVpc
      CidrBlock: 192.168.0.0/24
      ZoneId: !Ref AvailabilityZoneId
  SecurityGroup:
    Type: ALIYUN::ECS::SecurityGroup
    Properties:
      VpcId: 
        Ref: MyDemoVpc
      Description: 'my demo sg'
      SecurityGroupName: 'DemoSG'
      Tags:
        - Key: key1
          Value: value1
      SecurityGroupType: enterprise
  MyEcs:
    Type: ALIYUN::ECS::Instance
    Properties:
      VpcId:
        Fn::GetAtt:
          - MyDemoVpc
          - VpcId
      RamRoleName: role-test
      IoOptimized: optimized
      InternetChargeType: PayByTraffic
      SecurityGroupIds:
        - Ref: SecurityGroup
      ImageId: ubuntu
      InstanceType: 
        Ref: InstanceType
      Password: 
        Ref: Password
      AllocatePublicIP: true
      InternetMaxBandwidthOut: 10
      DiskMappings: 
        - Category: cloud_essd
          Size: 40
        - Category:
            Ref: Category
          Size: 40
      SystemDiskCategory: cloud_essd
      Tags:
        Ref: Tags
      ZoneId:
        Ref: AvailabilityZoneId
      VSwitchId:
        Ref: MyVSwitch
  MyEcs2:
    Type: ALIYUN::ECS::InstanceGroup
    Properties:
      MaxAmount: 
        Ref: MaxAmount
      InstanceType:
        Ref: InstanceType
      ImageId: Ubuntu
      SecurityGroupIds:
        - Fn::GetAtt:
          - SecurityGroup
          - SecurityGroupId
      Password:
        Ref: Password
      AllocatePublicIP:
        Ref: AllocatePublicIP
      DiskMappings:
        - Category: cloud_essd
          Size: 40
      InternetMaxBandwidthOut: 3
      SystemDiskCategory: cloud_essd
      VSwitchId:
        Ref: MyVSwitch
Outputs:
  VpcId:
    Value: !Ref MyDemoVpc
    Description: The id of MyDemoVpc
  VSwitchId:
    Value: !Ref MyVSwitch
  VpcName: 
    Value: !GetAtt MyDemoVpc.VpcName
  CidrBlock:
    Value:
      Fn::GetAtt:
        - MyVSwitch
        - CidrBlock
    Description: The cidr block of vswitch.
'''

tpl_with_resources = '''
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  EnvType:
    Default: prod
    Type: String
  Count:
    Type: Number
Conditions:
  CreateProdRes:
    Fn::Equals:
      - prod
      - Ref: EnvType
Resources:
  Vpc1:
    Type: ALIYUN::ECS::VPC
    Properties:
      VpcName: 
        Fn::If:
          - CreateProdRes
          - ProdVpc
          - Ref: EnvType
      CidrBlock: 192.168.0.0/16
  Vpc2:
    Type: ALIYUN::ECS::VPC
    Condition: CreateProdRes
    Properties:
      VpcName: prod
      CidrBlock: 192.168.0.0/16
      Description: Test description
  Vpc3:
    Type: ALIYUN::ECS::VPC
    DependsOn: Vpc2
    Condition: CreateProdRes
    Count: 
      Ref: Count
Outputs:
  VpcName1:
    Condition: CreateProdRes
    Value:
      Fn::GetAtt:
        - Vpc1
        - VpcName
  VpcId2:
    Value:
      Ref: Vpc2
  VpcId3:
    Value: 
      Ref: Vpc3
'''

pseudo_parameter_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  Names:
    Type: CommaDelimitedList
    Default: name1,name2
Resources:
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      VpcName:
        Fn::Select:
          - 0
          - Ref: Names
  EcsInstance:
    Type: ALIYUN::ECS::InstanceGroup
    Properties:
      MaxAmount: 1
      SystemDiskCategory: 
        Ref: ALIYUN::NoValue
      VpcId:
        Fn::GetAtt:
          - Vpc
          - VpcId
      SecurityGroupIds: 
        - sg-ssss1
        - sg-ssss2
      ImageId: 
        Ref: ALIYUN::Region
      VSwitchId: vsw-xxxx
      InstanceType: ecs.xxx
      InternetMaxBandwidthOut: 5
      ZoneId: xx
      Description:
        Fn::Sub: "${ALIYUN::StackName}-${ALIYUN::StackId}-${ALIYUN::Region}-${ALIYUN::AccountId}-${ALIYUN::TenantId}-${ALIYUN::ResourceGroupId}-${ALIYUN::NoValue}"
"""

run_command_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  BaiLianApiKey:
    Type: String
Resources:
  InstanceRunCommand:
    Type: ALIYUN::ECS::RunCommand
    Properties:
      InstanceIds: 
        - i-xxxx1
        - i-xxxx2
      CommandContent:
        Fn::Sub:
          - |
            #!/bin/bash
            cat << EOF >> ~/.bash_profile
            export ROS_DEPLOY=true
            export BAILIAN_API_KEY=${ApiKey}
            EOF
            source ~/.bash_profile
            curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/ai-security/install.sh | bash
          - ApiKey:
              Fn::Jq:
                - First
                - .Key
                - Ref: BaiLianApiKey
      Type: RunShellScript
      Timeout: '2400'
      Sync: true
"""

security_group_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  CommonName:
    Type: String
    Default: HZ
Resources:
  SecurityGroup:
    Type: ALIYUN::ECS::SecurityGroup
    Properties:
      SecurityGroupIngress:
        - Priority: 100
          PortRange: 80/80
          NicType: internet
          SourceCidrIp: 0.0.0.0/0
          IpProtocol: tcp
      VpcId: vpc-xxxx
      SecurityGroupName:
        Fn::Sub: SG_${CommonName}
"""


class TestROS2TF:

    def __enter__(self):
        if not os.path.exists(RESULT_PATH):
            os.makedirs(RESULT_PATH, exist_ok=True)
        else:
            for filename in os.listdir(RESULT_PATH):
                if filename.endswith('.tf'):
                    file_path = os.path.join(RESULT_PATH, filename)
                    os.unlink(file_path)
        tf = TerraformCommand(RESULT_PATH)
        tf_flag = os.path.join(RESULT_PATH, ".terraform")
        tf_flag2 = os.path.join(RESULT_PATH, ".terraform.lock.hcl")
        if not os.path.exists(tf_flag) or not os.path.exists(tf_flag2):
            tf.init(check=True)

    def __exit__(self, exc_type, exc_val, exc_tb):
        tf = TerraformCommand(RESULT_PATH)
        try:
            tf.validate(check=True)
            print("terraform validate success!")
        except TerraformCommandError as ex:
            print("terraform validate failed!")
            print(ex.stdout)
            raise ex


def _test_tpl():
    source = yaml.load(tpl)
    template = ROS2TerraformTemplate.initialize(source)
    with TestROS2TF():
        template.transform()


def _test_tpl_with_conditions():
    source = yaml.load(tpl_with_resources)
    template = ROS2TerraformTemplate.initialize(source)
    with TestROS2TF():
        template.transform()


def _test_solution_245():
    with open(f"{ROS_TEMPLATE_DIR}/technical_solution.yml", 'r') as f:
        content = yaml.load(f)
    template = ROS2TerraformTemplate.initialize(content)
    template.transform()


def _test_tpl_pseudo_parameter():
    source = yaml.load(pseudo_parameter_tpl)
    template = ROS2TerraformTemplate.initialize(source)
    template.transform()


def _test_run_command():
    source = yaml.load(run_command_tpl)
    template = ROS2TerraformTemplate.initialize(source)
    template.transform()

def _test_security_group_tpl():
    source = yaml.load(security_group_tpl)
    template = ROS2TerraformTemplate.initialize(source)
    template.transform()
