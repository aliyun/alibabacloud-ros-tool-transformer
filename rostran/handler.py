def ecs_security_group_first_id(sg_ids, resolved=False):
    if not sg_ids:
        return None

    if resolved:
        return sg_ids[0]

    return {"Fn::Select": ["0", sg_ids]}
