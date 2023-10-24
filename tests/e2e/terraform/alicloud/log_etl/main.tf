resource "alicloud_log_project" "example" {
  name        = "terraform-example-01"
  description = "terraform-example"
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = "example-store"
  retention_period      = 3650
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_store" "example2" {
  project               = alicloud_log_project.example.name
  name                  = "example-store2"
  retention_period      = 3650
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_store" "example3" {
  project               = alicloud_log_project.example.name
  name                  = "example-store3"
  retention_period      = 3650
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_etl" "example" {
  etl_name          = "terraform-example"
  project           = alicloud_log_project.example.name
  display_name      = "terraform-example"
  description       = "terraform-example"
  access_key_id     = "access_key_id"
  access_key_secret = "access_key_secret"
  script            = "e_set('new','key')"
  logstore          = alicloud_log_store.example.name
  etl_sinks {
    name              = "target_name"
    access_key_id     = "example2_access_key_id"
    access_key_secret = "example2_access_key_secret"
    endpoint          = "cn-hangzhou.log.aliyuncs.com"
    project           = alicloud_log_project.example.name
    logstore          = alicloud_log_store.example2.name
  }
  etl_sinks {
    name              = "target_name2"
    access_key_id     = "example3_access_key_id"
    access_key_secret = "example3_access_key_secret"
    endpoint          = "cn-hangzhou.log.aliyuncs.com"
    project           = alicloud_log_project.example.name
    logstore          = alicloud_log_store.example3.name
  }
}