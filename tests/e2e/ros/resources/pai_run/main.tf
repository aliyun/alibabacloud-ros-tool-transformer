variable "experiment_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Resource attribute field of the experiment ID to which Run belongs."
    },
    "Label": {
      "en": "ExperimentId",
      "zh-cn": "Run 关联的实验 ID"
    }
  }
  EOT
}

variable "source_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Attribute Resource field representing the source task ID."
    },
    "Label": {
      "en": "SourceId",
      "zh-cn": "Run 关联的 PAI Workload ID"
    }
  }
  EOT
}

variable "source_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Resource attribute fields representing the source type."
    },
    "Label": {
      "en": "SourceType",
      "zh-cn": "与 Run 关联的 PAI Workload 来源类型"
    }
  }
  EOT
}

variable "run_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Run."
    },
    "Label": {
      "en": "RunName",
      "zh-cn": "运行（Run）的名称"
    }
  }
  EOT
}

resource "alicloud_pai_workspace_run" "extension_resource" {
  experiment_id = var.experiment_id
  source_id     = var.source_id
  source_type   = var.source_type
  run_name      = var.run_name
}

output "create_time" {
  value       = alicloud_pai_workspace_run.extension_resource.create_time
  description = "The creation time of the Run."
}

