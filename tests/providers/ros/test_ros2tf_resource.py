"""
Test script for ROS-to-Terraform resource template transformation.

Usage:
    # Transform by ROS resource type (fetches template from ROS API):
    python -m tests.providers.ros.test_ros2tf_resource --resource-type ALIYUN::ECS::Instance

    # Transform from a local ROS template file:
    python -m tests.providers.ros.test_ros2tf_resource --template-path my_template.yml

    # Template path is relative to downloads/ros-templates by default,
    # or use an absolute path:
    python -m tests.providers.ros.test_ros2tf_resource --template-path /abs/path/to/template.yml

    # Skip terraform validate:
    python -m tests.providers.ros.test_ros2tf_resource --resource-type ALIYUN::ECS::VPC --skip-validate
"""

import argparse
import json
import os
import sys
import traceback
from datetime import datetime
from pathlib import Path

from libterraform import TerraformCommand
from libterraform.exceptions import TerraformCommandError

from rostran.core.exceptions import RosTranException
from rostran.providers.ros.template import ROS2TerraformTemplate
from rostran.providers.ros.yaml_util import yaml

PROJECT_ROOT = Path(__file__).resolve().parents[3]
DEFAULT_TEMPLATE_DIR = PROJECT_ROOT / "downloads" / "ros-templates"
DEFAULT_OUTPUT_DIR = PROJECT_ROOT / "downloads" / "test_ros2tf_results"

SEPARATOR = "=" * 72
THIN_SEP = "-" * 72


def fetch_template_by_resource_type(resource_type: str) -> dict:
    from alibabacloud_tea_openapi import models as open_api_models
    from alibabacloud_ros20190910.client import Client
    from alibabacloud_credentials.client import Client as CredClient
    from alibabacloud_ros20190910 import models

    cred = CredClient()
    config = open_api_models.Config(credential=cred)
    client = Client(config)
    request = models.GetResourceTypeTemplateRequest(resource_type=resource_type)
    response = client.get_resource_type_template(request)
    return response.to_map()["body"]["TemplateBody"]


def load_template_from_file(template_path: str) -> dict:
    path = Path(template_path)
    if not path.is_absolute():
        path = DEFAULT_TEMPLATE_DIR / path
    path = path.resolve()

    if not path.exists():
        raise FileNotFoundError(f"Template file not found: {path}")

    with open(path, "r", encoding="utf-8") as f:
        if path.suffix == ".json":
            return json.load(f)
        return yaml.load(f)


def run_terraform_validate(output_dir: str) -> tuple:
    """Returns (success: bool, message: str)."""
    tf = TerraformCommand(output_dir)
    tf_dir = os.path.join(output_dir, ".terraform")
    lock_file = os.path.join(output_dir, ".terraform.lock.hcl")
    if not os.path.exists(tf_dir) or not os.path.exists(lock_file):
        tf.init(check=True)
    try:
        tf.validate(check=True)
        return True, "terraform validate: SUCCESS"
    except TerraformCommandError as e:
        return False, f"terraform validate: FAILED\n{e.stdout}"


def read_tf_files(output_dir: str) -> dict:
    """Read all .tf files from the output directory."""
    result = {}
    for fname in sorted(os.listdir(output_dir)):
        if fname.endswith(".tf"):
            fpath = os.path.join(output_dir, fname)
            with open(fpath, "r", encoding="utf-8") as f:
                result[fname] = f.read()
    return result


def write_summary(summary_path: str, summary: dict):
    with open(summary_path, "w", encoding="utf-8") as f:
        f.write("# ROS to Terraform Transformation Result\n\n")
        f.write(f"- **Source**: {summary['source']}\n")
        f.write(f"- **Time**: {summary['time']}\n")
        f.write(f"- **Status**: {summary['status']}\n")
        if summary.get("error"):
            f.write(f"- **Error**: {summary['error']}\n")
        if summary.get("validate"):
            f.write(f"- **Validate**: {summary['validate']}\n")
        f.write(f"\n## Generated Terraform Files\n\n")
        for fname, content in summary.get("tf_files", {}).items():
            f.write(f"### {fname}\n\n```hcl\n{content}\n```\n\n")


