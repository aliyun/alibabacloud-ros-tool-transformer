variable "logtail_config_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logtail config name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "Label": {
      "en": "LogtailConfigName",
      "zh-cn": "Logtail配置名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "logstore_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logstore name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "LogstoreName",
      "zh-cn": "日志库名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "日志项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "raw_config_data" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The format is the same as the response of SLS API GetConfig.\nEither CloneFrom or RawConfigData must be specified. If CloneFrom and RawConfigData are both specified, logtail config data will be merged from both with RawConfigData first.\nconfigName, outputType, outputDetail in data will be ignored.For example:\n{\n    \"configName\": \"test-logtail-config\",\n    \"createTime\": 1574843554,\n    \"inputDetail\": {\n        \"acceptNoEnoughKeys\": false,\n        \"adjustTimezone\": false,\n        \"advanced\": {\n            \"force_multiconfig\": false\n        },\n        \"autoExtend\": true,\n        \"delayAlarmBytes\": 0,\n        \"delaySkipBytes\": 0,\n        \"discardNonUtf8\": false,\n        \"discardUnmatch\": false,\n        \"dockerExcludeEnv\": {},\n        \"dockerExcludeLabel\": {},\n        \"dockerFile\": false,\n        \"dockerIncludeEnv\": {},\n        \"dockerIncludeLabel\": {},\n        \"enableRawLog\": false,\n        \"enableTag\": false,\n        \"fileEncoding\": \"utf8\",\n        \"filePattern\": \"test.log*\",\n        \"filterKey\": [],\n        \"filterRegex\": [],\n        \"key\": [\n            \"time\",\n            \"logger\",\n            \"level\",\n            \"request_id\",\n            \"user_id\",\n            \"region_id\",\n            \"content\"\n        ],\n        \"localStorage\": true,\n        \"logPath\": \"/var/log/test\",\n        \"logTimezone\": \"\",\n        \"logType\": \"delimiter_log\",\n        \"maxDepth\": 100,\n        \"maxSendRate\": -1,\n        \"mergeType\": \"topic\",\n        \"preserve\": true,\n        \"preserveDepth\": 1,\n        \"priority\": 0,\n        \"quote\": \"\\u0001\",\n        \"sendRateExpire\": 0,\n        \"sensitive_keys\": [],\n        \"separator\": \",,,\",\n        \"shardHashKey\": [],\n        \"tailExisted\": false,\n        \"timeFormat\": \"\",\n        \"timeKey\": \"\",\n        \"topicFormat\": \"none\"\n    },\n    \"inputType\": \"file\",\n    \"lastModifyTime\": 1574843554,\n    \"logSample\": \"2019-11-27 10:48:23,160,,,MAIN,,,INFO,,,98DCC51D-BE5D-49C7-B3FD-37B2BAEFB296,,,123456789,,,cn-hangzhou,,,this is a simple test.\",\n    \"outputDetail\": {\n        \"endpoint\": \"cn-hangzhou-intranet.log.aliyuncs.com\",\n        \"logstoreName\": \"test-logstore\",\n        \"region\": \"cn-hangzhou\"\n    },\n    \"outputType\": \"LogService\"\n}"
    },
    "Label": {
      "en": "RawConfigData",
      "zh-cn": "原始配置数据"
    }
  }
  EOT
}

variable "clone_from" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "LogtailConfigName": {
          "Type": "String",
          "Description": {
            "en": "Logtail config name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
          },
          "Required": true,
          "MinLength": 3,
          "MaxLength": 63
        },
        "ProjectName": {
          "Type": "String",
          "Description": {
            "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
          },
          "Required": true,
          "AllowedPattern": "^[a-zA-Z0-9_-]+$",
          "MinLength": 3,
          "MaxLength": 63
        }
      }
    },
    "Description": {
      "en": "Clone logtail config data from existing logtail config.\nEither CloneFrom or RawConfigData must be specified. If CloneFrom and RawConfigData are both specified, logtail config data will be merged from both with RawConfigData first."
    },
    "Label": {
      "en": "CloneFrom",
      "zh-cn": "克隆其他日志项目的LogtailConfig"
    }
  }
  EOT
}

resource "alicloud_logtail_config" "logtail_config" {}

output "logtail_config_name" {
  // Could not transform ROS Attribute LogtailConfigName to Terraform attribute.
  value       = null
  description = "Logtail config name."
}

output "endpoint" {
  // Could not transform ROS Attribute Endpoint to Terraform attribute.
  value       = null
  description = "Endpoint address."
}

output "applied_machine_groups" {
  // Could not transform ROS Attribute AppliedMachineGroups to Terraform attribute.
  value       = null
  description = "Applied machine groups."
}

