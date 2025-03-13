variable "ignore_existing" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to ignore existing role\nFalse: ROS will perform a uniqueness check.If a role with the same name exists, an error will be reported when creating it.\nTrue: ROS will not check the uniqueness.If there is a role with the same name, the role creation process will be ignored.\nIf the role is not created by ROS, it will be ignored during update and delete stage."
    },
    "Label": {
      "zh-cn": "是否忽略已有角色"
    }
  }
  EOT
}

variable "max_session_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum session duration of the RAM role.\nValid values: 3600 to 43200. Unit: seconds. Default value: 3600.\nThe default value is used if the parameter is not specified."
    },
    "MinValue": 3600,
    "Label": {
      "en": "MaxSessionDuration",
      "zh-cn": "RAM角色最大会话时间"
    },
    "MaxValue": 43200
  }
  EOT
}

variable "role_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the role name, containing up to 64 characters."
    },
    "Label": {
      "zh-cn": "RAM角色名称"
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
          "MaxLength": 5
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
      "zh-cn": "要附加的系统和自定义策略名称"
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
      "en": "Remark information, up to 1024 characters or Chinese characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "RAM角色描述"
    },
    "MaxLength": 1024
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
      "zh-cn": "适用RAM角色的策略"
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
      "en": "Whether force detach the policies attached to the role. Default value is false."
    },
    "Label": {
      "zh-cn": "是否强制分离附加到角色上的策略"
    }
  }
  EOT
}

variable "assume_role_policy_document" {
  type        = any
  nullable    = false
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
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "NumericNotEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringLike": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NumericLessThanEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringNotEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringNotEqualsIgnoreCase": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NumericLessThan": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NumericGreaterThan": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateLessThanEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NumericEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateGreaterThanEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateLessThan": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateNotEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringNotLike": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NotIpAddress": {
                          "Type": "Json",
                          "Required": false
                        },
                        "StringEqualsIgnoreCase": {
                          "Type": "Json",
                          "Required": false
                        },
                        "Bool": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "DateGreaterThan": {
                          "Type": "Json",
                          "Required": false
                        },
                        "NumericGreaterThanEquals": {
                          "Type": "Json",
                          "Required": false
                        },
                        "IpAddress": {
                          "Type": "Json",
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "限制条件"
                    }
                  },
                  "Action": {
                    "Type": "String",
                    "Description": {
                      "en": "What action you will allow."
                    },
                    "Required": false,
                    "Label": {
                      "zh-cn": "策略针对的具体操作"
                    },
                    "Default": "sts:AssumeRole"
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
                  },
                  "Principal": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Service": {
                          "Type": "Json",
                          "Required": false,
                          "Label": {
                            "zh-cn": "阿里云服务"
                          }
                        },
                        "Federated": {
                          "Type": "Json",
                          "Required": false,
                          "Label": {
                            "zh-cn": "身份提供商"
                          }
                        },
                        "RAM": {
                          "Type": "Json",
                          "Required": false,
                          "Label": {
                            "zh-cn": "阿里云账号"
                          }
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "对象规则的过期属性"
                    }
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Describes the permission."
              },
              "Required": false
            },
            "ListMetadata": {
              "Order": [
                "Action",
                "Effect",
                "Principal",
                "Condition"
              ]
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
      "en": "The RAM assume role policy that is associated with this role."
    },
    "Label": {
      "zh-cn": "可以扮演此RAM角色的身份"
    }
  }
  EOT
}

resource "alicloud_ram_role" "role" {
  max_session_duration = var.max_session_duration
  name                 = var.role_name
  description          = var.description
  document             = var.assume_role_policy_document
}

output "role_name" {
  value       = alicloud_ram_role.role.id
  description = "Name of ram role."
}

output "arn" {
  value       = alicloud_ram_role.role.arn
  description = "Name of alicloud resource."
}

output "role_id" {
  value       = alicloud_ram_role.role.role_id
  description = "Id of ram role."
}

