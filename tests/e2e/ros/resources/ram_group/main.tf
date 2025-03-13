variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the group name, containing up to 64 characters."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "用户组名称"
    }
  }
  EOT
}

variable "ignore_existing" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to ignore existing group\nFalse: ROS will perform a uniqueness check.If a group with the same name exists, an error will be reported when creating it.\nTrue: ROS will not check the uniqueness.If there is a group with the same name, the group creation process will be ignored.\nIf the group is not created by ROS, it will be ignored during update and delete stage."
    },
    "Label": {
      "en": "IgnoreExisting",
      "zh-cn": "是否忽略现有组"
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
          "MaxLength": 20
        }
      }
    },
    "Description": {
      "en": "System and custom policy names to attach."
    },
    "Label": {
      "en": "PolicyAttachments",
      "zh-cn": "要添加的系统和自定义策略名称"
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
      "en": "Policies",
      "zh-cn": "权限策略"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force detach the policies attached to the group. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制解绑RAM用户组的策略"
    }
  }
  EOT
}

variable "comments" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Remark information, up to 128 characters or Chinese characters."
    },
    "Label": {
      "en": "Comments",
      "zh-cn": "备注信息"
    },
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_ram_group" "group" {
  name     = var.group_name
  comments = var.comments
}

output "group_name" {
  value       = alicloud_ram_group.group.id
  description = "Id of ram group."
}

