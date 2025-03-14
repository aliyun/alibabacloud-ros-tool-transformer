

from ruamel.yaml import YAML, ScalarNode, SequenceNode, MappingNode

yaml = YAML()
yaml.preserve_quotes = True

ROS_FUNCTION_NAMES = {
    "MergeMap", "Sub", "Base64Decode", "Indent", "Base64", "If", "EachMemberIn", "FormatTime", "Length",
    "Not", "Replace", "Min", "Equals", "Test", "Split", "Join", "ListMerge", "Or", "ResourceFacade",
    "SelectMapList", "MergeMapToList", "Select", "Calculate", "FindInMap", "MarketplaceImage", "GetAZs",
    "Any", "Contains", "Add", "Str", "GetAtt", "Base64Encode", "GetStackOutput", "TransformNamespace", "Jq",
    "Max", "MemberListToMap", "Index", "Cidr", "GetJsonValue", "Ref", "And", "Avg", "MatchPattern"
}


def make_constructor(fun_name):
    if fun_name == 'Ref':
        tag_name = fun_name
    else:
        tag_name = 'Fn::{}'.format(fun_name)

    if fun_name == 'GetAtt':
        def get_attribute_constructor(loader, node):
            if isinstance(node, ScalarNode):
                value = loader.construct_scalar(node)
                try:
                    split_value = value.split('.')
                    if len(split_value) == 2:
                        resource, attribute = split_value
                    elif len(split_value) >= 3:
                        if split_value[-2] == 'Outputs':
                            resource = '.'.join(split_value[:-2])
                            attribute = '.'.join(split_value[-2:])
                        else:
                            resource = '.'.join(split_value[:-1])
                            attribute = split_value[-1]
                    else:
                        raise ValueError
                    return {tag_name: [resource, attribute]}
                except ValueError:
                    raise ValueError('Resolve !GetAtt error. Value: {}'.format(value))
            elif isinstance(node, SequenceNode):
                values = loader.construct_sequence(node)
                return {tag_name: values}
            else:
                value = loader.construct_object(node)
                return {tag_name: value}
        return get_attribute_constructor

    def construct(loader, node):
        if isinstance(node, ScalarNode):
            value = loader.construct_scalar(node)
        elif isinstance(node, SequenceNode):
            value = loader.construct_sequence(node)
        elif isinstance(node, MappingNode):
            value = loader.construct_mapping(node)
        else:
            value = loader.construct_object(node)
        return {tag_name: value}

    return construct


for f in ROS_FUNCTION_NAMES:
    yaml.constructor.add_constructor('!{}'.format(f), make_constructor(f))
