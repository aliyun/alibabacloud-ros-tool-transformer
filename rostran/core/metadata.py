from rostran.core.exceptions import InvalidTemplateMetaDataItem, InvalidTemplateMetaData
from rostran.core.utils import sorted_data


class MetaItem:
    ROS_INTERFACE = "ALIYUN::ROS::Interface"
    ROS_DESIGNER = "ALIYUN::ROS::Designer"
    PARAMETER_GROUPS = "ParameterGroups"
    PARAMETERS = "Parameters"
    LABEL = "Label"
    DEFAULT = "default"
    TEMPLATE_TAGS = "TemplateTags"

    ROS_INTERFACE_KEY_SCORES = {PARAMETER_GROUPS: 0, TEMPLATE_TAGS: 1}
    PARAMETER_GROUP_KEY_SCORES = {PARAMETERS: 0, LABEL: 1}

    def __init__(self, type: str, value: dict):
        self.type = type
        self.value = value

    @classmethod
    def initialize(cls, type: str, value: dict):
        meta_item = cls(type, value)
        meta_item.validate()
        return meta_item

    def validate(self):
        if not isinstance(self.type, str):
            raise InvalidTemplateMetaDataItem(
                name=self.type, reason=f"The type should be str",
            )
        if not isinstance(self.value, dict):
            raise InvalidTemplateMetaDataItem(
                name=self.type,
                reason=f"The type of value ({self.value}) should be dict",
            )

        # validate ALIYUN::ROS::Interface
        if self.type == self.ROS_INTERFACE:
            # validate ParameterGroups
            if self.PARAMETER_GROUPS in self.value:
                param_groups = self.value[self.PARAMETER_GROUPS]
                if not isinstance(param_groups, list):
                    raise InvalidTemplateMetaDataItem(
                        name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}",
                        reason=f"The type of value ({param_groups}) should be list",
                    )
                for i, param_group in enumerate(param_groups):
                    if not isinstance(param_group, dict):
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}]",
                            reason=f"The type of value ({param_group}) should be dict",
                        )
                    # validate Parameters
                    if self.PARAMETERS not in param_group:
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}]",
                            reason=f"{self.PARAMETERS} is missing",
                        )
                    parameters = param_group[self.PARAMETERS]
                    if not isinstance(parameters, list):
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}].{self.PARAMETERS}",
                            reason=f"The type of value ({parameters}) should be list",
                        )
                    for j, parameter in enumerate(parameters):
                        if not isinstance(parameter, str):
                            raise InvalidTemplateMetaDataItem(
                                name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}].{self.PARAMETERS}[{j}]",
                                reason=f"The type of value ({parameter}) should be str",
                            )
                    # validate Label
                    if self.LABEL not in param_group:
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}]",
                            reason=f"{self.LABEL} is missing",
                        )
                    label = param_group[self.LABEL]
                    if not isinstance(label, dict):
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}].{self.LABEL}",
                            reason=f"The type of value ({label}) should be dict",
                        )
                    if self.DEFAULT not in label:
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.PARAMETER_GROUPS}[{i}].{self.LABEL}",
                            reason=f"{self.DEFAULT} is missing",
                        )

            # validate TemplateTags
            if self.TEMPLATE_TAGS in self.value:
                template_tags = self.value[self.TEMPLATE_TAGS]
                if not isinstance(template_tags, list):
                    raise InvalidTemplateMetaDataItem(
                        name=f"{self.ROS_INTERFACE}.{self.TEMPLATE_TAGS}",
                        reason=f"The type of value ({template_tags}) should be list",
                    )
                for i, template_tag in enumerate(template_tags):
                    if not isinstance(template_tag, str):
                        raise InvalidTemplateMetaDataItem(
                            name=f"{self.ROS_INTERFACE}.{self.TEMPLATE_TAGS}[{i}]",
                            reason=f"The type of value ({template_tag}) should be str",
                        )

    def as_dict(self, format=False):
        data = {self.type: self.value}
        if not format:
            return data

        if self.type == self.ROS_INTERFACE:
            data[self.type] = sorted_data(
                self.value, scores=self.ROS_INTERFACE_KEY_SCORES
            )

            param_groups = self.value.get(self.PARAMETER_GROUPS)
            if param_groups:
                for i, param_group in enumerate(param_groups):
                    param_groups[i] = sorted_data(
                        param_group, scores=self.PARAMETER_GROUP_KEY_SCORES
                    )
            template_tags = self.value.get(self.TEMPLATE_TAGS)
            if template_tags:
                template_tags.sort()

        return data


class MetaData(dict):
    ROS_INTERFACE = "ALIYUN::ROS::Interface"
    ROS_DESIGNER = "ALIYUN::ROS::Designer"
    META_DATA_KEY_SCORES = {ROS_INTERFACE: 0, ROS_DESIGNER: 1}

    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateMetaData(
                reason=f"The type of data ({data}) should be dict"
            )

        meta_data = cls()
        for type, value in data.items():
            meta_item = MetaItem.initialize(type, value)
            meta_data.add(meta_item)
        return meta_data

    def add(self, meta_item: MetaItem):
        self[meta_item.type] = meta_item

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted_data(keys, scores=self.META_DATA_KEY_SCORES)
        for key in keys:
            meta: MetaItem = self[key]
            if meta.value is not None:
                data.update(meta.as_dict(format))

        return data
