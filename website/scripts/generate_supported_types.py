#!/usr/bin/env python3
"""Generate supported-types docs for Docusaurus from rostran rules."""

import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from rostran.core.rule_manager import RuleManager, RuleClassifier

WEBSITE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DOCS_DIR = os.path.join(WEBSITE_DIR, "docs", "supported-types")
I18N_DIR = os.path.join(
    WEBSITE_DIR,
    "i18n",
    "zh-cn",
    "docusaurus-plugin-content-docs",
    "current",
    "supported-types",
)


def generate_resource_table(rule_manager, reverse=False):
    """Generate markdown table from rule_manager's resource_rules."""
    lines = []

    if reverse:
        from_label = "ROS"
        to_label = "Terraform"
    else:
        from_label = {
            RuleClassifier.TerraformAliCloud: "Terraform",
            RuleClassifier.CloudFormation: "CloudFormation",
        }.get(rule_manager.rule_classifier, "From")
        to_label = "ROS"

    if rule_manager.resource_rules:
        lines.append(f"| {from_label} | {to_label} |")
        lines.append("| --- | --- |")
        for from_ in sorted(rule_manager.resource_rules):
            rule = rule_manager.resource_rules[from_]
            to = rule.target_resource_type
            if not to:
                continue

            from_link = _get_from_link(rule_manager.rule_classifier, from_, reverse)
            to_link = _get_to_link(rule_manager.rule_classifier, to, reverse)

            from_md = f"[{from_}]({from_link})" if from_link else from_
            to_md = f"[{to}]({to_link})" if to_link else to
            lines.append(f"| {from_md} | {to_md} |")

    return "\n".join(lines)


def generate_simple_table(data, from_label, to_label):
    """Generate a simple two-column markdown table from a dict."""
    lines = []
    lines.append(f"| {from_label} | {to_label} |")
    lines.append("| --- | --- |")
    for from_ in sorted(data):
        to = data[from_]
        if isinstance(to, dict):
            to = to.get("To", "")
        if not to:
            continue
        from_ = _escape_mdx(from_)
        to = _escape_mdx(to)
        lines.append(f"| {from_} | {to} |")
    return "\n".join(lines)


def _escape_mdx(text):
    """Escape < and > to prevent MDX from treating them as JSX tags."""
    return text.replace("<", "\\<").replace(">", "\\>")


def _get_from_link(classifier, rt, reverse=False):
    if reverse:
        rt_lower = rt.replace("::", "-").lower()
        return f"https://www.alibabacloud.com/help/ros/developer-reference/{rt_lower}"

    if classifier == RuleClassifier.TerraformAliCloud:
        name = rt.replace("alicloud_", "")
        return f"https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/{name}"
    elif classifier == RuleClassifier.CloudFormation:
        name = rt.replace("AWS::", "").replace("::", "-").lower()
        return f"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-{name}"
    return None


def _get_to_link(classifier, rt, reverse=False):
    if reverse:
        name = rt.replace("alicloud_", "")
        return f"https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/{name}"

    rt_lower = rt.replace("::", "-").lower()
    return f"https://www.alibabacloud.com/help/ros/developer-reference/{rt_lower}"


