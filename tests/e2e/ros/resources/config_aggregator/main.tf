variable "aggregator_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of aggregator."
    },
    "Label": {
      "en": "AggregatorName",
      "zh-cn": "账号组名称"
    }
  }
  EOT
}

variable "description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of aggregator."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "账号组描述"
    }
  }
  EOT
}

variable "aggregator_accounts" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AccountId": {
          "Type": "Number",
          "Description": {
            "en": "The account id."
          },
          "Required": true
        },
        "AccountType": {
          "Type": "String",
          "Description": {
            "en": "The account type. Only support: ResourceDirectory"
          },
          "AllowedValues": [
            "ResourceDirectory"
          ],
          "Required": false,
          "Default": "ResourceDirectory"
        },
        "AccountName": {
          "Type": "String",
          "Description": {
            "en": "The account name."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The member account in aggregator.When the AggregatorType is RD, this parameter can be empty, which means that all accounts in the resource directory will be added to the global account group.When the AggregatorType is FOLDER, this parameter can be empty,which means that all accounts in the resource folder will be added to the global account group."
    },
    "Label": {
      "en": "AggregatorAccounts",
      "zh-cn": "账号组内的所有成员账号"
    }
  }
  EOT
}

variable "folder_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The folder ID."
    }
  }
  EOT
}

variable "aggregator_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Account group type. Value:\nRD: Global account group.\nCUSTOM: Custom account group (default value).\nFOLDER: Folder account group. Must set FolderId if the AggregatorType is FOLDER. Please refer to ListAccounts for accessing FolderId."
    },
    "AllowedValues": [
      "RD",
      "CUSTOM",
      "FOLDER"
    ],
    "Label": {
      "en": "AggregatorType",
      "zh-cn": "账号组类型"
    }
  }
  EOT
}

resource "alicloud_config_aggregator" "aggregator" {
  aggregator_name     = var.aggregator_name
  description         = var.description
  aggregator_accounts = var.aggregator_accounts
  aggregator_type     = var.aggregator_type
}

output "aggregator_id" {
  value       = alicloud_config_aggregator.aggregator.id
  description = "The ID of the aggregator. "
}

