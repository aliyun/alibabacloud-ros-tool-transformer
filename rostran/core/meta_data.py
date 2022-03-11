from rostran.core.exceptions import InvalidTemplateMetaData


class MetaItem:
    TYPES = ("ALIYUN::ROS::Interface",)

    def __init__(self, type, value):
        self.type = type
        self.value = value

    def valid(self):
        if self.type not in self.TYPES:
            raise InvalidTemplateMetaData(
                name=self.type,
                reason=f"Type {self.type} is not supported. Allowed types: {self.TYPES}",
            )


class MetaData(dict):
    def add(self, meta_item: MetaItem):
        if meta_item.type is None:
            raise InvalidTemplateMetaData(
                name=meta_item.type, reason="MetaData type should not be None"
            )

        self[meta_item.type] = meta_item

    def as_dict(self) -> dict:
        data = {}
        for key, meta in self.items():
            if meta.value is not None:
                data[key] = meta.value

        return data
