variable "function_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "ParentId": {
              "Type": "String",
              "Description": {
                "en": "Rule condition ID."
              },
              "Required": false,
              "Label": {
                "zh-cn": "规则条件ID"
              }
            },
            "FunctionName": {
              "Type": "String",
              "Description": {
                "en": "Function name."
              },
              "Required": true,
              "Label": {
                "zh-cn": "功能名称"
              }
            },
            "FunctionArgs": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ArgValue": {
                    "Type": "String",
                    "Description": {
                      "en": "Arg value."
                    },
                    "Required": true,
                    "Label": {
                      "zh-cn": "参数值"
                    }
                  },
                  "ArgName": {
                    "Type": "String",
                    "Description": {
                      "en": "Arg name."
                    },
                    "Required": true,
                    "Label": {
                      "zh-cn": "参数名称"
                    }
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Function args."
              },
              "Required": true,
              "Label": {
                "zh-cn": "功能参数"
              }
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Function list. This property is required."
    },
    "Label": {
      "en": "Function List",
      "zh-cn": "功能列表"
    }
  }
  EOT
}

variable "domain_names" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Your accelerated domain name, separated by commas in English."
    },
    "Label": {
      "en": "DomainNames",
      "zh-cn": "加速域名"
    }
  }
  EOT
}

resource "alicloud_cdn_domain_config" "domain_config" {
  domain_name = var.domain_names
}

