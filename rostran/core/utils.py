from openpyxl.cell.cell import Cell
from typing import Iterable

from collections import defaultdict


class Graph:
    def __init__(self):
        self.graph = defaultdict(list)
        self.visited = {}

    def add_edge(self, start, end=None):
        self.graph[start].append(end)
        self.visited[start] = False
        self.visited[end] = False

    def topo_sort(self):
        for key in self.visited:
            self.visited[key] = True if key is None else False

        sorted_vertices = []
        for v in self.visited:
            if not self.visited[v]:
                self._topo_sort(v, sorted_vertices)
        return sorted_vertices

    def _topo_sort(self, v, sorted_vertices):
        self.visited[v] = True
        for vv in self.graph[v]:
            if not self.visited[vv]:
                self._topo_sort(vv, sorted_vertices)
        sorted_vertices.append(v)


def get_and_validate_cell(cell: Cell, exc_cls) -> str:
    value = cell.value
    if not isinstance(value, str):
        raise exc_cls(name=value, reason=f"Value of {cell} must be str")

    for val in value.split("\n"):
        val = val.strip()
        if val:
            value = val
            break

    if not value:
        raise exc_cls(name=value, reason=f"Value of {cell} must not be empty")

    return value


def sorted_data(data, traverse=False, scores: dict = None):
    if isinstance(data, dict):
        if scores:
            return sorted_dict(data, traverse, lambda item: scores.get(item[0], 9999))
        return sorted_dict(data, traverse)
    elif isinstance(data, Iterable):
        if scores:
            return sorted(data, key=lambda x: scores.get(x, 9999))
        return sorted(data, key=str)
    return data


def sorted_dict(
    data: dict,
    traverse=False,
    dict_key_func=lambda item: str(item[0]),
):
    sorted_d = dict(sorted(data.items(), key=dict_key_func))
    if traverse:
        for key, value in sorted_d.items():
            if isinstance(value, dict):
                sorted_d[key] = sorted_dict(value, traverse)
    return sorted_d
