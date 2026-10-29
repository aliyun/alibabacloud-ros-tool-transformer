import pytest
from openpyxl import Workbook

from rostran.core.exceptions import InvalidExcelTemplate, TemplateFormatNotSupport
from rostran.core.format import FileFormat
from rostran.providers.excel.template import ExcelTemplate


def test_excel_rejects_unsupported_format_and_invalid_columns(tmp_path):
    with pytest.raises(TemplateFormatNotSupport):
        ExcelTemplate.initialize(str(tmp_path / "file"), FileFormat.Json)
    workbook = Workbook()
    workbook.active["A1"] = "only one column"
    with pytest.raises(InvalidExcelTemplate, match="Column number"):
        ExcelTemplate(workbook).transform()
    workbook.active["G1"] = "too many"
    with pytest.raises(InvalidExcelTemplate, match="Column number"):
        ExcelTemplate(workbook).transform()


def test_excel_rejects_unknown_section_and_supports_missing_resource_cells():
    workbook = Workbook()
    sheet = workbook.active
    sheet.append(["ROS::Unknown", "value"])
    with pytest.raises(InvalidExcelTemplate, match="invalid"):
        ExcelTemplate(workbook).transform()
    sheet.delete_rows(1)
    sheet.append(["# comment", "ignored", "ignored"])
    sheet.append(["ROS::Resources", None, None])
    sheet.append(["ECS::VPC", "Vpc", None])
    sheet.append(["VpcName", "demo", "ignored"])
    result = ExcelTemplate(workbook).transform()
    assert len(result) == 2
    assert result[0].resources["Vpc"].properties["VpcName"].value == "demo"
    assert not result[1].resources
