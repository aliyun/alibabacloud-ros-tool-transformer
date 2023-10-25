
resource "alicloud_log_project" "example" {
  name        = "terraform-example"
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

resource "alicloud_log_alert" "example-2" {
  version           = "2.0"
  type              = "default"
  project_name      = alicloud_log_project.example.name
  alert_name        = "example-alert"
  alert_displayname = "example-alert"
  mute_until        = "1632486684"
  no_data_fire      = "false"
  no_data_severity  = 8
  send_resolved     = true
  auto_annotation   = true
  dashboard         = "example-dashboard"
  schedule {
    type            = "FixedRate"
    interval        = "5m"
    hour            = 0
    day_of_week     = 0
    delay           = 0
    run_immediately = false
  }
  query_list {
    store          = alicloud_log_store.example.name
    store_type     = "log"
    project        = alicloud_log_project.example.name
    region         = "cn-heyuan"
    chart_title    = "chart_title"
    start          = "-60s"
    end            = "20s"
    query          = "* AND aliyun | select count(1) as cnt"
    power_sql_mode = "auto"
  }
  query_list {
    store          = alicloud_log_store.example.name
    store_type     = "log"
    project        = alicloud_log_project.example.name
    region         = "cn-heyuan"
    chart_title    = "chart_title"
    start          = "-60s"
    end            = "20s"
    query          = "error | select count(1) as error_cnt"
    power_sql_mode = "enable"
  }
  labels {
    key   = "env"
    value = "test"
  }
  annotations {
    key   = "title"
    value = "alert title"
  }
  annotations {
    key   = "desc"
    value = "alert desc"
  }
  annotations {
    key   = "test_key"
    value = "test value"
  }
  group_configuration {
    type   = "custom"
    fields = ["cnt"]
  }
  policy_configuration {
    alert_policy_id  = "sls.bultin"
    action_policy_id = "sls_test_action"
    repeat_interval  = "4h"
  }
  severity_configurations {
    severity = 8
    eval_condition = {
      condition       = "cnt > 3"
      count_condition = "__count__ > 3"
    }
  }
  severity_configurations {
    severity = 6
    eval_condition = {
      condition       = ""
      count_condition = "__count__ > 0"
    }
  }
  severity_configurations {
    severity = 2
    eval_condition = {
      condition       = ""
      count_condition = ""
    }
  }
  join_configurations {
    type      = "cross_join"
    condition = ""
  }
}