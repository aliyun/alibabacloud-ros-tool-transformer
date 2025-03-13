variable "tag_key_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule monitors the tag key, only applies to rules created based on managed rules"
    },
    "Label": {
      "en": "TagKeyScope",
      "zh-cn": "规则的标签键"
    }
  }
  EOT
}

variable "tag_value_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule monitors the tag value, only applies to rules created based on managed rules"
    },
    "Label": {
      "en": "TagValueScope",
      "zh-cn": "规则的标签值"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the rule"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "规则的描述信息"
    }
  }
  EOT
}

variable "exclude_resource_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule monitors excluded resource IDs, multiple of which are separated by commas, only applies to rules created based on managed rules, , custom rule this field is empty"
    },
    "Label": {
      "en": "ExcludeResourceIdsScope",
      "zh-cn": "规则排除的资源ID"
    }
  }
  EOT
}

variable "tag_key_logic_scope" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "TagKeyLogicScope",
      "zh-cn": "规则的标签键逻辑类型"
    }
  }
  EOT
}

variable "source_owner" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether you or Alibaba Cloud owns and manages the rule. Valid values:  CUSTOM_FC: The rule is a custom rule and you own the rule. ALIYUN: The rule is a managed rule and Alibaba Cloud owns the rule"
    },
    "Label": {
      "en": "SourceOwner",
      "zh-cn": "规则来源的归属"
    }
  }
  EOT
}

variable "source_identifier" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The identifier of the rule.  For a managed rule, the value is the name of the managed rule. For a custom rule, the value is the ARN of the custom rule"
    },
    "Label": {
      "en": "SourceIdentifier",
      "zh-cn": "规则标识或函数ARN"
    }
  }
  EOT
}

variable "maximum_execution_frequency" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The frequency of the compliance evaluations. Valid values:  One_Hour Three_Hours Six_Hours Twelve_Hours TwentyFour_Hours"
    },
    "Label": {
      "en": "MaximumExecutionFrequency",
      "zh-cn": "规则执行周期"
    }
  }
  EOT
}

variable "region_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule monitors region IDs, separated by commas, only applies to rules created based on managed rules"
    },
    "Label": {
      "en": "RegionIdsScope",
      "zh-cn": "规则的地域ID"
    }
  }
  EOT
}

variable "config_rule_trigger_types" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The trigger type of the rule. Valid values:  ConfigurationItemChangeNotification: The rule is triggered upon configuration changes. ScheduledNotification: The rule is triggered as scheduled."
    },
    "Label": {
      "en": "ConfigRuleTriggerTypes",
      "zh-cn": "规则的触发器类型"
    }
  }
  EOT
}

variable "resource_group_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The rule monitors resource group IDs, separated by commas, only applies to rules created based on managed rules"
    },
    "Label": {
      "en": "ResourceGroupIdsScope",
      "zh-cn": "规则的资源组ID"
    }
  }
  EOT
}

variable "risk_level" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The risk level of the resources that are not compliant with the rule. Valid values:  1: critical 2: warning 3: info"
    },
    "Label": {
      "en": "RiskLevel",
      "zh-cn": "风险等级"
    }
  }
  EOT
}

variable "resource_types_scope" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The type of the resources to be evaluated against the rule"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The types of the resources to be evaluated against the rule"
    },
    "Label": {
      "en": "ResourceTypesScope",
      "zh-cn": "需要根据规则评估的资源类型"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "规则名称"
    }
  }
  EOT
}

variable "input_parameters" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The settings of the input parameters for the rule"
    },
    "Label": {
      "en": "InputParameters",
      "zh-cn": "规则入参"
    }
  }
  EOT
}

resource "alicloud_config_rule" "config_rule" {
  tag_key_scope               = var.tag_key_scope
  tag_value_scope             = var.tag_value_scope
  description                 = var.description
  exclude_resource_ids_scope  = var.exclude_resource_ids_scope
  source_owner                = var.source_owner
  source_identifier           = var.source_identifier
  maximum_execution_frequency = var.maximum_execution_frequency
  region_ids_scope            = var.region_ids_scope
  config_rule_trigger_types   = var.config_rule_trigger_types
  resource_group_ids_scope    = var.resource_group_ids_scope
  risk_level                  = var.risk_level
  resource_types_scope        = var.resource_types_scope
  rule_name                   = var.rule_name
  input_parameters            = var.input_parameters
}

output "tag_key_scope" {
  value       = alicloud_config_rule.config_rule.tag_key_scope
  description = "The rule monitors the tag key, only applies to rules created based on managed rules"
}

output "tag_value_scope" {
  value       = alicloud_config_rule.config_rule.tag_value_scope
  description = "The rule monitors the tag value, only applies to rules created based on managed rules"
}

output "description" {
  value       = alicloud_config_rule.config_rule.description
  description = "The description of the rule"
}

output "exclude_resource_ids_scope" {
  value       = alicloud_config_rule.config_rule.exclude_resource_ids_scope
  description = "The rule monitors excluded resource IDs, multiple of which are separated by commas, only applies to rules created based on managed rules, , custom rule this field is empty"
}

output "source_owner" {
  value       = alicloud_config_rule.config_rule.source_owner
  description = "Specifies whether you or Alibaba Cloud owns and manages the rule. Valid values:  CUSTOM_FC: The rule is a custom rule and you own the rule. ALIYUN: The rule is a managed rule and Alibaba Cloud owns the rule"
}

output "source_identifier" {
  value       = alicloud_config_rule.config_rule.source_identifier
  description = "The identifier of the rule.  For a managed rule, the value is the name of the managed rule. For a custom rule, the value is the ARN of the custom rule"
}

output "maximum_execution_frequency" {
  value       = alicloud_config_rule.config_rule.maximum_execution_frequency
  description = "The frequency of the compliance evaluations. Valid values:  One_Hour Three_Hours Six_Hours Twelve_Hours TwentyFour_Hours"
}

output "config_rule_id" {
  value       = alicloud_config_rule.config_rule.config_rule_id
  description = "The ID of the rule"
}

output "event_source" {
  value       = alicloud_config_rule.config_rule.event_source
  description = "The event source of the rule."
}

output "config_rule_arn" {
  value       = alicloud_config_rule.config_rule.config_rule_arn
  description = "config rule arn"
}

output "region_ids_scope" {
  value       = alicloud_config_rule.config_rule.region_ids_scope
  description = "The rule monitors region IDs, separated by commas, only applies to rules created based on managed rules"
}

output "config_rule_trigger_types" {
  value       = alicloud_config_rule.config_rule.config_rule_trigger_types
  description = "The trigger type of the rule. Valid values:  ConfigurationItemChangeNotification: The rule is triggered upon configuration changes. ScheduledNotification: The rule is triggered as scheduled."
}

output "resource_group_ids_scope" {
  value       = alicloud_config_rule.config_rule.resource_group_ids_scope
  description = "The rule monitors resource group IDs, separated by commas, only applies to rules created based on managed rules"
}

output "risk_level" {
  value       = alicloud_config_rule.config_rule.risk_level
  description = "The risk level of the resources that are not compliant with the rule. Valid values:  1: critical 2: warning 3: info"
}

output "resource_types_scope" {
  value       = alicloud_config_rule.config_rule.resource_types_scope
  description = "The types of the resources to be evaluated against the rule"
}

output "rule_name" {
  value       = alicloud_config_rule.config_rule.rule_name
  description = "The name of the rule."
}

output "input_parameters" {
  value       = alicloud_config_rule.config_rule.input_parameters
  description = "The settings of the input parameters for the rule"
}

