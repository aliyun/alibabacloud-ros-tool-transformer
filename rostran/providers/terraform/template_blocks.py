import json
from abc import abstractmethod
from typing import Any, Dict, List, Optional, Tuple, Union
from dataclasses import dataclass

try:
    from typing import Protocol, runtime_checkable
except ImportError:
    from typing_extensions import Protocol, runtime_checkable


@runtime_checkable
class TerraformType(Protocol):
    value: Any

    def __str__(self) -> str:
        return self.render()

    @classmethod
    @abstractmethod
    def render(cls, indent: int = 0) -> str:
        raise NotImplementedError


@dataclass
class LiteralType(TerraformType):
    value: Any

    def render(self, _=0):
        return self.value


@dataclass(frozen=True)
class QuotedString(TerraformType):
    value: str

    def render(self, _=0):
        if '"' in self.value:
            value = self.value.replace('"', '\\"')
            return f'"{value}"'
        return f'"{self.value}"'


@dataclass(frozen=True)
class NumberType(TerraformType):
    value: Union[int, float]

    def render(self, _=0):
        return str(self.value)


@dataclass(frozen=True)
class NullType(TerraformType):
    value: str = "null"

    def render(self, _=0):
        return self.value

    def __eq__(self, other: object) -> bool:
        return other == self.value


@dataclass(frozen=True)
class BooleanType(TerraformType):
    value: bool

    def render(self, _=0):
        return str(self.value).lower()


@dataclass
class JsonType(TerraformType):
    value: Union[List[Union[TerraformType, "Block"]], Dict[Union[QuotedString, LiteralType, str], TerraformType]]

    def render(self, indent=0):
        suffix = " " * indent
        indent += 2
        space = " " * indent
        if isinstance(self.value, list):
            result = "[\n"
            for item in self.value:
                comma = "" if item is self.value[-1] else ","
                if not isinstance(item, TerraformType):
                    item = LiteralType(item)
                result += f"{space}{item.render(indent)}{comma}\n"
            result = result.rstrip() + f"\n{suffix}]"
        elif isinstance(self.value, dict):
            if not self.value:
                return "{}"
            result = "{"
            for name, value in self.value.items():
                if not isinstance(value, TerraformType):
                    value = LiteralType(value)
                result += f"\n{space}{name} = {value.render(indent)}"
            result = result.rstrip() + f"\n{suffix}}}"
        else:
            result = str(self.value)

        return result


@dataclass
class CommentType(TerraformType):
    value: str

    def render(self, indent=0):
        spacing = " " * indent
        text = [f"{spacing}// {line.rstrip()}" for line in self.value.splitlines()]
        return "\n".join(text)


def convert_to_tf_type(value: Any, type_: Optional[str] = None) -> TerraformType:
    if isinstance(value, TerraformType):
        return value
    if type_ is None:
        if isinstance(value, str):
            return QuotedString(value)
        elif isinstance(value, bool):
            return BooleanType(value)
        elif isinstance(value, (int, float)):
            return NumberType(value)
        elif value is None:
            return NullType()
        elif isinstance(value, (dict, list)):
            return JsonType(value)
        return LiteralType(value)

    if type_ == "string":
        return QuotedString(value)
    elif type_ == "number":
        return NumberType(value)
    elif type_ == "boolean":
        return BooleanType(value)
    elif type_ == "null":
        return NullType()
    elif type_ in ("json", "dict", "list"):
        return JsonType(value)
    elif type_ == "comment":
        return CommentType(value)
    elif type_:
        return LiteralType(value)


BlockLabel = Tuple[Union[str, QuotedString,], ...]
Arguments = Dict[str, Union[TerraformType, "Block"]]


class Block:

    def __init__(
        self,
        block_type: str,
        labels: Optional[BlockLabel] = None,
        arguments: Optional[Arguments] = None,
    ) -> None:
        self.block_type = block_type
        self.labels = labels if labels else ()
        self.arguments = arguments if arguments else {}

    def base_ref(self):
        return f"{self.block_type}.{'.'.join(str(self.labels))}".replace('"', "")

    def __str__(self) -> str:
        return self.render()

    def render(self, indent=0):
        space = " " * indent
        indent += 2
        labels = " ".join(str(label) for label in self.labels)
        label_space = " " if self.labels else ""
        newline = ""
        args = ""
        if self.arguments:
            newline = "\n" if self.arguments else ""
            indent_spacing = " " * indent
            block_args = []
            comment_args = []
            json_args = []
            common_args = []
            specific_args = []

            for name, value in self.arguments.items():
                if self.block_type == "resource" and name == "count":
                    specific_args.append(f"{indent_spacing}{name} = {value.render(indent)}")
                    continue

                if isinstance(value, Block):
                    block_args.append(value.render(indent))
                elif isinstance(value, CommentType):
                    comment_args.append(value.render(indent))
                elif isinstance(value, JsonType):
                    json_args.append(f"{indent_spacing}{name} = {value.render(indent)}")
                elif isinstance(value, TerraformType):
                    common_args.append(f"{indent_spacing}{name} = {value.render(indent)}")
                else:
                    common_args.append(f"{indent_spacing}{name} = {value}")

            all_args = specific_args + comment_args + common_args + json_args + block_args
            args = "\n".join(all_args)
        return f"{space}{self.block_type}{label_space}{labels} {{{newline}{args}{newline}{space}}}"


class Variable(Block):
    def __init__(self, name: str, arguments: Dict[str, Any]) -> None:
        self.name = name
        super().__init__("variable", (QuotedString(name),), arguments)

    def base_ref(self):
        ref = super().base_ref()
        return ref.replace("variable", "var")


class Locals(Block):
    def __init__(self, arguments: Dict[str, Any]) -> None:
        name = "locals"
        super().__init__(name, (), arguments)


class Data(Block):
    def __init__(
        self,
        name: str,
        block_type: str,
        arguments: Optional[Dict[str, Any]] = None
    ) -> None:
        self.name = name
        self.block_type = block_type
        label = (QuotedString(block_type), QuotedString(name))
        super().__init__("data", label, arguments)


class Resource(Block):
    def __init__(self, name: str, res_type: str, arguments: Dict[str, Any] = None) -> None:
        self.name = name
        self.res_type = res_type
        label = (QuotedString(res_type), QuotedString(name))
        super().__init__("resource", label, arguments)


class Output(Block):
    def __init__(self, name: str, arguments: Dict[str, Any]) -> None:
        self.name = name
        super().__init__("output", (QuotedString(self.name),), arguments)


