resource "alicloud_ots_search_index" "default" {
  instance_name = "example"
  table_name    = "example_table"
  index_name    = "example_index"
  time_to_live  = -1
  schema {
    field_schema {
      field_name = "col1"
      field_type = "Text"
      is_array   = false
      index      = true
      analyzer   = "Split"
      store      = true
    }
    field_schema {
      field_name          = "col2"
      field_type          = "Long"
      enable_sort_and_agg = true
    }
    field_schema {
      field_name = "pk1"
      field_type = "Long"
    }
    field_schema {
      field_name = "pk2"
      field_type = "Text"
    }

    index_setting {
      routing_fields = ["pk1", "pk2"]
    }

    index_sort {
      sorter {
        sorter_type = "PrimaryKeySort"
        order       = "Asc"
      }
      sorter {
        sorter_type = "FieldSort"
        order       = "Desc"
        field_name  = "col2"
        mode        = "Max"
      }
    }
  }
}