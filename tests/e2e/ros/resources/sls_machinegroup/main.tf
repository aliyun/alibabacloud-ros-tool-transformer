variable "machine_list" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The machine tag, the value is ip or userdefined-id."
    },
    "Label": {
      "en": "MachineList",
      "zh-cn": "机器IP或自定义标签"
    }
  }
  EOT
}

variable "group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the group name, the Project only. [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "机器组名称"
    }
  }
  EOT
}

variable "group_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "MachineGroup type, the value is empty or Armory"
    },
    "AllowedValues": [
      "",
      "Armory"
    ],
    "Label": {
      "en": "GroupType",
      "zh-cn": "机器组类型"
    }
  }
  EOT
}

variable "project_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "MachineGroup created in project."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "日志服务项目名称"
    }
  }
  EOT
}

variable "machine_identify_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Machine indentify type, the value is 'ip' or 'userdefined' "
    },
    "AllowedValues": [
      "ip",
      "userdefined"
    ],
    "Label": {
      "en": "MachineIdentifyType",
      "zh-cn": "机器识别类型"
    }
  }
  EOT
}

variable "group_attribute" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Group attribute, default is null. The object value is groupTopic and externalName"
    },
    "Label": {
      "en": "GroupAttribute",
      "zh-cn": "机器组的属性"
    }
  }
  EOT
}

resource "alicloud_log_machine_group" "machine_group" {
  name          = var.group_name
  project       = var.project_name
  identify_type = var.machine_identify_type
}

output "group_name" {
  value       = alicloud_log_machine_group.machine_group.name
  description = "GroupName of SLS."
}

output "project_name" {
  value       = alicloud_log_machine_group.machine_group.project
  description = "ProjectName of SLS."
}

