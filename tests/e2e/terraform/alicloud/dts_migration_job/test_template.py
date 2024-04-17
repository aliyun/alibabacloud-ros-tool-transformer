import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_dts_migration_job.example": {
            "Type": "ALIYUN::DTS::MigrationJob",
            "Properties": {
                "MigrationMode": {
                    "DataIntialization": True,
                    "DataSynchronization": True,
                    "StructureIntialization": True,
                },
                "DestinationEndpoint": {
                    "EngineName": "MySQL",
                    "InstanceID": "fake-id2",
                    "InstanceType": "RDS",
                    "Password": "fake-password2",
                    "Region": "cn-beijing",
                    "UserName": "fake-name2",
                },
                "MigrationJobName": "terraform-example",
                "SourceEndpoint": {
                    "EngineName": "MySQL",
                    "InstanceID": "fake-id",
                    "InstanceType": "RDS",
                    "Password": "fake-password",
                    "Region": "cn-beijing",
                    "UserName": "fake-name",
                },
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
