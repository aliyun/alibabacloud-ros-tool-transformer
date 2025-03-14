variable "ignore_existing" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to ignore existing policy\nFalse: ROS will perform a uniqueness check.If a policy with the same name exists, an error will be reported when creating it.\nTrue: ROS will not check the uniqueness.If there is a policy with the same name, the policy creation process will be ignored.\nIf the policy is not created by ROS, it will be ignored during update and delete stage."
    },
    "Label": {
      "zh-cn": "是否忽略已有策略"
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
      "en": "Specifies the authorization policy description, containing up to 1024 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "策略描述"
    },
    "MaxLength": 1024
  }
  EOT
}

variable "groups" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The names of groups to attach to this policy."
    },
    "Label": {
      "zh-cn": "要附加到此策略的组的名称"
    }
  }
  EOT
}

variable "policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the authorization policy name, containing up to 128 characters."
    },
    "Label": {
      "en": "PolicyName",
      "zh-cn": "策略名称"
    },
    "MaxLength": 128
  }
  EOT
}

variable "policy_document_unchecked" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "A policy document that describes what actions are allowed on which resources. If it is specified, PolicyDocument will be ignored."
    },
    "Label": {
      "zh-cn": "允许进行哪些操作的策略"
    }
  }
  EOT
}

variable "policy_document" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Version": {
          "Type": "String",
          "Description": {
            "en": "You can use versions to track changes to a managed policy."
          },
          "Required": true,
          "Label": {
            "zh-cn": "策略版本"
          },
          "Default": 1
        },
        "Statement": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Condition": {
                    "Type": "Json",
                    "Description": {
                      "en": "What conditions should be satisfied."
                    },
                    "Required": false,
                    "Label": {
                      "zh-cn": "授权生效的限制条件"
                    }
                  },
                  "Action": {
                    "Type": "Json",
                    "Description": {
                      "en": "What actions you will allow."
                    },
                    "Required": false,
                    "Label": {
                      "zh-cn": "策略针对的具体操作"
                    }
                  },
                  "Resource": {
                    "Type": "Json",
                    "Description": {
                      "en": "Which resources you allow the action on."
                    },
                    "Required": false,
                    "Label": {
                      "zh-cn": "权限策略针对的具体资源"
                    }
                  },
                  "Effect": {
                    "Type": "String",
                    "Description": {
                      "en": "What the effect will be when the user requests access-either allow or deny."
                    },
                    "AllowedValues": [
                      "Allow",
                      "Deny"
                    ],
                    "Required": false,
                    "Label": {
                      "zh-cn": "权限效力"
                    }
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Describes the permission"
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "A policy consists of one or more statements."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "A policy document that describes what actions are allowed on which resources."
    },
    "Label": {
      "zh-cn": "策略详细定义"
    }
  }
  EOT
}

variable "roles" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true
    },
    "Description": {
      "en": "The names of roles to attach to this policy."
    },
    "Label": {
      "zh-cn": "要附加到此策略的角色的名称"
    }
  }
  EOT
}

variable "users" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true
    },
    "Description": {
      "en": "The names of users to attach to this policy."
    },
    "Label": {
      "zh-cn": "要附加到此策略的用户名"
    }
  }
  EOT
}

resource "alicloud_ram_policy" "policy" {
  description = var.description
  name        = var.policy_name
  document    = var.policy_document
}

output "policy_name" {
  value       = alicloud_ram_policy.policy.id
  description = "When the logical ID of this resource is provided to the Ref intrinsic function, Ref returns the ARN."
}

