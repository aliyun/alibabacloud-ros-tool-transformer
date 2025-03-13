variable "accelerator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the GA instance."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "全球加速实例 ID"
    }
  }
  EOT
}

variable "forwarding_rules" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "RuleActions": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "RuleActionType": {
                    "Type": "String",
                    "Description": {
                      "en": "The type of the forwarding action. Valid values:\n* ForwardGroup: forwards a request.\n* Redirect: redirects a request.\n* FixResponse: returns a fixed response. \n* Rewrite: rewrites a request. \n* AddHeader: adds a header to a request. \n* RemoveHeaderConfig: deletes the header from a request. \n"
                    },
                    "AllowedValues": [
                      "ForwardGroup",
                      "Redirect",
                      "FixResponseRewrite",
                      "AddHeaderRemoveHeaderConfig"
                    ],
                    "Required": true
                  },
                  "Order": {
                    "Type": "Number",
                    "Description": {
                      "en": "The forwarding priority."
                    },
                    "Required": true
                  },
                  "RuleActionValue": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of the forwarding action type. You must specify different JSON strings based on the RuleActionType parameter. A forwarding rule can contain only one forwarding action whose type is ForwardGroup, Redirect, or FixResponse. You must specify a forwarding action whose type is Rewrite, AddHeader, or RemoveHeader before a forwarding action whose type is ForwardGroup. \n* If RuleActionType is set to ForwardGroup, this parameter specifies the information of a virtual endpoint group. You can forward requests to only one virtual endpoint group. Example: {\"type\":\"endpointgroup\", \"value\":\"epg-bp1enpdcrqhl78g6r****\"}. \n  * type: set this parameter to endpointgroup.\n  * value: set this parameter to the ID of a virtual endpoint group.\n* If RuleActionType is set to Redirect, this parameter specifies redirecting configurations. You cannot leave all of the following parameters empty or configure all of these parameters to use the default values for a forwarding action whose type is Redirect: protocol, domain, port, path, and query. Example: {\"protocol\":\"HTTP\", \"domain\":\"www.example.com\", \"port\":\"80\", \"path\":\"/a\",\"query\":\"value1\", \"code\":\"301\" }.\n  * protocol: the protocol of requests after the requests are redirected. Valid values: $${protocol} (default), HTTP, and HTTPS.\n  * domain: the domain name to which requests are redirected. Default value: $${host}. You can also enter a domain name. The domain name must be 3 to 128 characters in length, and can contain only letters, digits, and the following special characters: . - ? = ~ _ - + / ^ * ! $ & | ( ) [ ].\n  * port: the port to which requests are redirected. Default value: $${port}. You can enter a port number that ranges from 1 to 63335.\n  * path: the path to which requests are redirected. Default value: $${path}. The path must be 1 to 128 characters in length. To use a regular expression, the path can contain letters, digits, and the following special characters: . - _ / = ? ~ ^ * $ : ( ) [ ] + |. The path must start with a tilde (~). If you do not want to use a regular expression, the path can contain letters, digits, and the following special characters: . - _ / = ? :. The path must start with a forward slash (/).\n  * query: the query string of the requests to be redirected. Default value: $${query}. You can also specify a query string. The query string must be 1 to 128 characters in length, and can contain printable characters whose ASCII values are greater than or equal to 32 and smaller than 127. The query string cannot contain uppercase letters, space characters, or the following special characters: [ ] { } < > # | &.\n  * code: the redirecting code. Valid values: 301, 302, 303, 307, and 308.\n* If RuleActionType is set to FixResponse, this parameter specifies a fixed response. Example: {\"code\":\"200\", \"type\":\"text/plain\", \"content\":\"dssacav\" }.\n  * code: the HTTP status code to return. The response status code must be one of the following numeric strings: 2xx, 4xx, and 5xx. The letter x indicates a number from 0 to 9.\n  * type: the type of the response content. Valid values: text/plain, text/css, text/html, application/javascript, and application/json.\n  * content: the response content. The response content cannot exceed 1,000 characters in length and does not support Chinese characters.\n* If RuleActionType is set to AddHeader, this parameter specifies an HTTP header to be added. If a forwarding rule contains a forwarding action whose type is AddHeader, you must specify another forwarding action whose type is ForwardGroup. Example: [{\"name\":\"header1\",\"type\":\"userdefined\", \"value\":\"value\"}].\n  * name: the name of the HTTP header. The name must be 1 to 40 characters in length, and can contain letters, digits, hyphens (-), and underscores (_). The name of the HTTP header specified by AddHeader must be unique and cannot be the same as the name of the HTTP header specified by RemoveHeader.\n  * type: the content type of the HTTP header. Valid values: user-defined, ref, and system-defined.\n  * value: the content of the HTTP header. You cannot leave this parameter empty. If you set type to user-defined, the content must be 1 to 128 characters in length, and can contain printable characters whose ASCII values are greater than or equal to 32 and smaller than 127. The content can contain letters, digits, hyphens (-), and underscores (_). The content cannot start or end with a space character. If you set type to ref, the content must be 1 to 128 characters in length, and can contain letters, digits, hyphens (-), and underscores (_). The content cannot start or end with a space character. If you set type to system-defined, only ClientSrcIp is supported.\n* If RuleActionType is set to RemoveHeader, this parameter specifies an HTTP header to be removed. If a forwarding rule contains a forwarding action whose type is RemoveHeader, you must specify another forwarding action whose type is ForwardGroup. The header must be 1 to 40 characters in length, and can contain letters, digits, hyphens (-), and underscores (_). Example: [\"header1\"].\n* If RuleActionType is set to Rewrite, this parameter specifies the rewriting configuration. If a forwarding rule contains a forwarding action whose type is Rewrite, you must specify another forwarding action whose type is ForwardGroup. Example: {\"domain\":\"value1\", \"path\":\"value2\", \"query\":\"value3\"}.\n  * domain: the domain name to which requests are redirected. Default value: $${host}. You can also enter a domain name. The domain name must be 3 to 128 characters in length, and can contain only lowercase letters, digits, and the following special characters: . - ? = ~ _ - + / ^ * ! $ & | ( ) [ ].\n  * path: the path to which requests are redirected. Default value: $${path}. The path must be 1 to 128 characters in length. To use a regular expression, the path can contain letters, digits, and the following special characters: . - _ / = ? ~ ^ * $ : ( ) [ ] + |. The path must start with a tilde (~). If you do not want to use a regular expression, the path can contain letters, digits, and the following special characters: . - _ / = ? :. The path must start with a forward slash (/).\n  * query: the query string of the requests to be redirected. Default value: $${query}. You can also specify a query string. The query string must be 1 to 128 characters in length, and can contain printable characters whose ASCII values are greater than or equal to 32 and smaller than 127. The query string cannot contain uppercase letters, space characters, or the following special characters: [ ] { } < > # | &."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The forwarding action."
              },
              "Required": true,
              "MinLength": 1,
              "MaxLength": 100
            },
            "Priority": {
              "Type": "Number",
              "Description": {
                "en": "The priority of the forwarding rule. Valid values: 1 to 10000. A lower value indicates a higher priority."
              },
              "Required": false,
              "MinValue": 1,
              "MaxValue": 10000
            },
            "ForwardingRuleName": {
              "Type": "String",
              "Description": {
                "en": "The name of the forwarding rule. The name must be 2 to 128 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). The name must start with a letter."
              },
              "Required": false,
              "MinLength": 2,
              "MaxLength": 128
            },
            "RuleConditions": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "RuleConditionType": {
                    "Type": "String",
                    "Description": {
                      "en": "The type of the forwarding conditions. Valid values:\n* Host: domain name\n* Path: path\n* RequestHeader: HTTP header\n* Query: query string\n* Method: HTTP method\n* Cookie: cookie\n* SourceIP: source IP address"
                    },
                    "AllowedValues": [
                      "Host",
                      "Path",
                      "RequestHeader",
                      "Query",
                      "Method",
                      "Cookie",
                      "SourceIP"
                    ],
                    "Required": false
                  },
                  "RuleConditionValue": {
                    "Type": "String",
                    "Description": {
                      "en": "The endpoint port that is mapped to the listener port."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The forwarding conditions."
              },
              "Required": true,
              "MinLength": 1,
              "MaxLength": 100
            },
            "RuleDirection": {
              "Type": "String",
              "Description": {
                "en": "The direction in which the rule takes effect. You do not need to set this parameter. By default, this parameter is set to request, which indicates that the rule takes effect on requests."
              },
              "AllowedValues": [
                "request"
              ],
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
      "en": "Details about the forwarding rules."
    },
    "Label": {
      "en": "ForwardingRules",
      "zh-cn": "转发策略配置信息列表"
    },
    "MinLength": 1,
    "MaxLength": 200
  }
  EOT
}

variable "listener_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the listener."
    },
    "Label": {
      "en": "ListenerId",
      "zh-cn": "监听实例 ID"
    }
  }
  EOT
}

resource "alicloud_ga_forwarding_rule" "extension_resource" {
  accelerator_id = var.accelerator_id
  listener_id    = var.listener_id
}

output "forwarding_rule_ids" {
  // Could not transform ROS Attribute ForwardingRuleIds to Terraform attribute.
  value       = null
  description = "The IDs of the endpoint groups."
}

