import os

from rostran.providers.ros.template import ROS2TerraformTemplate
from rostran.providers.ros.yaml_util import yaml
from tests.providers.ros.test_transform_to_tf import TestROS2TF


length_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  InputString:
    Type: String
    Default: "Hello World"
Resources:
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      VpcName:
        Fn::Length:
          Ref: InputString
      Description:
        Fn::Length: "SGVsbG8gV29ybGQ="
Outputs:
  LengthResult:
    Value:
      Fn::Length: 
        - Ref: InputString
        - b
        - c
  LengthResult2:
    Value:
      Fn::Length:
        x: y
        y: z
"""

str_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  InputNumber:
    Type: String
    Default: 123
Resources:
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      Description:
        Fn::Str: 
          Ref: InputNumber
Outputs:
  StrResult:
    Value:
      Fn::Str: 123
"""

join_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  InputString:
    Type: String
    Default: abc
Resources:
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      Description:
        Fn::Join: 
          - ","
          - - Fn::Str: xyz
            - Ref: InputString
            - Ref: ALIYUN::Region
"""

indent_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Parameters:
  p1:
    Default: |-
      [client]
      port=3306
      password=123
    Type: String
Outputs:
  result:
    Value:
      'Fn::Sub':
        - |
          data:
          ${p1}
        - p1:
            'Fn::Indent':
              - Ref: p1
              - 1
"""

split_tpl = """
Parameters:
  InstanceIds:
    Type: String
    Default: instance1_id,instance2_id,instance2_id
Outputs:
  Result:
    Value:
      Fn::Split:
        - ','
        - Ref: InstanceIds
"""

sub_tpl = """
Parameters:
  AppApiKey:
    Type: String
    Default: sk-xxxx
Outputs:
  Result:
    Value:
      Fn::Sub: |-
        #!/bin/bash
        cat << EOF >> ~/.bash_profile
        export DASHSCOPE_API_KEY="${AppApiKey}"
        export ROS_DEPLOY=true
        EOF
"""

replace_tpl = """
Outputs:
  Result:
    Value:
      Fn::Replace:
        - print: echo
          hello: hi
        - Fn::Join:
          - ''
          - - |
              #!/bin/sh
            - |
              mkdir ~/test_ros
            - |
              print hello > ~/1.txt
"""

get_az_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Outputs:
  ZoneId:
    Value:
      Fn::Select:
        - 0
        - Fn::GetAZs: 
            Ref: ALIYUN::Region
"""

index_tpl = """
ROSTemplateFormatVersion: '2015-09-01'
Outputs:
  Index:
    Value:
      Fn::Index:
        - b
        - - a
          - b
          - c 
"""


def test_length_function():
    source = yaml.load(length_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_str_function():
    source = yaml.load(str_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_join_function():
    source = yaml.load(join_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_indent_function():
    source = yaml.load(indent_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_split_function():
    source = yaml.load(split_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_sub_function():
    source = yaml.load(sub_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_replace_function():
    source = yaml.load(replace_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_get_az_function():
    source = yaml.load(get_az_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_index_function():
    source = yaml.load(index_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_list_merge_function():
    list_merge_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Outputs:
      Result:
        Value:
          Fn::ListMerge:
            - - a
              - b
            - - x
              - y
    """
    source = yaml.load(list_merge_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_get_json_value_function():
    get_json_value_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Outputs:
      Result:
        Value:
          Fn::GetJsonValue:
            - key
            - '{"key": "value"}'
    """
    source = yaml.load(get_json_value_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_avg_function():
    avg_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Outputs:
      Result:
        Value:
          Fn::Avg:
            - 2
            - - 1
              - 2
              - 3
    """
    source = yaml.load(avg_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_add_function():
    add_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Parameters:
      Input:
        Type: String
        Default: x
    Outputs:
      Result1:
        Value:
          Fn::Add:
            - 2
            - 3
      Result2:
        Value:
          Fn::Add:
            - key1: value1
            - key2: value2
      Result3:
        Value:
          Fn::Add:
            - - a
              - b
            - - c
              - d
      Result4:
        Value:
          Fn::Add:
            - a
            - b
      Result5:
        Value:
          Fn::Add:
            - a
            - Ref: Input
    """
    source = yaml.load(add_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_max_function():
    max_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Parameters:
      Input:
        Type: Number
        Default: 0
    Outputs:
      Result1:
        Value:
          Fn::Max:
            - 2
            - 3
      Result2:
        Value:
          Fn::Max:
            - 2
            - Ref: Input
    """
    source = yaml.load(max_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_format_time_function():
    tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Outputs:
      Result:
        Value:
          Fn::FormatTime: '%Y-%m-%d %H:%M:%S'
    """
    source = yaml.load(tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()

def _test_mappings_function():
    mappings_tpl = """
    ROSTemplateFormatVersion: '2015-09-01'
    Parameters:
      regionParam:
        Description: 选择创建ECS的区域
        Type: String
        AllowedValues:
          - hangzhou
          - beijing
        Default: hangzhou
    Mappings:
      RegionMap:
        hangzhou:
          '32': m-25l0rcfjo
          '64': m-25l0rcfj1
        beijing:
          '32': m-25l0rcfj2
          '64': m-25l0rcfj3
    Outputs:
      Result1:
        Value:
          Fn::FindInMap:
            - RegionMap
            - Ref: regionParam
            - 64
    """
    source = yaml.load(mappings_tpl)
    template = ROS2TerraformTemplate.initialize(source, validate=False)
    with TestROS2TF():
        template.transform()
