from importlib import import_module
from typing import Any

_EXPORTS = {
    "CloudFormationTemplate": "rostran.providers.cloudformation.template",
    "ExcelTemplate": "rostran.providers.excel.template",
    "TerraformTemplate": "rostran.providers.terraform.template",
    "CompatibleTerraformTemplate": "rostran.providers.terraform.c_template",
    "WrapTerraformTemplate": "rostran.providers.ros.template",
}

__all__ = sorted(_EXPORTS)


def __getattr__(name: str) -> Any:
    module_name = _EXPORTS.get(name)
    if module_name is None:
        raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
    value = getattr(import_module(module_name), name)
    globals()[name] = value
    return value
