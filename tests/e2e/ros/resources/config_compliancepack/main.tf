variable "config_rule_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ConfigRuleId": {
          "Type": "String",
          "Description": {
            "en": "Rule ID"
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Compliance Package rule ID list"
    },
    "Label": {
      "en": "ConfigRuleIds",
      "zh-cn": "规则ID列表"
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
      "en": "Description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "合规包描述信息"
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
      "en": "Compliance Package Name"
    },
    "Label": {
      "en": "CompliancePackName",
      "zh-cn": "合规包名称"
    }
  }
  EOT
}

variable "config_rules" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "ConfigRules",
      "zh-cn": "配置规则列表"
    }
  }
  EOT
}

variable "compliance_pack_template_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Compliance Package Template Id"
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
      "1",
      "2",
      "3"
    ],
    "Description": {
      "en": "Ris Level, valid values: 1 | 2 | 3"
    },
    "Label": {
      "en": "RiskLevel",
      "zh-cn": "风险等级"
    }
  }
  EOT
}

resource "alicloud_config_compliance_pack" "config_compliance_pack" {
  config_rule_ids             = var.config_rule_ids
  description                 = var.description
  compliance_pack_name        = var.compliance_pack_name
  config_rules                = var.config_rules
  compliance_pack_template_id = var.compliance_pack_template_id
  risk_level                  = var.risk_level
}

output "compliance_pack_id" {
  value       = alicloud_config_compliance_pack.config_compliance_pack.id
  description = "Compliance Package ID"
}

output "description" {
  value       = alicloud_config_compliance_pack.config_compliance_pack.description
  description = "Description"
}

output "compliance_pack_name" {
  value       = alicloud_config_compliance_pack.config_compliance_pack.compliance_pack_name
  description = "Compliance Package Name"
}

output "account_id" {
  // Could not transform ROS Attribute AccountId to Terraform attribute.
  value       = null
  description = "Aliyun User Id"
}

output "compliance_pack_template_id" {
  value       = alicloud_config_compliance_pack.config_compliance_pack.compliance_pack_template_id
  description = "Compliance Package Template Id"
}

output "risk_level" {
  value       = alicloud_config_compliance_pack.config_compliance_pack.risk_level
  description = "Ris Level, valid values: 1 | 2 | 3"
}

