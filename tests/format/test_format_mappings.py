from rostran.core.mappings import Mappings

tpl_mappings = {
    "RegionMap2": {
        "cn-hangzhou": {"32": "m-32", "64": "m-64"},
        "cn-beijing": {"64": "m-32", "32": "m-64"},
    },
    "RegionMap1": {
        "cn-hangzhou": {"32": "m-32", "64": "m-64"},
        "cn-beijing": {"64": "m-64", "32": "m-32"},
    },
}


def test_format_mappings():
    mappings = Mappings.initialize(tpl_mappings)
    data = mappings.as_dict(format=True)

    # Mappings key order
    assert list(data) == ["RegionMap1", "RegionMap2"]

    # Mappings value key order
    for name in ("RegionMap1", "RegionMap2"):
        region_map = data[name]
        assert list(region_map) == ["cn-beijing", "cn-hangzhou"]

        for region in ("cn-hangzhou", "cn-beijing"):
            region_value = region_map[region]
            assert list(region_value) == ["32", "64"]
