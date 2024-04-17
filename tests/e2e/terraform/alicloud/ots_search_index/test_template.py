import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ots_search_index.default": {
            "Type": "ALIYUN::OTS::SearchIndex",
            "Properties": {
                "IndexName": "example_index",
                "InstanceName": "example",
                "TableName": "example_table",
                "FieldSchemas": [
                    {
                        "Analyzer": "Split",
                        "FieldName": "col1",
                        "FieldType": "Text",
                        "Index": True,
                        "IsArray": False,
                        "Store": True,
                    },
                    {
                        "EnableSortAndAgg": True,
                        "FieldName": "col2",
                        "FieldType": "Long",
                    },
                    {"FieldName": "pk1", "FieldType": "Long"},
                    {"FieldName": "pk2", "FieldType": "Text"},
                ],
                "IndexSetting": {"RoutingFields": ["pk1", "pk2"]},
                "IndexSort": {
                    "Sorters": [
                        {"PrimaryKeySort": {"SortOrder": "Asc"}},
                        {
                            "FieldSort": {
                                "SortMode": "Max",
                                "SortOrder": "Desc",
                                "FieldName": "col2",
                            }
                        },
                    ]
                },
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
