variable "project" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of project."
    },
    "Label": {
      "en": "Project",
      "zh-cn": "项目名称"
    }
  }
  EOT
}

variable "service_role" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Service role, which grants the IMM service the right to access other cloud resources (such as OSS). The default value is AliyunIMMDefaultRole."
    },
    "Label": {
      "en": "ServiceRole",
      "zh-cn": "服务角色"
    }
  }
  EOT
}

resource "alicloud_imm_project" "immproject" {
  project      = var.project
  service_role = var.service_role
}

output "project" {
  value       = alicloud_imm_project.immproject.id
  description = "The name of project."
}

