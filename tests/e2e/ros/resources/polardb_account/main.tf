variable "account_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the database account. The description must comply with the following rules:\n- It cannot start with http:// or https://.\n- It must be 2 to 256 characters in length."
    },
    "Label": {
      "en": "AccountDescription",
      "zh-cn": "账号描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "account_privilege" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AccountType}",
            "Normal"
          ]
        }
      }
    },
    "Description": {
      "en": "The permissions of the database account on the database. Valid values:\nReadWrite: has read and write permissions on the database.\nReadOnly: has the read-only permission on the database.\nDMLOnly: runs only data manipulation language (DML) statements.\nDDLOnly: runs only data definition language (DDL) statements.\nReadIndex: has read and index permissions on the database.\nDefault value: ReadWrite.\nSeparate multiple permissions with a comma (,).",
      "zh-cn": "本参数仅适用于PolarRDB MySQL集群普通账号。"
    },
    "AllowedValues": [
      "ReadWrite",
      "ReadOnly",
      "DMLOnly",
      "DDLOnly"
    ],
    "Label": {
      "en": "AccountPrivilege",
      "zh-cn": "账号权限"
    }
  }
  EOT
}

variable "dbcluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::POLARDB::DBCluster::DBClusterId",
    "Description": {
      "en": "The ID of the ApsaraDB for POLARDB cluster for which a database account is to be created."
    },
    "Label": {
      "en": "DBClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "dbname" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AccountType}",
            "Normal"
          ]
        }
      }
    },
    "Description": {
      "en": "The name of the database whose access permissions are to be granted to the database account. Separate multiple databases with a comma (,).",
      "zh-cn": "多个数据库名以英文逗号（,）分隔。本参数仅适用于PolarDB MySQL集群普通账号。"
    },
    "Label": {
      "en": "DBName",
      "zh-cn": "授权访问的数据库名称"
    }
  }
  EOT
}

variable "account_type" {
  type        = string
  default     = "Normal"
  description = <<EOT
  {
    "Description": {
      "en": "The type of the database account. Valid values:\n- Normal: standard account\n- Super: privileged account\nDefault value: Super.\nCurrently, POLARDB for PostgreSQL and POLARDB compatible with Oracle do not support standard accounts.\nYou can create only one privileged account for an ApsaraDB for POLARDB cluster."
    },
    "AllowedValues": [
      "Normal",
      "Super"
    ],
    "Label": {
      "en": "AccountType",
      "zh-cn": "账号类型"
    }
  }
  EOT
}

variable "priv_for_alldb" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to grant permissions to all libraries in the current cluster and any libraries that will be added in the future. Valid values:\n- 0 (default)): Not authorized.\n- 1: Authorization."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "PrivForAllDB",
      "zh-cn": "是否授权当前集群所有库及后续新增所有库的权限"
    }
  }
  EOT
}

variable "account_password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The password of the database account. The password must comply with the following rules:\n- It must consist of uppercase letters, lowercase letters, digits, and special characters.\n- Special characters include exclamation points (!), number signs (#), dollar signs ($), percent signs (%), carets (^), ampersands (&), asterisks (*), parentheses (()), underscores (_), plus signs (+), hyphens (-), and equal signs (=).\n- It must be 8 to 32 characters in length."
    },
    "Label": {
      "en": "AccountPassword",
      "zh-cn": "密码"
    },
    "MinLength": 8,
    "MaxLength": 32
  }
  EOT
}

variable "account_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the database account. The name must comply with the following rules:\n- It must start with a lowercase letter and consist of lowercase letters, digits, and underscores (_).\n- It can be up to 16 characters in length."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "账号名"
    },
    "MinLength": 1,
    "MaxLength": 16
  }
  EOT
}

resource "alicloud_polardb_account" "account" {
  account_description = var.account_description
  db_cluster_id       = var.dbcluster_id
  account_type        = var.account_type
  account_password    = var.account_password
  account_name        = var.account_name
}

