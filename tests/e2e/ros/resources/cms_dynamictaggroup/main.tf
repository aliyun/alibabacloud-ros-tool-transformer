variable "contact_group_list" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Alarm contacts."
    },
    "Label": {
      "en": "ContactGroupList",
      "zh-cn": "报警联系人"
    }
  }
  EOT
}

variable "match_express_filter_relation" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The relationship between the conditional expressions. Values are:\nand: the relationship between\nor: the relationship or the\nDescription currently supports only one combination of conditions, the follow-up Ali cloud will support a variety of combinations of conditions."
    },
    "AllowedValues": [
      "and",
      "or"
    ],
    "Label": {
      "en": "MatchExpressFilterRelation",
      "zh-cn": "条件表达式之间的关系"
    }
  }
  EOT
}

variable "enable_subscribe_event" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the event subscription is enabled. Values are\n:true: enable event subscription\nfalse: disable event subscription"
    },
    "Label": {
      "en": "EnableSubscribeEvent",
      "zh-cn": "是否启用事件订阅"
    }
  }
  EOT
}

variable "template_id_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Alarm template ID list.\nWhen the automatically generated application group synchronizes tags, it will generate alarm rules according to the specified alarm template."
    },
    "Label": {
      "en": "TemplateIdList",
      "zh-cn": "报警模板ID"
    },
    "MaxLength": 5
  }
  EOT
}

variable "tag_key" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Tag key."
    },
    "Label": {
      "en": "TagKey",
      "zh-cn": "标签键"
    }
  }
  EOT
}

variable "enable_install_agent" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable initial installation monitoring plug, not installed by default. Values are:\ntrue: enable installation\nNote If ECS generated instances group does not monitor plug-in installed will attempt to automatically install.\nfalse: disable installation"
    },
    "Label": {
      "en": "EnableInstallAgent",
      "zh-cn": "是否启用初始化安装监控插件"
    }
  }
  EOT
}

variable "match_express" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TagValue": {
          "Type": "String",
          "Description": {
            "en": "Tag value, used with TagValueMatchFunction."
          },
          "Required": true
        },
        "TagValueMatchFunction": {
          "Type": "String",
          "Description": {
            "en": "Matching labeled keys. Values are:\ncontains: contains\nstartWith: Prefix\nendWith: suffix\nnotContains: not included\nequals: equals\nall: All"
          },
          "AllowedValues": [
            "contains",
            "startWith",
            "endWith",
            "notContains",
            "equals",
            "all"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Matching list. Only supports one currently."
    },
    "Label": {
      "en": "MatchExpress",
      "zh-cn": "条件表达式"
    },
    "MaxLength": 1
  }
  EOT
}

resource "alicloud_cms_dynamic_tag_group" "dynamic_tag_group" {
  contact_group_list            = var.contact_group_list
  match_express_filter_relation = var.match_express_filter_relation
  template_id_list              = var.template_id_list
  tag_key                       = var.tag_key
  match_express                 = var.match_express
}

output "dynamic_tag_rule_id" {
  // Could not transform ROS Attribute DynamicTagRuleId to Terraform attribute.
  value       = null
  description = "Dynamic tag rule ID."
}

output "tag_key" {
  value       = alicloud_cms_dynamic_tag_group.dynamic_tag_group.tag_key
  description = "Tag key."
}

