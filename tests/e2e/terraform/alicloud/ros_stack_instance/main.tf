
resource "alicloud_ros_stack_group" "example" {
  stack_group_name = "terraform-example"
  template_body    = "{\"ROSTemplateFormatVersion\":\"2015-09-01\", \"Parameters\": {\"VpcName\": {\"Type\": \"String\"},\"InstanceType\": {\"Type\": \"String\"}}}"
  description      = "test for stack groups"
  parameters {
    parameter_key   = "VpcName"
    parameter_value = "VpcName"
  }
  parameters {
    parameter_key   = "InstanceType"
    parameter_value = "InstanceType"
  }
}

resource "alicloud_ros_stack_instance" "example" {
  stack_group_name          = alicloud_ros_stack_group.example.stack_group_name
  stack_instance_account_id = 123456789
  stack_instance_region_id  = "cn-beijing"
  operation_preferences     = "{\"FailureToleranceCount\": 1, \"MaxConcurrentCount\": 2}"
  parameter_overrides {
    parameter_value = "VpcName"
    parameter_key   = "VpcName"
  }
}