variable "account_privilege" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The permissions of the database account on the database. Valid values:\n- ReadWrite: has read and write permissions on the database.\n- ReadOnly: has the read-only permission on the database.\n- DMLOnly: runs only data manipulation language (DML) statements.\n- DDLOnly: runs only data definition language (DDL) statements.\nThe number of account permissions specified by the AccountPrivilege parameter must be the same as that of database names specified by the DBName parameter. Each account permission must correspond to a database name in sequence.\nSeparate multiple permissions with a comma (,)."
    },
    "Label": {
      "en": "AccountPrivilege",
      "zh-cn": "账号权限"
    },
    "MinLength": 1
  }
  EOT
}

variable "dbcluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the ApsaraDB for POLARDB cluster to which a database account belongs."
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
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the database whose access permissions are to be granted to the database account.\nYou can grant access permissions on one or more databases to the database account.\nSeparate multiple databases with a comma (,)."
    },
    "Label": {
      "en": "DBName",
      "zh-cn": "设置要授权的数据库名"
    },
    "MinLength": 1
  }
  EOT
}

variable "account_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the database account to be granted access permissions."
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

resource "alicloud_polardb_account_privilege" "polardbaccount_privilege" {
  account_privilege = var.account_privilege
  db_cluster_id     = var.dbcluster_id
  db_names          = var.dbname
  account_name      = var.account_name
}

