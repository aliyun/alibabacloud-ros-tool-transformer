variable "tag_key_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Compliance packages only take effect on resources bound to the specified tag key."
    },
    "Label": {
      "en": "TagKeyScope",
      "zh-cn": "合规包仅对绑定指定标签键的资源生效"
    }
  }
  EOT
}

variable "tag_value_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Compliance packages only take effect on resources bound to specified tag key-value pairs.TagValueScope needs to be used in conjunction with TagKeyScope."
    },
    "Label": {
      "en": "TagValueScope",
      "zh-cn": "合规包仅对绑定指定标签键值对的资源生效"
    }
  }
  EOT
}

variable "exclude_resource_group_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The compliance package is invalid for the specified resource group ID.",
      "zh-cn": "规则对指定资源组 ID 中的资源无效，即不对该资源组内的资源评估。"
    },
    "Label": {
      "en": "ExcludeResourceGroupIdsScope",
      "zh-cn": "规则对指定资源组 ID 中的资源无效"
    }
  }
  EOT
}

variable "description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of compliance pack."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "合规包描述"
    }
  }
  EOT
}

variable "exclude_resource_ids_scope" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The resource id."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The compliance package is invalid for the specified resource ID, that is, no evaluation is performed on the resource.",
      "zh-cn": "合规包对指定资源ID无效，即不对该资源执行评估。"
    },
    "Label": {
      "en": "ExcludeResourceIdsScope",
      "zh-cn": "合规包对指定资源ID无效"
    }
  }
  EOT
}

variable "resource_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The compliance package only takes effect on the specified resource ID."
    },
    "Label": {
      "en": "ResourceIdsScope",
      "zh-cn": "规则对指定资源 ID 生效"
    }
  }
  EOT
}

variable "template_content" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Template information used to generate compliance packages.\nNote: Either this parameter or ConfigRules must be set."
    },
    "Label": {
      "en": "TemplateContent",
      "zh-cn": "用于生成合规包的模板信息"
    }
  }
  EOT
}

variable "config_rules" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "ConfigRuleId": {
              "Type": "String",
              "Description": {
                "en": "Rule ID. Configure auditing to add existing rules to the current compliance package.Choose one of ManagedRuleIdentifier and ConfigRuleId. When both parameters are set, ConfigRuleId is the correct one."
              },
              "Required": false
            },
            "Description": {
              "AssociationProperty": "TextArea",
              "Type": "String",
              "Description": {
                "en": "The description of config rule."
              },
              "Required": false
            },
            "ConfigRuleName": {
              "Type": "String",
              "Description": {
                "en": "The name of config rule."
              },
              "Required": false
            },
            "ManagedRuleIdentifier": {
              "Type": "String",
              "Description": {
                "en": "Managed rule ID. Configure auditing to automatically create a rule based on the managed rule ID and add the rule to the current compliance package.Choose one of ManagedRuleIdentifier and ConfigRuleId. When both parameters are set, ConfigRuleId is the correct one."
              },
              "Required": false
            },
            "RiskLevel": {
              "Type": "Number",
              "Description": {
                "en": "Rule risk level. Value:\n1: High risk.\n2: Medium risk.\n3: Low risk."
              },
              "AllowedValues": [
                1,
                2,
                3
              ],
              "Required": true
            },
            "ConfigRuleParameters": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ParameterValue": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of parameter."
                    },
                    "Required": true
                  },
                  "ParameterName": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of parameter."
                    },
                    "Required": true
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "List of rules in the compliance package.\nNote: Either this parameter or TemplateContent must be set."
    },
    "Label": {
      "en": "ConfigRules",
      "zh-cn": "合规包中的规则列表"
    },
    "MinLength": 1
  }
  EOT
}

variable "default_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the rule supports quick activation. Value:\ntrue: This rule will be enabled when the compliance package is quickly enabled.\nfalse (default): disable"
    },
    "Label": {
      "en": "DefaultEnable",
      "zh-cn": "规则是否支持快速启用"
    }
  }
  EOT
}

variable "exclude_region_ids_scope" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The compliance package is invalid for the specified region ID.",
      "zh-cn": "规则对指定地域内资源无效，即不对该地域内资源执行评估。"
    },
    "Label": {
      "en": "ExcludeRegionIdsScope",
      "zh-cn": "规则对指定地域内资源无效"
    }
  }
  EOT
}

variable "compliance_pack_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Compliance package name."
    },
    "Label": {
      "en": "CompliancePackName",
      "zh-cn": "合规包名称"
    }
  }
  EOT
}

variable "region_ids_scope" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The region id."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The compliance package only takes effect for resources in the specified region ID."
    },
    "Label": {
      "en": "RegionIdsScope",
      "zh-cn": "合规包仅对指定地域ID中的资源生效"
    }
  }
  EOT
}

variable "resource_group_ids_scope" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Resource group id."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The compliance package only takes effect on resources in the specified resource group ID."
    },
    "Label": {
      "en": "ResourceGroupIdsScope",
      "zh-cn": "合规包仅对指定资源组ID中的资源生效"
    }
  }
  EOT
}

variable "compliance_pack_template_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Compliance package template ID."
    },
    "Label": {
      "en": "CompliancePackTemplateId",
      "zh-cn": "合规包模板ID"
    }
  }
  EOT
}

variable "risk_level" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      1,
      2,
      3
    ],
    "Description": {
      "en": "Compliance package risk level. Value:\n1: High risk.\n2: Medium risk.\n3: Low risk."
    },
    "Label": {
      "en": "RiskLevel",
      "zh-cn": "合规包风险等级"
    }
  }
  EOT
}

variable "aggregator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Aggregator id."
    },
    "Label": {
      "en": "AggregatorId",
      "zh-cn": "账号组ID"
    }
  }
  EOT
}

resource "alicloud_config_aggregate_compliance_pack" "aggregate_compliance_pack" {
  description                 = var.description
  config_rules                = var.config_rules
  compliance_pack_template_id = var.compliance_pack_template_id
  risk_level                  = var.risk_level
  aggregator_id               = var.aggregator_id
}

output "compliance_pack_id" {
  // Could not transform ROS Attribute CompliancePackId to Terraform attribute.
  value       = null
  description = "The ID of the compliance pack id. "
}

