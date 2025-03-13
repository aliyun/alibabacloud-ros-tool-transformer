variable "role_policy" {
  type        = string
  default     = "EnsureAdminRoleAndBinding"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "None": {
          "en": "None",
          "zh-cn": "不执行任何操作"
        },
        "EnsureAdminRoleAndBinding": {
          "en": "Ensure Admin Role And Binding",
          "zh-cn": "自动创建角色"
        }
      },
      "DescriptionMapping": {
        "None": {
          "en": "Does not perform operations.",
          "zh-cn": "不执行任何操作。"
        },
        "EnsureAdminRoleAndBinding": {
          "en": "Automatically creates a role named ros:application-admin:$${user-id} that has administrator permissions and attaches the role to your account.",
          "zh-cn": "自动创建一个名为ros:application-admin:$${user-id}的角色，具有管理员权限，并将其绑定到当前用户。"
        }
      }
    },
    "Description": {
      "en": "Before deploying the application, check the policies associated with the roles of the current user. Valid values:\n- EnsureAdminRoleAndBinding: Automatically create a role named \"ros:application-admin:$${user-id}\" with administrator permissions and bind it to the current user.\n- None: Do nothing.\nThe default value is EnsureAdminRoleAndBinding.",
      "zh-cn": "在部署应用程序之前，请检查与当前用户的角色关联的策略。"
    },
    "AllowedValues": [
      "EnsureAdminRoleAndBinding",
      "None"
    ],
    "Label": {
      "en": "RolePolicy",
      "zh-cn": "在部署应用程序之前"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster ID."
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "addons" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Version": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, the latest version is selected by default."
          },
          "Required": false
        },
        "Config": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, no configuration is required."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Addon plugin name"
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "A combination of addon plugins for Kubernetes clusters.\nNetwork plug-in: including Flannel and Terway network plug-ins\nLog service: Optional. If the log service is not enabled, the cluster audit function cannot be used.\nIngress: The installation of the Ingress component is enabled by default."
    },
    "Label": {
      "en": "Addons",
      "zh-cn": "组件配置信息列表"
    },
    "MaxLength": 10
  }
  EOT
}

variable "validation_mode" {
  type        = string
  default     = "Strict"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Basic": {
          "en": "Basic validation",
          "zh-cn": "基本验证"
        },
        "Strict": {
          "en": "Strict validation",
          "zh-cn": "严格验证"
        }
      },
      "DescriptionMapping": {
        "Basic": {
          "en": "Basic validation. For example, the system validates whether the cluster exists.",
          "zh-cn": "基本验证，例如验证集群是否存在。"
        },
        "Strict": {
          "en": "Strict validation. In addition to a basic validation, the system validates the validity of WaitUntil. ",
          "zh-cn": "除了基本验证外，还验证WaitUntil的合法性。"
        }
      }
    },
    "Description": {
      "en": "Validation modes include:\n- Basic: basic validation, such as verifying the existence of a cluster.\n- Strict: in addition to basic validation, also validate the legality of WaitUntil."
    },
    "AllowedValues": [
      "Basic",
      "Strict"
    ],
    "Label": {
      "en": "ValidationMode",
      "zh-cn": "验证模式"
    }
  }
  EOT
}

variable "wait_until" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Operator": {
          "Type": "String",
          "Description": {
            "en": "The operator to compare the value with the result of jsonpath expression."
          },
          "AllowedValues": [
            "Empty",
            "NotEmpty",
            "Equals",
            "NotEquals"
          ],
          "Required": true
        },
        "ApiVersion": {
          "Type": "String",
          "Description": {
            "en": "The API version of the kubernetes resource to query."
          },
          "Required": false
        },
        "FirstMatch": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Only the first matching result in jsonpath's filtered results is returned. Default False"
          },
          "Required": false,
          "Default": false
        },
        "ValueType": {
          "Type": "String",
          "Description": {
            "en": "The type of value. Default value is String."
          },
          "AllowedValues": [
            "String",
            "Json"
          ],
          "Required": false,
          "Default": "String"
        },
        "Timeout": {
          "Type": "Number",
          "Description": {
            "en": "The timeout of waiting for the condition to be met. The unit is seconds."
          },
          "Required": false,
          "MinValue": 10,
          "MaxValue": 10800,
          "Default": 600
        },
        "Kind": {
          "Type": "String",
          "Description": {
            "en": "The kind of kubernetes resources to query."
          },
          "Required": true
        },
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The value to compare with the result of jsonpath expression."
          },
          "Required": false
        },
        "Stage": {
          "AssociationPropertyMetadata": {
            "ValueLabelMapping": {
              "Delete": {
                "en": "Delete stage",
                "zh-cn": "删除阶段"
              },
              "Create": {
                "en": "Create stage",
                "zh-cn": "创建阶段"
              },
              "Create/Update": {
                "en": "Create/Update stage",
                "zh-cn": "创建和更新阶段"
              },
              "Update": {
                "en": "Update stage",
                "zh-cn": "更新阶段"
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "At what stage to wait. Valid values:\n- Create/Update: the create and update stage.\n- Delete: the delete stage.\nThe default is Create/Update."
          },
          "AllowedValues": [
            "Create/Update",
            "Create",
            "Update",
            "Delete"
          ],
          "Required": false,
          "Default": "Create/Update"
        },
        "JsonPath": {
          "Type": "String",
          "Description": {
            "en": "Json path expression to filter the output."
          },
          "Required": false
        },
        "Namespace": {
          "Type": "String",
          "Description": {
            "en": "The namespace of kubernetes containing the resource. Default value is DefaultNamespace"
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the kubernetes resource to query."
          },
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Kind",
          "Name",
          "Operator",
          "FirstMatch",
          "JsonPath",
          "Namespace",
          "Stage",
          "Timeout",
          "Value",
          "ValueType"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "After starting a creation or update, wait until all conditions are met.",
      "zh-cn": "开始创建或更新后，等待直到满足所有条件。"
    },
    "Label": {
      "en": "WaitUntil",
      "zh-cn": "开始创建或更新后"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "installed_ignore" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to ignore already installed addons when creating. If true, when creating, only install addons that are not yet installed. When deleting, only uninstall addons that are installed during the creation stage.\nDefault false."
    },
    "Label": {
      "en": "InstalledIgnore",
      "zh-cn": "创建集群时是否忽略已安装的组件"
    }
  }
  EOT
}

resource "alicloud_cs_kubernetes_addon" "cluster_addons" {
  cluster_id = var.cluster_id
}

output "wait_until_data" {
  // Could not transform ROS Attribute WaitUntilData to Terraform attribute.
  value       = null
  description = "A list of values for each JsonPath in WaitUntil."
}

output "cluster_id" {
  value       = alicloud_cs_kubernetes_addon.cluster_addons.cluster_id
  description = "The ID of the cluster."
}

