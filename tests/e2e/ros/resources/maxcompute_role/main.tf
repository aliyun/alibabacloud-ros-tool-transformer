variable "policy" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The document of the policy. This parameter is not required if an access-control list (ACL) is used."
    },
    "Label": {
      "en": "Policy",
      "zh-cn": "角色的 Policy 授权信息"
    }
  }
  EOT
}

variable "role_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the project role"
    },
    "Label": {
      "en": "RoleName",
      "zh-cn": "角色名称"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Admin",
      "Resource"
    ],
    "Description": {
      "en": "Role types, MaxCompute provides administrator roles and resource roles. Valid values:\nAdmin: You can grant management-related permissions to administrator roles by using policies instead of access control lists (ACLs). You cannot grant resource-related permissions to administrator roles.\nResource: You can grant resource-related permissions but not management-related permissions to resource roles."
    },
    "Label": {
      "en": "Type",
      "zh-cn": "角色类型"
    }
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the MaxCompute project."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "MaxCompute 项目名称"
    }
  }
  EOT
}

variable "acl" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Function": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "Project": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "Table": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "Instance": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "Resource": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "Package": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Actions": {
                    "Type": "Json",
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The access-control list (ACL), This parameter is not required if a policy is used."
    },
    "Label": {
      "en": "Acl",
      "zh-cn": "角色的 ACL 授权信息"
    }
  }
  EOT
}

resource "alicloud_max_compute_role" "extension_resource" {
  policy       = var.policy
  role_name    = var.role_name
  type         = var.type
  project_name = var.project_name
}

