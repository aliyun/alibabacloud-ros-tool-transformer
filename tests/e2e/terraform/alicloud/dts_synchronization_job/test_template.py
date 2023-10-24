import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_dts_synchronization_job.example": {
            "Type": "ALIYUN::DTS::SynchronizationJob",
            "Properties": {
                "DataInitialization": True,
                "DestinationEndpoint": {
                    "InstanceTypeForCreation": "MySQL",
                    "InstanceId": "fake-id2",
                    "InstanceType": "RDS",
                    "Password": "fake-password2",
                    "UserName": "fake-name2",
                },
                "SourceEndpoint": {
                    "InstanceTypeForCreation": "MySQL",
                    "InstanceId": "fake-id",
                    "InstanceType": "RDS",
                    "Password": "fake-password",
                    "UserName": "fake-name",
                },
                "StructureInitialization": True,
            },
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
