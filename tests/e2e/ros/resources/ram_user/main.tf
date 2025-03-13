variable "user_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the user name, containing up to 64 characters."
    },
    "Label": {
      "en": "UserName",
      "zh-cn": "RAM用户的名称"
    }
  }
  EOT
}

variable "policies" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "IgnoreExisting": {
              "Type": "Boolean",
              "Description": {
                "en": "Whether to ignore existing policy\nFalse: ROS will perform a uniqueness check.If a policy with the same name exists, an error will be reported when creating it.\nTrue: ROS will not check the uniqueness.If there is a policy with the same name, the policy creation process will be ignored.\nIf the policy is not created by ROS, it will be ignored during update and delete stage."
              },
              "Required": false,
              "Default": false
            },
            "Description": {
              "AssociationProperty": "TextArea",
              "Type": "String",
              "Description": {
                "en": "Specifies the authorization policy description, containing up to 1024 characters."
              },
              "Required": false,
              "MaxLength": 1024
            },
            "PolicyName": {
              "Type": "String",
              "Description": {
                "en": "Specifies the authorization policy name, containing up to 128 characters."
              },
              "Required": true,
              "MaxLength": 128
            },
            "PolicyDocument": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Version": {
                    "Type": "String",
                    "Description": {
                      "en": "You can use versions to track changes to a managed policy."
                    },
                    "Required": true
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
                              "Required": false
                            },
                            "Action": {
                              "Type": "Json",
                              "Description": {
                                "en": "What actions you will allow."
                              },
                              "Required": false
                            },
                            "Resource": {
                              "Type": "Json",
                              "Description": {
                                "en": "Which resources you allow the action on."
                              },
                              "Required": false
                            },
                            "Effect": {
                              "Type": "String",
                              "Description": {
                                "en": "What the effect will be when the user requests access-either allow or deny."
                              },
                              "Required": false
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
              "Type": "Json",
              "Description": {
                "en": "A policy document that describes what actions are allowed on which resources."
              },
              "Required": true
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Describes what actions are allowed on what resources."
    },
    "Label": {
      "zh-cn": "适用于RAM用户的权限策略"
    }
  }
  EOT
}

variable "email" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Email of ram user."
    },
    "Label": {
      "en": "Email",
      "zh-cn": "RAM用户的邮箱"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether force detach the policies and groups attached to the user. Default value is false."
    },
    "Label": {
      "zh-cn": "是否强制分离附加到角色上的策略"
    }
  }
  EOT
}

variable "policy_attachments" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Custom": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "AllowedPattern": "^[a-zA-Z0-9\\-_]{1,128}$",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false,
          "Label": {
            "zh-cn": "自定义策略名称"
          },
          "MaxLength": 10
        },
        "System": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "AllowedPattern": "^[a-zA-Z0-9\\-_]{1,128}$",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false,
          "Label": {
            "zh-cn": "系统策略名称"
          },
          "MaxLength": 20
        }
      }
    },
    "Description": {
      "en": "System and custom policy names to attach."
    },
    "Label": {
      "zh-cn": "要添加的系统策略和自定义策略名称"
    }
  }
  EOT
}

variable "groups" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "A name of a group to which you want to add the user."
    },
    "Label": {
      "en": "Groups",
      "zh-cn": "RAM用户加入的用户组"
    }
  }
  EOT
}

variable "comments" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Comments of ram user."
    },
    "Label": {
      "en": "Comments",
      "zh-cn": "备注"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "display_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name, up to 128 characters or Chinese characters."
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "RAM用户的显示名称"
    }
  }
  EOT
}

variable "login_profile" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PasswordResetRequired": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the user is required to set a new password the next time the user logs in to the AliCloud Management Console."
          },
          "Required": false,
          "Label": {
            "zh-cn": "RAM用户在下次登录时是否必须重置密码"
          },
          "Default": false
        },
        "MFABindRequired": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the user must bind a multi factor authentication device at the next logon."
          },
          "Required": false,
          "Label": {
            "zh-cn": "是否强制要求RAM用户开启多因素认证"
          },
          "Default": false
        },
        "Password": {
          "AssociationProperty": "ALIYUN::ECS::Instance::Password",
          "Type": "String",
          "Description": {
            "en": "The password for the user."
          },
          "Required": false,
          "Label": {
            "zh-cn": "RAM用户的控制台登录新密码"
          },
          "MinLength": 8,
          "MaxLength": 32
        }
      }
    },
    "Description": {
      "en": "Creates a login profile for users so that they can access the AliCloud Management Console."
    },
    "Label": {
      "zh-cn": "RAM用户的登录配置"
    }
  }
  EOT
}

variable "mobile_phone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Phone number of ram user."
    },
    "Label": {
      "en": "MobilePhone",
      "zh-cn": "RAM用户的手机号码"
    }
  }
  EOT
}

resource "alicloud_ram_user" "user" {
  name         = var.user_name
  email        = var.email
  comments     = var.comments
  display_name = var.display_name
  mobile       = var.mobile_phone
}

output "user_name" {
  // Could not transform ROS Attribute UserName to Terraform attribute.
  value       = null
  description = "Name of ram user."
}

output "user_id" {
  value       = alicloud_ram_user.user.id
  description = "Id of ram user."
}

output "last_login_date" {
  // Could not transform ROS Attribute LastLoginDate to Terraform attribute.
  value       = null
  description = "Last login date of ram user."
}

output "create_date" {
  // Could not transform ROS Attribute CreateDate to Terraform attribute.
  value       = null
  description = "Create date of ram user."
}

