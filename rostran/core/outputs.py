from .exceptions import InvalidTemplateOutput


class Output:
    TYPES = (STRING, NUMBER, LIST, MAP, BOOLEAN) = (
        "String",
        "Number",
        "CommaDelimitedList",
        "Json",
        "Boolean",
    )

    def __init__(self, name, value, description=None, condition=None):
        self.name = name
        self.value = value
        self.description = description
        self.condition = condition


class Outputs(dict):
    def add(self, output: Output):
        if output.name is None:
            raise InvalidTemplateOutput(
                name=output.name, reason="Parameter name should not be None"
            )

        self[output.name] = output

    def as_dict(self) -> dict:
        data = {}
        for key, output in self.items():
            value = {"Value": output.value}
            if output.description is not None:
                value.update({"Description": output.description})
            if output.condition is not None:
                value.update({"Condition": output.condition})
            data[key] = value

        return data
