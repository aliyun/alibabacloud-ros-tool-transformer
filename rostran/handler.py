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
