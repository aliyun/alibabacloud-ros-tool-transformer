def insert_str(value, merged_value=None, resolved=False):
    if not merged_value:
        return value

    if resolved:
        return f"{value}/{merged_value}"

    return {"Fn::Join": ["/", [value, merged_value]]}


def append_str(value, merged_value=None, resolved=False):
    if not merged_value:
        return value

    if resolved:
        return f"{merged_value}/{value}"

    return {"Fn::Join": ["/", [merged_value, value]]}
