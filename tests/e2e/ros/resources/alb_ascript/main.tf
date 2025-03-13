variable "script_content" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The content of the AScript rule."
    },
    "Label": {
      "en": "ScriptContent",
      "zh-cn": "可编程脚本内容"
    }
  }
  EOT
}

variable "ascript_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the AScript rule.\nThe name must be 2 to 128 character in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). It must start with a letter."
    },
    "AllowedPattern": "^[a-zA-Z][.-_a-zA-Z0-9]{1,127}$",
    "Label": {
      "en": "AScriptName",
      "zh-cn": "可编程脚本名称"
    }
  }
  EOT
}

variable "enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the AScript rule. Valid values:\ntrue\nfalse (default)"
    },
    "Label": {
      "en": "Enabled",
      "zh-cn": "是否启用可编程脚本"
    }
  }
  EOT
}

variable "ext_attribute_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the extended attributes of the AScript rule. Valid values:\ntrue\nfalse (default)"
    },
    "Label": {
      "en": "ExtAttributeEnabled",
      "zh-cn": "是否启用可编程脚本扩展属性"
    }
  }
  EOT
}

variable "ext_attributes" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AttributeKey": {
          "Type": "String",
          "Description": {
            "en": "The attribute name.\nSet the value to EsDebug, which specifies that if requests carry the _es_dbg parameter and the value is the specified key, the debugging header is enabled to output the execution result."
          },
          "Required": false
        },
        "AttributeValue": {
          "Type": "String",
          "Description": {
            "en": "The attribute value, which must be 1 to 128 characters in length, and can contain letters or digits."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 128
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The extended attributes."
    },
    "Label": {
      "en": "ExtAttributes",
      "zh-cn": "扩展属性"
    },
    "MaxLength": 20
  }
  EOT
}

variable "listener_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The listener ID."
    },
    "Label": {
      "en": "ListenerId",
      "zh-cn": "监听 ID"
    }
  }
  EOT
}

resource "alicloud_alb_ascript" "ascript" {
  script_content        = var.script_content
  enabled               = var.enabled
  ext_attribute_enabled = var.ext_attribute_enabled
  ext_attributes        = var.ext_attributes
  listener_id           = var.listener_id
}

output "ascript_id" {
  value       = alicloud_alb_ascript.ascript.id
  description = "The AScript rule ID."
}

