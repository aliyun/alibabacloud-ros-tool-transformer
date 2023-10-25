import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_cen_route_service.example": {
            "Type": "ALIYUN::CEN::CenRouteService",
            "Properties": {
                "AccessRegionId": "cn-beijing",
                "CenId": "fake-id",
                "Host": "100.118.28.52/32",
                "HostRegionId": "cn-beijing",
                "HostVpcId": "fake-id",
            },
        }
    },
    "Outputs": {
        "id": {
            "Value": {
                "Fn::Replace": [
                    {"/": ":"},
                    {"Fn::GetAtt": ["alicloud_cen_route_service.example", "Id"]},
                ]
            }
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
