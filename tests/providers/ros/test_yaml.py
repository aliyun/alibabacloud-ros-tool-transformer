
import json

from rostran.providers.ros.yaml_util import yaml


def test_yaml():
    yaml_content = """
    ROSTemplateFormatVersion: '2015-09-01'
    Parameters:
      Name:
        Type: String
      VpcCidrBlock:
        Type: String
        Default: 172.16.0.0/12
    Resources:
      Vpc:
        Type: ALIYUN::ECS::VPC
        Properties:
          VpcName: !Sub ${Name}-vpc
          CidrBlock: !Ref VpcCidrBlock
    
    Outputs:
      VpcId:
        Value: !Ref Vpc
    """

    data = yaml.load(yaml_content)
    assert isinstance(data, dict)
