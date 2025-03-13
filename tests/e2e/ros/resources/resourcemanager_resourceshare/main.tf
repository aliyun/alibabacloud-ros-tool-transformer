variable "resource_share_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the resource share.\nThe name must be 1 to 50 characters in length.\nIt can contain letters, digits, periods (.), underscores (_), and hyphens (-)."
    },
    "AllowedPattern": "[-a-zA-Z0-9_\\.]{1,50}",
    "Label": {
      "en": "ResourceShareName",
      "zh-cn": "共享单元名称"
    }
  }
  EOT
}

variable "allow_external_targets" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to allow sharing to accounts outside the resource directory. Value:\nfalse (default): Only allow sharing within the resource directory.\ntrue: Allow sharing to any account."
    },
    "Label": {
      "en": "AllowExternalTargets",
      "zh-cn": "是否允许资源目录外的账户共享"
    }
  }
  EOT
}

variable "targets" {
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
      "en": "The shared target.\nA shared target shares the resources of resource owners. You can share your resources\nonly with the member accounts in your resource directory. A shared target is indicated\nby its account ID. For more information about how to obtain the ID, see View the basic information of a member account."
    },
    "Label": {
      "en": "Targets",
      "zh-cn": "资源使用者"
    },
    "MaxLength": 5
  }
  EOT
}

variable "resources" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the shared resource."
          },
          "Required": true
        },
        "ResourceType": {
          "Type": "String",
          "Description": {
            "en": "The type of the shared resource.\nSupport resource type include:\nVPC: VSwitch, PrefixList, PublicIpAddressPool\nROS: ROSTemplate\nServiceCatalog: ServiceCatalogPortfolio\nECS: Image, Snapshot\nKMS: KMSInstance"
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Resources",
      "zh-cn": "共享资源"
    },
    "MaxLength": 5
  }
  EOT
}

variable "permission_names" {
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
      "en": "Sharing permission name. When empty, the system automatically binds the default permissions associated with the resource type."
    },
    "Label": {
      "en": "PermissionNames",
      "zh-cn": "共享权限名称"
    },
    "MaxLength": 6
  }
  EOT
}

resource "alicloud_resource_manager_resource_share" "resource_share" {
  resource_share_name = var.resource_share_name
}

output "resource_share_id" {
  value       = alicloud_resource_manager_resource_share.resource_share.id
  description = "The ID of the resource share."
}

