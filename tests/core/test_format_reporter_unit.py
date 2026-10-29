import pytest

from rostran.core.format import (
    FileFormat,
    SourceTemplateFormat as Source,
    TargetTemplateFormat as Target,
    convert_template_to_file_format,
)
from rostran.core.reporter import BaseReporter, ROS2TerraformReporter


@pytest.mark.parametrize(
    ("kind", "path", "expected"),
    [
        (Source.Excel, None, FileFormat.Excel),
        (Source.Terraform, None, FileFormat.Terraform),
        (Source.ROS, "template.yml", FileFormat.Yaml),
        (Source.CloudFormation, "template.json", FileFormat.Json),
        (Target.Yaml, None, FileFormat.Yaml),
        (Target.Json, None, FileFormat.Json),
    ],
)
def test_format_conversion(kind, path, expected):
    assert convert_template_to_file_format(kind, path) == expected


@pytest.mark.parametrize(
    ("kind", "path"),
    [
        (Source.ROS, None),
        (Source.ROS, "invalid.txt"),
        (Target.Auto, None),
        ("unknown", None),
    ],
)
def test_invalid_formats_are_rejected(kind, path):
    with pytest.raises(ValueError):
        convert_template_to_file_format(kind, path)


def test_reporter_shows_failures_and_manual_handling(capsys):
    reporter = ROS2TerraformReporter()
    reporter.add_supported_resource("ALIYUN::Supported")
    reporter.add_unsupported_resource("ALIYUN::Unsupported")
    reporter.add_unsupported_property("Resource.Unsupported")
    reporter.add_failed_property("Resource.Failed")
    reporter.add_failed_output("Output")
    reporter.generate_report()
    output = capsys.readouterr().out
    for phrase in ("RESOURCES", "PROPERTIES", "OUTPUTS", "MANUAL HANDLING REQUIRED"):
        assert phrase in output
    BaseReporter().generate_report()
    assert "Conversion completed successfully" in capsys.readouterr().out
