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