def transform_and_report(
    source_label: str,
    template: dict,
    output_dir: str,
    skip_validate: bool = False,
    single_file: bool = True,
):
    summary = {
        "source": source_label,
        "time": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "status": "UNKNOWN",
        "error": None,
        "validate": None,
        "tf_files": {},
    }

    print(f"\n{SEPARATOR}")
    print(f"  Source: {source_label}")
    print(f"  Output: {output_dir}")
    print(SEPARATOR)

    os.makedirs(output_dir, exist_ok=True)

    # Save the source ROS template
    ros_tpl_path = os.path.join(output_dir, "template.yml")
    with open(ros_tpl_path, "w", encoding="utf-8") as f:
        yaml.dump(template, f)
    print(f"  ROS template saved to: {ros_tpl_path}")

    # Transform
    try:
        ros2tf = ROS2TerraformTemplate.initialize(template, validate=False)
        ros2tf.transform(output_dir, single_file=single_file)
        summary["status"] = "TRANSFORM_SUCCESS"
        print(f"\n  [OK] Transformation succeeded")
    except RosTranException as e:
        summary["status"] = "TRANSFORM_FAILED"
        summary["error"] = str(e)
        print(f"\n  [FAIL] Transformation failed: {e}")
        _write_and_return(output_dir, summary)
        return summary
    except Exception as e:
        summary["status"] = "TRANSFORM_ERROR"
        summary["error"] = traceback.format_exc()
        print(f"\n  [ERROR] Unexpected error during transformation:\n{e}")
        _write_and_return(output_dir, summary)
        return summary

    # Read generated TF files
    tf_files = read_tf_files(output_dir)
    summary["tf_files"] = tf_files

    print(f"\n{THIN_SEP}")
    print("  Generated Terraform code:")
    print(THIN_SEP)
    for fname, content in tf_files.items():
        print(f"\n  --- {fname} ---")
        for line in content.splitlines():
            print(f"  {line}")

    # Terraform validate
    if not skip_validate:
        print(f"\n{THIN_SEP}")
        print("  Running terraform validate ...")
        ok, msg = run_terraform_validate(output_dir)
        summary["validate"] = "SUCCESS" if ok else "FAILED"
        if ok:
            summary["status"] = "SUCCESS"
            print(f"  [OK] {msg}")
        else:
            summary["status"] = "VALIDATE_FAILED"
            print(f"  [FAIL] {msg}")
    else:
        summary["status"] = "TRANSFORM_SUCCESS (validate skipped)"
        print("\n  [SKIP] Terraform validate skipped")

    _write_and_return(output_dir, summary)
    return summary


def _write_and_return(output_dir, summary):
    summary_path = os.path.join(output_dir, "RESULT.md")
    write_summary(summary_path, summary)
    print(f"\n  Result saved to: {summary_path}")
    print(SEPARATOR)


def dir_name_from_resource_type(resource_type: str) -> str:
    """ALIYUN::ECS::Instance -> ecs_instance"""
    return resource_type.split("::", 1)[-1].lower().replace("::", "_")


def dir_name_from_template_path(template_path: str) -> str:
    return Path(template_path).stem


def main():
    parser = argparse.ArgumentParser(
        description="Test ROS-to-Terraform template transformation for a specific resource type or template file."
    )
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "--resource-type", "-r",
        help="ROS resource type, e.g. ALIYUN::ECS::Instance. Fetches template from ROS API.",
    )
    group.add_argument(
        "--template-path", "-t",
        help="Path to a ROS template file. Relative paths are resolved under downloads/ros-templates.",
    )
    parser.add_argument(
        "--output-dir", "-o",
        default=str(DEFAULT_OUTPUT_DIR),
        help=f"Base output directory (default: {DEFAULT_OUTPUT_DIR}).",
    )
    parser.add_argument(
        "--skip-validate",
        default=True,
        action="store_true",
        help="Skip terraform validate step.",
    )
    parser.add_argument(
        "--multi-file",
        default=True,
        action="store_true",
        help="Generate separate .tf files (local.tf, variable.tf, main.tf, output.tf) instead of a single main.tf.",
    )

    args = parser.parse_args()
    single_file = not args.multi_file

    if args.resource_type:
        resource_type = args.resource_type
        print(f"\nFetching ROS template for resource type: {resource_type} ...")
        try:
            template = fetch_template_by_resource_type(resource_type)
        except Exception as e:
            print(f"[ERROR] Failed to fetch template for {resource_type}: {e}")
            sys.exit(1)

        sub_dir = dir_name_from_resource_type(resource_type)
        source_label = f"ResourceType: {resource_type}"
    else:
        template_path = args.template_path
        print(f"\nLoading ROS template from file: {template_path} ...")
        try:
            template = load_template_from_file(template_path)
        except Exception as e:
            print(f"[ERROR] Failed to load template: {e}")
            sys.exit(1)

        sub_dir = dir_name_from_template_path(template_path)
        resolved = Path(template_path)
        if not resolved.is_absolute():
            resolved = DEFAULT_TEMPLATE_DIR / resolved
        source_label = f"File: {resolved.resolve()}"

    output_dir = os.path.join(args.output_dir, sub_dir)
    summary = transform_and_report(
        source_label=source_label,
        template=template,
        output_dir=output_dir,
        skip_validate=args.skip_validate,
        single_file=single_file,
    )

    print(f"\n{'=' * 40}")
    print(f"  Final Status: {summary['status']}")
    print(f"{'=' * 40}\n")

    if summary["status"] not in ("SUCCESS", "TRANSFORM_SUCCESS (validate skipped)"):
        sys.exit(1)


if __name__ == "__main__":
    main()
