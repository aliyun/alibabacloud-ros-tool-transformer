variable "comment" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The comment of project."
    },
    "Label": {
      "en": "Comment",
      "zh-cn": "描述信息"
    },
    "MaxLength": 1024
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the project. Length [3, 32]. Beginning with characters, only characters, numbers and _ are allowed."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "项目名称"
    },
    "MinLength": 3,
    "MaxLength": 32
  }
  EOT
}

resource "alicloud_datahub_project" "project" {
  comment = var.comment
  name    = var.project_name
}

output "project_name" {
  value       = alicloud_datahub_project.project.id
  description = "Project name"
}

