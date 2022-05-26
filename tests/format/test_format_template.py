from rostran.core.template import RosTemplate

tpl_template = {
    "Metadata": {
        "ALIYUN::ROS::Interface": {
            "TemplateTags": ["acs:example:ecs:instance_with_vpc"],
            "ParameterGroups": [
                {
                    "Parameters": ["ImageId", "InstanceType", "Password"],
                    "Label": {"default": "ECS"},
                }
            ],
        },
        "ALIYUN::ROS::Designer": {
            "90648756-148d-4692-a3c6-3834c2c80f80": {
                "size": {"width": 129, "height": 140},
                "position": {"x": 212, "y": 90},
                "z": 1,
                "embeds": ["2b080610-ddab-43ba-b9ab-8e3223668692"],
            },
            "1361cd4d-7ff5-4c6d-9c26-3d089a644b0b": {
                "size": {"width": 309, "height": 194},
                "position": {"x": 193, "y": 63},
                "z": 0,
                "embeds": [
                    "90648756-148d-4692-a3c6-3834c2c80f80",
                    "468cb29b-5bba-452e-95f4-4b331727204d",
                ],
            },
            "2b080610-ddab-43ba-b9ab-8e3223668692": {
                "size": {"width": 60, "height": 60},
                "position": {"x": 250, "y": 130},
                "z": 2,
            },
            "468cb29b-5bba-452e-95f4-4b331727204d": {
                "size": {"width": 60, "height": 60},
                "position": {"x": 406, "y": 130},
                "z": 1,
            },
            "e776abde-ad3c-4a8d-a999-93fbd2fa37e6": {
                "source": {"id": "2b080610-ddab-43ba-b9ab-8e3223668692"},
                "target": {"id": "468cb29b-5bba-452e-95f4-4b331727204d"},
                "z": 1,
            },
        },
    },
    "Outputs": {
        "InstanceId": {
            "Description": {
                "en": "The instance id of created ecs instance",
                "zh-cn": "已创建的ecs实例的实例ID",
            },
            "Value": {"Fn::GetAtt": ["WebServer", "InstanceId"]},
        },
        "PublicIp": {
            "Value": {"Fn::GetAtt": ["WebServer", "PublicIp"]},
            "Description": {
                "en": "Public IP address of created ecs instance.",
                "zh-cn": "已创建的ecs实例的公共IP地址。",
            },
        },
        "SecurityGroupId": {
            "Value": {"Fn::GetAtt": ["SecurityGroup", "SecurityGroupId"]},
            "Description": {
                "en": "Generated security group id for security group.",
                "zh-cn": "为安全组生成的安全组ID。",
            },
        },
    },
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "SecurityGroup": {
            "Metadata": {
                "ALIYUN::ROS::Designer": {"id": "468cb29b-5bba-452e-95f4-4b331727204d"}
            },
            "Properties": {"VpcId": {"Ref": "Vpc"}},
            "Type": "ALIYUN::ECS::SecurityGroup",
        },
        "VSwitch": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Metadata": {
                "ALIYUN::ROS::Designer": {"id": "90648756-148d-4692-a3c6-3834c2c80f80"}
            },
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "ZoneId": {
                    "Fn::Select": ["0", {"Fn::GetAZs": {"Ref": "ALIYUN::Region"}}]
                },
                "CidrBlock": "192.168.0.0/16",
            },
        },
        "WebServer": {
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "SecurityGroupId": {"Ref": "SecurityGroup"},
                "VSwitchId": {"Ref": "VSwitch"},
                "ImageId": {"Ref": "ImageId"},
                "InstanceType": {"Ref": "InstanceType"},
                "Password": {"Ref": "Password"},
            },
            "Type": "ALIYUN::ECS::Instance",
            "Metadata": {
                "ALIYUN::ROS::Designer": {"id": "2b080610-ddab-43ba-b9ab-8e3223668692"}
            },
        },
        "Vpc": {
            "Metadata": {
                "ALIYUN::ROS::Designer": {"id": "1361cd4d-7ff5-4c6d-9c26-3d089a644b0b"}
            },
            "Properties": {"CidrBlock": "192.168.0.0/16", "VpcName": "simple_ecs_vpc"},
            "Type": "ALIYUN::ECS::VPC",
        },
    },
    "Description": {
        "en": "Alibaba Cloud ROS Sample Template: One simple ECS instance with a security group and a vSwitch in a VPC. The user only needs to specify the image ID.",
        "zh-cn": "阿里云资源编排示例模板：一个简单的ECS实例，在VPC中具有一个安全组和一个vSwitch。 用户只需要指定图像ID。",
    },
    "Parameters": {
        "ImageId": {
            "Label": {"en": "Image ID", "zh-cn": "镜像ID"},
            "Default": "centos_7",
            "Type": "String",
            "Description": {
                "en": "Instance Image ID. see detail: <b><a href='https://www.alibabacloud.com/help/doc-detail/112977.html' target='_blank'><font color='blue'>Find the mirror</font></a></b>",
                "zh-cn": "实例镜像，详见：<b><a href='https://help.aliyun.com/document_detail/112977.html' target='_blank'><font color='blue'>查找镜像</font></a></b>",
            },
        },
        "InstanceType": {
            "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
            "Label": {"en": "Instance Type", "zh-cn": "实例类型"},
            "Description": {
                "zh-cn": "填写VSwitch可用区下可使用的规格；<br>通用规格：<font color='red'><b>ecs.c5.large</b></font><br>注：可用区可能不支持通用规格<br>规格详见：<a href='https://help.aliyun.com/document_detail/25378.html' target='_blank'><b><font color='blue'>实例规格族</font></a></b>",
                "en": "Fill in specifications that can be used under the VSwitch availability zone;</b></font><br>general specifications：<font color='red'><b>ecs.c5.large</b></font><br>note: a few zones do not support general specifications<br>see detail: <a href='https://www.alibabacloud.com/help/en/doc-detail/25378.html' target='_blank'><b><font color='blue'>Instance Specification Family</font></a></b>",
            },
            "Type": "String",
        },
        "Password": {
            "ConstraintDescription": {
                "en": "Length 8-30, must contain upper case letters, lower case letters, Numbers, special symbols three; special characters include: ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/",
                "zh-cn": "长度8-30，必须包含大写字母、小写字母、数字、特殊符号三种；特殊字符包括：()`~!@#$%^&*_-+=|{}[]:;' <>,.?/",
            },
            "NoEcho": True,
            "Type": "String",
            "Description": {
                "zh-cn": "长度8-30，必须包含大写字母、小写字母、数字、特殊符号三个；<br>特殊字符包括：()`~!@#$%^&*_-+=|{}[]:;'<>,.?/",
                "en": "The 8-30 long login password of instance, consists of the uppercase, lowercase letter and number. <br> special characters include()`~!@#$%^&*_-+=|{}[]:;'<>,.?/",
            },
            "MaxLength": 30,
            "AllowedPattern": "[0-9A-Za-z\\_\\-&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$",
            "Label": {"en": "Login Password", "zh-cn": "实例密码"},
            "MinLength": 8,
        },
    },
}