def generate_extra_sections(rule_manager, lang="en"):
    """Generate Pseudo Parameters, Functions, AssociationProperty, Metadata sections."""
    sections = []

    if rule_manager.pseudo_parameters_rule:
        data = rule_manager.pseudo_parameters_rule.pseudo_parameters
        if lang == "en":
            heading = "## Pseudo Parameters\n\nFor the transform of CloudFormation pseudo parameters, the following is supported:"
        else:
            heading = "## 伪参数\n\nCloudFormation 伪参数转换支持如下："
        table = generate_simple_table(data, "CloudFormation", "ROS")
        sections.append(f"{heading}\n\n{table}")

    if rule_manager.function_rule:
        data = rule_manager.function_rule.function
        if lang == "en":
            heading = "## Functions\n\nFor transform of CloudFormation functions, the following are supported:"
        else:
            heading = "## 函数\n\nCloudFormation 函数转换支持如下："
        table = generate_simple_table(data, "CloudFormation", "ROS")
        sections.append(f"{heading}\n\n{table}")

    if rule_manager.association_property_rule:
        data = rule_manager.association_property_rule.association_property
        if lang == "en":
            heading = "## AssociationProperty\n\nFor transform of CloudFormation AssociationProperty, the following are supported:"
        else:
            heading = (
                "## AssociationProperty\n\nCloudFormation AssociationProperty 转换支持如下："
            )
        table = generate_simple_table(data, "CloudFormation", "ROS")
        sections.append(f"{heading}\n\n{table}")

    if rule_manager.meta_data_rule:
        data = rule_manager.meta_data_rule.meta_data
        if lang == "en":
            heading = "## Metadata\n\nFor transform of CloudFormation Metadata, the following are supported:"
        else:
            heading = "## Metadata\n\nCloudFormation Metadata 转换支持如下："
        table = generate_simple_table(data, "CloudFormation", "ROS")
        sections.append(f"{heading}\n\n{table}")

    return "\n\n".join(sections)


def generate_terraform_doc():
    rule_manager = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
    table = generate_resource_table(rule_manager)
    return f"""---
sidebar_position: 1
title: Terraform
---

# Terraform

## Resources

For the transform of Terraform resources, the following is supported:

{table}
"""


def generate_cloudformation_doc():
    rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)
    resource_table = generate_resource_table(rule_manager)
    extra = generate_extra_sections(rule_manager, lang="en")
    return f"""---
sidebar_position: 2
title: CloudFormation
---

# CloudFormation

## Resources

For the transform of CloudFormation resources, the following is supported:

{resource_table}

{extra}
"""


def generate_ros_to_terraform_doc():
    rule_manager = RuleManager.initialize(RuleClassifier.ROS)
    table = generate_resource_table(rule_manager, reverse=True)
    return f"""---
sidebar_position: 3
title: ROS to Terraform
---

# ROS to Terraform

## Resources

For the transform of ROS resources to Terraform, the following is supported:

{table}
"""


def generate_terraform_doc_zh():
    rule_manager = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
    table = generate_resource_table(rule_manager)
    return f"""---
sidebar_position: 1
title: Terraform
---

# Terraform

## 资源

Terraform 资源转换支持如下：

{table}
"""


def generate_cloudformation_doc_zh():
    rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)
    resource_table = generate_resource_table(rule_manager)
    extra = generate_extra_sections(rule_manager, lang="zh")
    return f"""---
sidebar_position: 2
title: CloudFormation
---

# CloudFormation

## 资源

CloudFormation 资源转换支持如下：

{resource_table}

{extra}
"""


def generate_ros_to_terraform_doc_zh():
    rule_manager = RuleManager.initialize(RuleClassifier.ROS)
    table = generate_resource_table(rule_manager, reverse=True)
    return f"""---
sidebar_position: 3
title: ROS 转 Terraform
---

# ROS 转 Terraform

## 资源

ROS 资源转 Terraform 支持如下：

{table}
"""


def write_file(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write(content)
    print(f"  Generated: {os.path.relpath(path, WEBSITE_DIR)}")


def main():
    print("Generating supported-types docs...")

    # English
    write_file(os.path.join(DOCS_DIR, "terraform.md"), generate_terraform_doc())
    write_file(
        os.path.join(DOCS_DIR, "cloudformation.md"), generate_cloudformation_doc()
    )
    write_file(
        os.path.join(DOCS_DIR, "ros-to-terraform.md"), generate_ros_to_terraform_doc()
    )

    # Chinese
    write_file(os.path.join(I18N_DIR, "terraform.md"), generate_terraform_doc_zh())
    write_file(
        os.path.join(I18N_DIR, "cloudformation.md"), generate_cloudformation_doc_zh()
    )
    write_file(
        os.path.join(I18N_DIR, "ros-to-terraform.md"),
        generate_ros_to_terraform_doc_zh(),
    )

    print("Done!")


if __name__ == "__main__":
    main()
