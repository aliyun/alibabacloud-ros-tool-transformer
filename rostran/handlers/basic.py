import json


##############################
# Common Handlers
##############################
def json_load(content, resolved=False):
    if not content or not resolved:
        return None

    return json.loads(content)


def tags_dict_to_list(tags_dict, resolved=False):
    """
    Convert dictionary-formatted tags to list format.
    """
    if not tags_dict:
        return None

    if resolved:
        return [{"Key": k, "Value": v} for k, v in tags_dict.items()]

    return {
        "Fn::Jq": [
            "First",
            'to_entries | map({"Key": .key, "Value": .value})',
            tags_dict,
        ]
    }


def tags_list_to_dict(tags_list, resolved=False):
    """
    Convert list-formatted tags to dict format.
    """
    if not tags_list:
        return None

    if resolved:
        return [{tag["Key"]: tag["Value"]} for tag in tags_list]

    return {
        "Fn::Jq": [
            "First",
            "map({(.Key): .Value})|add",
            tags_list,
        ]
    }


def to_boolean(data, resolved=False):
    """
    Convert data to boolean.
    """
    if data is None or not resolved:
        return None

    return bool(data)


def kv_list_to_map(kv_list, k_name, v_name):
    """
    Convert a list containing dictionaries with key-value pairs into a dictionary.
    For example,
        [{"parameter_key": "Name", "parameter_value": "test"}] will be converted to
        {"Name": "test"}.
    """
    if not kv_list:
        return None

    return {e[k_name]: e[v_name] for e in kv_list}


def select_first(resource_ids, resolved=False):
    """
    Select the first ID from the list of resource IDs.
    """
    if not resource_ids:
        return None

    if resolved:
        return resource_ids[0]

    return {"Fn::Select": ["0", resource_ids]}


def kv_list_to_map_wrapper(k_name, v_name):
    def kv_list_to_map(kv_list, resolved=False):
        """
        Convert a list containing dictionaries with key-value pairs into a dictionary.
        For example,
            [{"parameter_key": "Name", "parameter_value": "test"}] will be converted to
            {"Name": "test"}.
        """
        if not kv_list or not resolved:
            return None

        return {e[k_name]: e[v_name] for e in kv_list}

    return kv_list_to_map


def join_wrapper(splitter=":"):
    def join(items, resolved=False):
        if not items:
            return None

        if resolved:
            return splitter.join(items)

        return {"Fn::Join": [splitter, items]}

    return join


colon_join = join_wrapper(":")
slash_join = join_wrapper("/")
comma_join = join_wrapper(",")


def replace_wrapper(old, new):
    def replace(string, resolved=False):
        if not string:
            return None

        if resolved:
            return string.replace(old, new)

        return {"Fn::Replace": [{old: new}, string]}

    return replace


replace_slash_to_colon = replace_wrapper("/", ":")


def jq_to_string(data, resolved=False):
    return [". | tostring", data]


##############################
# Product Handlers
##############################
def slb_x_forwarded_for(x_forwarded_for, resolved=False):
    if not x_forwarded_for or not resolved:
        return None

    if isinstance(x_forwarded_for, list):
        x_forwarded_for = x_forwarded_for[0]
    if not isinstance(x_forwarded_for, dict):
        return

    mapping = {
        "retrive_slb_ip": "XForwardedFor_SLBIP",
        "retrive_slb_id": "XForwardedFor_SLBID",
        "retrive_slb_proto": "XForwardedFor_proto",
    }
    props = {}
    for k1, k2 in mapping.items():
        v = x_forwarded_for.get(k1)
        if v:
            props[k2] = "on"
    if props:
        props.update({"XForwardedFor": "on"})
    return props


ros_parameters = kv_list_to_map_wrapper(
    k_name="parameter_key", v_name="parameter_value"
)


def ots_search_index_sorters(sorters, resolved=False):
    if not sorters or not resolved:
        return None

    mapping = {
        "FieldSort": {
            "mode": "SortMode",
            "order": "SortOrder",
            "field_name": "FieldName",
        },
        "PrimaryKeySort": {
            "order": "SortOrder",
        },
        "ScoreSort": {
            "order": "SortOrder",
        },
        "GeoDistanceSort": {
            "mode": "SortMode",
            "order": "SortOrder",
            "field_name": "FieldName",
        },
    }
    result = []
    for sorter in sorters:
        sorter_type = sorter.get("sorter_type") or "PrimaryKeySort"
        sorter_type_mapping = mapping.get(sorter_type)
        if not sorter_type_mapping:
            continue

        new_sorter = {}
        for from_, to in sorter_type_mapping.items():
            val = sorter.get(from_)
            if val is not None:
                new_sorter[to] = val
        if new_sorter:
            result.append({sorter_type: new_sorter})

    return result


def ec2_network_interface_ipv6_addresses(ipv6_addresses, resolved=False):
    if not ipv6_addresses or not resolved:
        return None

    return [addr["Ipv6Address"] for addr in ipv6_addresses]


def ec2_network_interface_private_addresses(private_addresses, resolved=False):
    if not private_addresses or not resolved:
        return None

    return [addr["PrivateIpAddress"] for addr in private_addresses]
