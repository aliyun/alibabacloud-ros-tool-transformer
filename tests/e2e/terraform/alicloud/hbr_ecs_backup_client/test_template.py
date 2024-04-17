import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_hbr_ecs_backup_client.example": {
            "Type": "ALIYUN::HBR::BackupClients",
            "Properties": {"InstanceIds": ["fake-id"]},
        }
    },
    "Outputs": {
        "client_id": {
            "Value": {
                "Fn::Jq": [
                    "First",
                    ".[0]",
                    {
                        "Fn::GetAtt": [
                            "alicloud_hbr_ecs_backup_client.example",
                            "ClientIds",
                        ]
                    },
                ]
            }
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
