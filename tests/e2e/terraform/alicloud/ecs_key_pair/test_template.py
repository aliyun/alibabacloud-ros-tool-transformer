import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_key_pair.example": {
            "Type": "ALIYUN::ECS::SSHKeyPair",
            "Properties": {"KeyPairName": "key_pair_name"},
        },
        "alicloud_ecs_key_pair.publickey": {
            "Type": "ALIYUN::ECS::SSHKeyPair",
            "Properties": {
                "KeyPairName": "my_public_key",
                "PublicKeyBody": "ssh-rsa AAAAB3Nza12345678qwertyuudsfsg",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
