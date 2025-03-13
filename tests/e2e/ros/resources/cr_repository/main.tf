variable "tag_immutability" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the repository is immutable. Only takes effect when InstanceId is specified."
    },
    "Label": {
      "en": "TagImmutability",
      "zh-cn": "镜像仓库绑定的标签是否固定"
    }
  }
  EOT
}

variable "repo_namespace" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the namespace to which the repository belongs."
    },
    "Label": {
      "en": "RepoNamespace",
      "zh-cn": "镜像仓库命名空间"
    },
    "MinLength": 2,
    "MaxLength": 30
  }
  EOT
}

variable "repo_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "PUBLIC",
      "PRIVATE"
    ],
    "Description": {
      "en": "The type of the repository. Valid values: PUBLIC, PRIVATE."
    },
    "Label": {
      "en": "RepoType",
      "zh-cn": "镜像仓库类型"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the enterprise edition instance which repository belongs to. If not provided, will use personal edition instance as default."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "repo_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the repository."
    },
    "Label": {
      "en": "RepoName",
      "zh-cn": "镜像仓库名称"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "summary" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The summary of the repository."
    },
    "Label": {
      "en": "Summary",
      "zh-cn": "镜像仓库摘要"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "detail" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the repository."
    },
    "Label": {
      "en": "Detail",
      "zh-cn": "镜像仓库详细描述"
    },
    "MaxLength": 2000
  }
  EOT
}

variable "repo_source" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IsAutoBuild": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable automatic construction"
          },
          "Required": true,
          "Default": true
        },
        "SourceRepoName": {
          "Type": "String",
          "Description": {
            "en": "Source code warehouse name"
          },
          "Required": true
        },
        "SourceRepoNamespace": {
          "Type": "String",
          "Description": {
            "en": "Source code repository namespace"
          },
          "Required": true
        },
        "IsOversea": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable overseas construction"
          },
          "Required": true
        },
        "SourceRepoType": {
          "Type": "String",
          "Description": {
            "en": "code source type. Allow values: \nCODE, GITHUB, GITLAB, BITBUCKET. Enterprise Edition additional support CODEUP and GITEE"
          },
          "AllowedValues": [
            "CODE",
            "GITHUB",
            "GITLAB",
            "BITBUCKET",
            "CODEUP",
            "GITEE"
          ],
          "Required": true
        },
        "IsDisableCache": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to disable Cache at build time"
          },
          "Required": true,
          "Default": false
        }
      }
    },
    "Description": {
      "en": "Code Source message. "
    },
    "Label": {
      "en": "RepoSource",
      "zh-cn": "镜像仓库绑定的源代码仓库及构建设置"
    }
  }
  EOT
}

resource "alicloud_cr_repo" "repository" {
  namespace = var.repo_namespace
  repo_type = var.repo_type
  name      = var.repo_name
  summary   = var.summary
  detail    = var.detail
}

output "repo_namespace" {
  value       = alicloud_cr_repo.repository.namespace
  description = "The name of the namespace to which the repository belongs."
}

output "repo_type" {
  value       = alicloud_cr_repo.repository.repo_type
  description = "The type of the repository."
}

output "instance_id" {
  // Could not transform ROS Attribute InstanceId to Terraform attribute.
  value       = null
  description = "The ID of the enterprise edition instance which repository belongs to."
}

output "repo_name" {
  value       = alicloud_cr_repo.repository.name
  description = "The name of the repository."
}

output "repo_id" {
  // Could not transform ROS Attribute RepoId to Terraform attribute.
  value       = null
  description = "The repository ID."
}

