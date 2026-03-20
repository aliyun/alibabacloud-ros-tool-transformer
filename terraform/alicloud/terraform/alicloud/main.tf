resource "alicloud_vpc" "vpc" {
  vpc_name    = length(var.input_string)
  description = length("SGVsbG8gV29ybGQ=")
}

