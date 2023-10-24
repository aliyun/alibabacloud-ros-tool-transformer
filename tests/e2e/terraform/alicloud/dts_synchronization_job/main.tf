variable "name" {
  default = "terraform-example"
}

resource "alicloud_dts_synchronization_job" "example" {
  dts_instance_id                    = "fake-id"
  dts_job_name                       = var.name
  source_endpoint_instance_type      = "RDS"
  source_endpoint_instance_id        = "fake-id"
  source_endpoint_engine_name        = "MySQL"
  source_endpoint_region             = "cn-beijing"
  source_endpoint_user_name          = "fake-name"
  source_endpoint_password           = "fake-password"
  destination_endpoint_instance_type = "RDS"
  destination_endpoint_instance_id   = "fake-id2"
  destination_endpoint_engine_name   = "MySQL"
  destination_endpoint_region        = "cn-beijing"
  destination_endpoint_user_name     = "fake-name2"
  destination_endpoint_password      = "fake-password2"
  db_list = jsonencode(
    {
      "source_table" = { name = "des_table", all = true }
    }
  )
  structure_initialization = true
  data_initialization      = true
  data_synchronization     = true
  status                   = "Synchronizing"
}