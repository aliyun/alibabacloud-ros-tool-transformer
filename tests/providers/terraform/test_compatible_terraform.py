import os

from rostran.providers import CompatibleTerraformTemplate
from tests.conf import TERRAFORM_PROVIDER_DIR, TERRAFORM_ALICLOUD_DIR


def test_template_with_1_file():
    path = os.path.join(TERRAFORM_ALICLOUD_DIR, "main.tf")
    template = CompatibleTerraformTemplate.initialize(path)
    ros_template = template.transform()
    d = ros_template.as_dict(format=True)
    assert "Workspace" in d
    workspace = d["Workspace"]

    assert workspace.get("main.tf")


def test_template_with_1_level():
    template = CompatibleTerraformTemplate.initialize(TERRAFORM_ALICLOUD_DIR)
    ros_template = template.transform()
    d = ros_template.as_dict(format=True)

    assert "Workspace" in d
    workspace = d["Workspace"]

    assert workspace.get("main.tf")
    assert workspace.get("output.tf")
    assert workspace.get("tftpl/backends.tftpl")


def test_template_with_2_level():
    template = CompatibleTerraformTemplate.initialize(TERRAFORM_PROVIDER_DIR)
    ros_template = template.transform()
    d = ros_template.as_dict(format=True)

    assert "Workspace" in d
    workspace = d["Workspace"]

    assert workspace.get("alicloud/main.tf")
    assert workspace.get("alicloud/output.tf")
    assert workspace.get("alicloud/tftpl/backends.tftpl")
