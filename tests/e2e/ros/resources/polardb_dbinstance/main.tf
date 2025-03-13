variable "character_set_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The character set of the database. For more information, see Character sets."
    },
    "AllowedValues": [
      "utf8",
      "geostd8",
      "gbk",
      "greek",
      "utf8mb4",
      "hebrew",
      "latin1",
      "hp8",
      "euckr",
      "keybcs2",
      "armscii8",
      "koi8r",
      "ascii",
      "koi8u",
      "big5",
      "latin2",
      "binary",
      "latin5",
      "cp1250",
      "latin7",
      "cp1251",
      "macce",
      "cp1256",
      "macroman",
      "cp1257",
      "sjis",
      "cp850",
      "swe7",
      "cp852",
      "tis620",
      "cp866",
      "ucs2",
      "cp932",
      "ujis",
      "dec8",
      "utf16",
      "eucjpms",
      "utf16le",
      "gb2312"
    ],
    "Label": {
      "en": "CharacterSetName",
      "zh-cn": "字符集"
    }
  }
  EOT
}

variable "account_privilege" {
  type        = string
  default     = "ReadWrite"
  description = <<EOT
  {
    "Description": {
      "en": "The permissions of the database account on the database. Valid values:\nReadWrite: has read and write permissions on the database.\nReadOnly: has the read-only permission on the database.\nDMLOnly: runs only data manipulation language (DML) statements.\nDDLOnly: runs only data definition language (DDL) statements.\nReadIndex: has read and index permissions on the database.\nDefault value: ReadWrite."
    },
    "AllowedValues": [
      "ReadWrite",
      "ReadOnly",
      "DMLOnly",
      "DDLOnly",
      "ReadIndex"
    ],
    "Label": {
      "en": "AccountPrivilege",
      "zh-cn": "账号权限"
    }
  }
  EOT
}

variable "dbdescription" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the database. Valid values:\nIt cannot start with http:// or https://.\nIt must be 2 to 256 characters in length."
    },
    "Label": {
      "en": "DBDescription",
      "zh-cn": "数据库描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
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
      "en": "The ID of the ApsaraDB for POLARDB cluster for which a database is to be created."
    },
    "Label": {
      "en": "DBClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "collate" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "A locale setting that specifies the collation for newly created databases.\nThe locale must be compatible with the character set set by the CharacterSetName parameter.When the cluster is PolarDB PostgreSQL (compatible with Oracle) or PolarDB PostgreSQL, this parameter is required; \nwhen the cluster is PolarDB MySQL, this parameter is not supported.",
      "zh-cn": "语言环境必须与CharacterSetName参数设置的字符集兼容。当集群为PolarDB PostgreSQL版（兼容Oracle）或PolarDB PostgreSQL版时，该参数必填；当集群为PolarDB MySQL版时，不支持该参数。"
    },
    "Label": {
      "zh-cn": "数据库的排序规则"
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
      "en": "The name of the database to be created. The name must comply with the following rules:\nIt must start with a lowercase letter and consist of lowercase letters, digits, hyphens\n(-), and underscores (_).\nIt must end with a letter or a digit. It can be up to 64 characters in length."
    },
    "AllowedPattern": "^[a-z0-9][-_a-z0-9]{0,63}(?<![-_]$)$",
    "Label": {
      "en": "DBName",
      "zh-cn": "数据库名"
    }
  }
  EOT
}

variable "ctype" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "A locale setting that specifies the character classification of the database.\nThe locale must be compatible with the character set set by the CharacterSetName parameter.\nIt is consistent with the incoming information of Collate.\nWhen the cluster is PolarDB PostgreSQL (compatible with Oracle) or PolarDB PostgreSQL, this parameter is required;\n when the cluster is PolarDB MySQL, this parameter is optional.",
      "zh-cn": "语言环境必须与CharacterSetName参数设置的字符集兼容。当集群为PolarDB PostgreSQL版（兼容Oracle）或PolarDB PostgreSQL版时，该参数必填；当集群为PolarDB MySQL版时，不支持该参数。"
    },
    "Label": {
      "zh-cn": "数据库的字符分类"
    }
  }
  EOT
}

variable "account_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the database account to be used."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "账号名"
    }
  }
  EOT
}

resource "alicloud_polardb_database" "dbinstance" {
  character_set_name = var.character_set_name
  db_description     = var.dbdescription
  db_cluster_id      = var.dbcluster_id
  db_name            = var.dbname
  account_name       = var.account_name
}

