from rostran.core.resources import Resources

tpl_resources = {
    "Foo2": {"Type": "ALIYUN::Mock::Foo", "DependsOn": "Foo1"},
    "Instance": {
        "DependsOn": ["Vpc", "VSwitch"],
        "Properties": {
            "InstanceType": {"Ref": "InstanceType"},
            "ImageId": {"Ref": "ImageId"},
            "VSwitchId": {"Ref": "VSwitch"},
            "SecurityGroupId": {"Ref": "SecurityGroup"},
            "VpcId": {"Ref": "Vpc"},
            "Password": {"Ref": "Password"},
        },
        "Type": "ALIYUN::ECS::Instance",
    },
    "VSwitch": {
        "OtherProp2": {},
        "Metadata": {
            "ALIYUN::ROS::Designer": {"id": "2b080610-ddab-43ba-b9ab-8e3223668692"}
        },
        "Properties": {
            "CidrBlock": "192.168.0.0/16",
            "VpcId": {"Ref": "Vpc"},
            "ZoneId": {"Fn::Select": ["0", {"Fn::GetAZs": {"Ref": "ALIYUN::Region"}}]},
        },
        "Type": "ALIYUN::ECS::VSwitch",
        "OtherProp1": {},
        "DeletionPolicy": "Delete",
        "Condition": "CreateVSwitch",
    },
    "Vpc": {
        "Type": "ALIYUN::ECS::VPC",
        "Properties": {"CidrBlock": "192.168.0.0/16", "VpcName": "simple_ecs_vpc"},
    },
    "Foo1": {"Type": "ALIYUN::Mock::Foo"},
    "SecurityGroup": {
        "Type": "ALIYUN::ECS::SecurityGroup",
        "Properties": {"VpcId": {"Ref": "Vpc"}},
    },
}


def test_format_resources():
    resources = Resources.initialize(tpl_resources)
    data = resources.as_dict(format=True)

    # Resources key order
    assert list(data) == [
        "Foo1",
        "Foo2",
        "Vpc",
        "SecurityGroup",
        "VSwitch",
        "Instance",
    ]

    # VSwitch key order
    vswitch = data["VSwitch"]
    assert list(vswitch) == [
        "Type",
        "Condition",
        "Properties",
        "DeletionPolicy",
        "Metadata",
        "OtherProp1",
        "OtherProp2",
    ]

    # Instance key order
    instance = data["Instance"]
    assert list(instance) == ["Type", "Properties", "DependsOn"]
