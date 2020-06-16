from openpyxl.cell.cell import Cell


def get_and_validate_cell(cell: Cell, exc_cls) -> str:
    value = cell.value
    if not isinstance(value, str):
        raise exc_cls(name=value, reason=f'Value of {cell} must be str')

    for val in value.split('\n'):
        val = val.strip()
        if val:
            value = val
            break

    if not value:
        raise exc_cls(name=value, reason=f'Value of {cell} must not be empty')

    return value
