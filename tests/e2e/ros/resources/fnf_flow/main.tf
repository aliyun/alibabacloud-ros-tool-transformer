variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Create a description of the flow."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "创建流程的描述"
    }
  }
  EOT
}

variable "request_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specified Request ID for this request. If not specified, our system will help you generate a random one."
    },
    "Label": {
      "en": "RequestId",
      "zh-cn": "请求ID"
    }
  }
  EOT
}

variable "definition" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The definition of the created flow following the FDL syntax standard.",
      "zh-cn": "创建的流程的定义，例如：version: v1beta1\\ntype: flow\\nsteps: \\n - type: pass\\n name: mypass。"
    },
    "Label": {
      "en": "Definition",
      "zh-cn": "创建的流程的定义"
    }
  }
  EOT
}

variable "execution_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The execution mode of the flow."
    },
    "AllowedValues": [
      "Express",
      "Standard"
    ],
    "Label": {
      "en": "ExecutionMode",
      "zh-cn": "执行模式"
    }
  }
  EOT
}

variable "external_storage_location" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The external storage location for the flow."
    },
    "Label": {
      "en": "ExternalStorageLocation",
      "zh-cn": "外部存储位置"
    }
  }
  EOT
}

variable "role_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Optional parameter, the resource descriptor information required for the execution of the flow, used to perform the assume role during FnF execution."
    },
    "Label": {
      "en": "RoleArn",
      "zh-cn": "流程执行所需的资源描述符信息"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the flow created. This name is unique under the account."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "创建的流程名称"
    }
  }
  EOT
}

resource "alicloud_fnf_flow" "flow" {
  description = var.description
  definition  = var.definition
  role_arn    = var.role_arn
  name        = var.name
}

output "created_time" {
  // Could not transform ROS Attribute CreatedTime to Terraform attribute.
  value       = null
  description = "Flow creation time."
}

output "last_modified_time" {
  value       = alicloud_fnf_flow.flow.last_modified_time
  description = "The most recently modified time of the flow."
}

output "id" {
  value       = alicloud_fnf_flow.flow.flow_id
  description = "The unique ID of the flow."
}

output "name" {
  value       = alicloud_fnf_flow.flow.id
  description = "The name of the flow created."
}

