import json


def ecs_security_group_first_id(sg_ids, resolved=False):
    if not sg_ids:
        return None

    if resolved:
        return sg_ids[0]

    return {"Fn::Select": ["0", sg_ids]}


def tags_dict_to_list(tags_dict, resolved=False):
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


def json_load(content, resolved=False):
    if not content or not resolved:
        return None

    return json.loads(content)
