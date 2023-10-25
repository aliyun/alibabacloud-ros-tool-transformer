variable "name" {
  default = "tf-example"
}
resource "alicloud_cr_namespace" "example" {
  name               = var.name
  auto_create        = false
  default_visibility = "PUBLIC"
}

resource "alicloud_cr_repo" "example" {
  namespace = alicloud_cr_namespace.example.name
  name      = var.name
  summary   = "this is summary of my new repo"
  repo_type = "PUBLIC"
  detail    = "this is a public repo"
}

output "id" {
  value = alicloud_cr_repo.example.id
}