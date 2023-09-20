import os
import yaml


class RuleFormatter:
    TOP_ORDER = (
        "Version",
        "Type",
        "ResourceType",
        "Properties",
        "Attributes",
    )
    PROPS_ORDER = ("To", "Type", "Schema")
    ATTRS_ORDER = ("id",)

    def __init__(self, rule_dir):
        self.rule_dir = rule_dir

    def format(self):
        for filename in os.listdir(self.rule_dir):
            if not filename.endswith((".yml", ".yaml")):
                continue

            path = os.path.join(self.rule_dir, filename)
            with open(path, "r") as f:
                rule = yaml.safe_load(f)

            ordered_rule = self._format_data(rule, self.TOP_ORDER)
            rule_props = ordered_rule.get("Properties")
            if rule_props:
                ordered_rule["Properties"] = self._format_properties(rule_props)
            rule_attrs = ordered_rule.get("Attributes")
            if rule_attrs:
                ordered_rule["Attributes"] = self._format_data(
                    rule_attrs, self.ATTRS_ORDER
                )

            with open(path, "w") as f:
                f.write(yaml.safe_dump(ordered_rule, sort_keys=False))

    def _format_data(self, data: dict, keys_order=None):
        ordered_data = {}
        if keys_order:
            for key in keys_order:
                value = data.pop(key, None)
                if value:
                    ordered_data[key] = value
        if data:
            for key in sorted(data):
                ordered_data[key] = data[key]
        return ordered_data

    def _format_properties(self, props: dict):
        ordered_props = self._format_data(props)
        for k, v in ordered_props.items():
            if not isinstance(v, dict):
                continue
            v = ordered_props[k] = self._format_data(v, self.PROPS_ORDER)
            schema = v.get("Schema")
            if schema:
                v["Schema"] = self._format_properties(schema)
        return ordered_props
