"""Merge Cobertura reports for disjoint application components."""

import argparse
import xml.etree.ElementTree as ET
from pathlib import Path


def merge(reports, output):
    if not reports:
        raise ValueError("No component reports supplied")
    result = ET.Element("coverage", version="merged", complexity="0", timestamp="0")
    sources = ET.SubElement(result, "sources")
    packages = ET.SubElement(result, "packages")
    counts = dict.fromkeys(
        ("lines-covered", "lines-valid", "branches-covered", "branches-valid"), 0
    )
    filenames = set()
    source_paths = set()
    for report in reports:
        root = ET.parse(report).getroot()
        for metric in ("lines", "branches"):
            covered = int(root.attrib[f"{metric}-covered"])
            total = int(root.attrib[f"{metric}-valid"])
            if not 0 <= covered <= total:
                raise ValueError(f"Invalid {metric} counts in {report}")
            counts[f"{metric}-covered"] += covered
            counts[f"{metric}-valid"] += total
        for item in root.findall(".//class"):
            filename = item.attrib["filename"]
            if filename in filenames:
                raise ValueError(f"Overlapping coverage file: {filename}")
            filenames.add(filename)
        for source in root.findall("sources/source"):
            if source.text not in source_paths:
                sources.append(source)
                source_paths.add(source.text)
        packages.extend(root.findall("packages/package"))
        timestamp = max(int(result.attrib["timestamp"]), int(root.get("timestamp", "0")))
        result.set("timestamp", str(timestamp))
    result.attrib.update({key: str(value) for key, value in counts.items()})
    for metric, rate in (("lines", "line-rate"), ("branches", "branch-rate")):
        total = counts[f"{metric}-valid"]
        result.set(rate, str(counts[f"{metric}-covered"] / total if total else 0))
    ET.ElementTree(result).write(output, encoding="utf-8", xml_declaration=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("reports", type=Path, nargs="+")
    args = parser.parse_args()
    merge(args.reports, args.output)


if __name__ == "__main__":
    main()
