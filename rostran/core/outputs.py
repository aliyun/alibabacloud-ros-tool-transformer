from .exceptions import InvalidTemplateOutput, InvalidTemplateOutputs


class Output:
    PROPERTIES = (VALUE, DESCRIPTION, CONDITION) = (
        "Value",
        "Description",
        "Condition",
    )

    def __init__(
        self, name, value, description=None, condition=None, orig_data: dict = None
    ):
        self.name = name
        self.value = value
        self.description = description
        self.condition = condition
        self.orig_data = orig_data

    @classmethod
    def initialize(cls, name: str, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateOutput(
                name=name, reason=f"The type of data ({data}) should be dict"
            )
        output = cls(
            name,
            value=data.get(cls.VALUE),
            description=data.get(cls.DESCRIPTION),
            condition=data.get(cls.CONDITION),
            orig_data=data,
        )
        output.validate()
        return output

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateOutput(
                name=self.name,
                reason=f"The type should be str",
            )
        if self.value is None:
            raise InvalidTemplateOutput(
                name=self.name,
                reason=f"The {self.VALUE} should not be empty",
            )
        if self.condition is not None and not isinstance(self.condition, str):
            raise InvalidTemplateOutput(
                name=self.name,
                reason=f"The type of {self.CONDITION} should be str",
            )

    def as_dict(self, format=False) -> dict:
        if not format and self.orig_data:
            data = {k: v for k, v in self.orig_data.items() if v is not None}
        else:
            data = {}
            if self.description is not None:
                data.update({self.DESCRIPTION: self.description})
            if self.condition is not None:
                data.update({self.CONDITION: self.condition})
            data[self.VALUE] = self.value
        return {self.name: data}


class Outputs(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateOutputs(
                reason=f"The type of data ({data}) should be dict"
            )

        outputs = cls()
        for name, val in data.items():
            output = Output.initialize(name, val)
            outputs.add(output)
        return outputs

    def add(self, output: Output):
        self[output.name] = output

    def as_dict(self, format=False) -> dict:
        data = {}
        for output in self.values():
            output: Output
            data.update(output.as_dict(format))
        return data
