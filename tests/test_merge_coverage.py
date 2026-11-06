import sys
import xml.etree.ElementTree as ET

import pytest

from tools.merge_coverage import main, merge


def report(tmp_path, name, lines=(9, 10), branches=(3, 4), source="."):
    path = tmp_path / f"{name}.xml"
    path.write_text(
        f'<coverage lines-covered="{lines[0]}" lines-valid="{lines[1]}" '
        f'branches-covered="{branches[0]}" branches-valid="{branches[1]}" '
        f'line-rate="0" branch-rate="0" timestamp="123">'
        f'<sources><source>{source}</source></sources><packages>'
        f'<package name="{name}"><classes><class filename="{name}/app.py">'
        '<lines><line number="1" hits="1" branch="true" '
        'condition-coverage="75% (3/4)" /></lines></class></classes></package>'
        '</packages></coverage>'
    )
    return path


def test_merge_counts_weighted_rates_and_preserves_details(tmp_path, monkeypatch):
    first = report(tmp_path, "main")
    second = report(tmp_path, "frontend", lines=(1, 2), branches=(1, 2))
    output = tmp_path / "coverage.xml"
    monkeypatch.setattr(
        sys, "argv", ["merge", "--output", str(output), str(first), str(second)]
    )
    main()
    root = ET.parse(output).getroot()
    assert root.attrib["lines-covered"] == "10"
    assert root.attrib["lines-valid"] == "12"
    assert root.attrib["branches-covered"] == "4"
    assert root.attrib["branches-valid"] == "6"
    assert float(root.attrib["line-rate"]) == pytest.approx(10 / 12)
    assert float(root.attrib["branch-rate"]) == pytest.approx(4 / 6)
    assert len(root.findall("sources/source")) == 1
    assert [item.attrib["filename"] for item in root.findall(".//class")] == [
        "main/app.py", "frontend/app.py"
    ]
    assert all(
        item.attrib["condition-coverage"] == "75% (3/4)"
        for item in root.findall(".//line")
    )


def test_single_component_and_unavailable_branches(tmp_path):
    first = report(tmp_path, "main", lines=(0, 0), branches=(0, 0))
    output = tmp_path / "coverage.xml"
    merge([first], output)
    root = ET.parse(output).getroot()
    assert root.attrib["line-rate"] == "0"
    assert root.attrib["branch-rate"] == "0"
    assert root.attrib["branches-valid"] == "0"


def test_different_sources_are_preserved(tmp_path):
    first = report(tmp_path, "main", source="/repo")
    second = report(tmp_path, "frontend", source="/frontend")
    output = tmp_path / "coverage.xml"
    merge([first, second], output)
    assert len(ET.parse(output).findall("sources/source")) == 2


@pytest.mark.parametrize("counts", [(-1, 10), (11, 10)])
def test_invalid_counts_fail(tmp_path, counts):
    first = report(tmp_path, "main", lines=counts)
    with pytest.raises(ValueError, match="Invalid lines counts"):
        merge([first], tmp_path / "coverage.xml")


def test_overlapping_or_missing_reports_fail(tmp_path):
    first = report(tmp_path, "main")
    with pytest.raises(ValueError, match="Overlapping coverage file"):
        merge([first, first], tmp_path / "coverage.xml")
    with pytest.raises(ValueError, match="No component reports"):
        merge([], tmp_path / "coverage.xml")
    with pytest.raises(FileNotFoundError):
        merge([tmp_path / "missing.xml"], tmp_path / "coverage.xml")
