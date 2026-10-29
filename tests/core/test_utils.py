import pytest
from openpyxl import Workbook

from rostran.core.utils import Graph, get_and_validate_cell, sorted_data


def test_graph_sorts_dependencies_and_can_be_reused():
    graph = Graph()
    graph.add_edge("app", "database")
    graph.add_edge("database")
    assert graph.topo_sort() == ["database", "app"]
    assert graph.topo_sort() == ["database", "app"]


def test_cell_uses_first_nonempty_line():
    cell = Workbook().active["A1"]
    cell.value = "\n first \nsecond"
    assert get_and_validate_cell(cell, ValueErrorWithDetails) == "first"


class ValueErrorWithDetails(Exception):
    def __init__(self, **details):
        self.details = details


@pytest.mark.parametrize("value", [None, 3, ""])
def test_cell_rejects_non_strings_and_empty_values(value):
    cell = Workbook().active["A1"]
    cell.value = value
    with pytest.raises(ValueErrorWithDetails):
        get_and_validate_cell(cell, ValueErrorWithDetails)


def test_sorted_data_handles_nested_dicts_scores_and_scalars():
    assert list(sorted_data({"b": 1, "a": 2})) == ["a", "b"]
    result = sorted_data({"b": {"z": 1, "a": 2}, "a": 0}, traverse=True)
    assert list(result) == ["a", "b"]
    assert list(result["b"]) == ["a", "z"]
    assert list(sorted_data({"a": 1, "b": 2}, scores={"b": 0})) == ["b", "a"]
    assert sorted_data(["a", "b"], scores={"b": 0}) == ["b", "a"]
    assert sorted_data([2, 10]) == [10, 2]
    assert sorted_data(3) == 3
