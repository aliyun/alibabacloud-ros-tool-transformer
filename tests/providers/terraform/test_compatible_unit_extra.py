import pytest

from rostran.core.exceptions import InvalidTargetFile, TemplateFormatNotSupport
from rostran.core.format import FileFormat
from rostran.providers.terraform.c_template import CompatibleTerraformTemplate


def test_read_existing_target_validates_file_and_parses_yaml(tmp_path):
    with pytest.raises(InvalidTargetFile):
        CompatibleTerraformTemplate.read_exist_file(str(tmp_path / "missing"))
    with pytest.raises(InvalidTargetFile):
        CompatibleTerraformTemplate.read_exist_file(str(tmp_path))
    path = tmp_path / "target.yml"
    path.write_text("Description: test\n")
    assert (
        CompatibleTerraformTemplate.read_exist_file(str(path))["Description"] == "test"
    )
    path.write_text("[")
    with pytest.raises(InvalidTargetFile):
        CompatibleTerraformTemplate.read_exist_file(str(path))


def test_matched_files_and_existing_workspace_override(tmp_path):
    source = tmp_path / "source"
    source.mkdir()
    (source / "main.tf").write_text("new")
    (source / "extra.txt").write_text("extra")
    matched = CompatibleTerraformTemplate.get_matched_files(str(source), ["*"])
    assert {path.rsplit("/", 1)[-1] for path in matched} == {"main.tf", "extra.txt"}
    target = tmp_path / "target.json"
    target.write_text(
        '{"Workspace": {"old.tf": "old"}, "Description": "existing", "Custom": 1}'
    )
    template = CompatibleTerraformTemplate.initialize(
        str(source), FileFormat.Terraform, ["*.txt"], str(target), False
    )
    result = template.transform()
    assert result.workspace.as_dict() == {"old.tf": "old"}
    assert result.description == "existing" and result.additional_data == {"Custom": 1}
    with pytest.raises(TemplateFormatNotSupport):
        CompatibleTerraformTemplate.initialize(str(source), FileFormat.Json)