def test_format_template():
    template = RosTemplate.initialize(tpl_template)
    data = template.as_dict(format=True)

    # Template key order
    assert list(data) == [
        "ROSTemplateFormatVersion",
        "Description",
        "Parameters",
        "Resources",
        "Outputs",
        "Metadata",
    ]

    # Parameters key order
    parameters = data["Parameters"]
    assert list(parameters) == ["ImageId", "InstanceType", "Password"]
    password = parameters["Password"]
    assert list(password) == [
        "Type",
        "Label",
        "Description",
        "ConstraintDescription",
        "AllowedPattern",
        "MinLength",
        "MaxLength",
        "NoEcho",
    ]

    # Resources key order
    resources = data["Resources"]
    assert list(resources) == [
        "Vpc",
        "SecurityGroup",
        "VSwitch",
        "WebServer",
    ]

    # Outputs key order
    outputs = data["Outputs"]
    assert list(outputs) == ["InstanceId", "PublicIp", "SecurityGroupId"]
    instance_id = outputs["InstanceId"]
    assert list(instance_id) == ["Description", "Value"]

    # Metadata key order
    metadata = data["Metadata"]
    assert list(metadata) == ["ALIYUN::ROS::Interface", "ALIYUN::ROS::Designer"]
    interface = metadata["ALIYUN::ROS::Interface"]
    assert list(interface) == ["ParameterGroups", "TemplateTags"]
