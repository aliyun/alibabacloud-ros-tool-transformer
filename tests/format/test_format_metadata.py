from rostran.core.metadata import MetaData

tpl_metadata = {
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
    "ALIYUN::ROS::Interface": {
        "TemplateTags": ["tag2", "tag1", "tag3"],
        "ParameterGroups": [
            {
                "Label": {"default": "ECS"},
                "Parameters": ["ImageId", "InstanceType", "Password"],
            }
        ],
    },
}


def test_format_metadata():
    meta_data = MetaData.initialize(tpl_metadata)
    data = meta_data.as_dict(format=True)

    # MetaData key order
    assert list(data) == ["ALIYUN::ROS::Interface", "ALIYUN::ROS::Designer"]

    # ALIYUN::ROS::Interface key order
    ros_interface = data["ALIYUN::ROS::Interface"]
    assert list(ros_interface) == ["ParameterGroups", "TemplateTags"]

    param_groups = ros_interface["ParameterGroups"]
    param_group = param_groups[0]
    assert list(param_group) == ["Parameters", "Label"]

    template_tags = ros_interface["TemplateTags"]
    assert template_tags == ["tag1", "tag2", "tag3"]
