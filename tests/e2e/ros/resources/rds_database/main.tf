variable "character_set_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The character set you want to use for the database. Valid values:\nMySQL and MariaDB: utf8 | gbk | latin1 | utf8mb4.\nSQL Server: Chinese_PRC_CI_AS | Chinese_PRC_CS_AS | SQL_Latin1_General_CP1_CI_AS | SQL_Latin1_General_CP1_CS_AS\n| Chinese_PRC_BIN.\nPostgreSQL: KOI8U | UTF8 | WIN866 | WIN874 | WIN1250 | WIN1251 | WIN1252 | WIN1253 | WIN1254 |\nWIN1255 | WIN1256 | WIN1257 | WIN1258 | EUC_CN | EUC_KR | EUC_TW | EUC_JP | EUC_JIS_2004\n| KOI8R | MULE_INTERNAL | LATIN1 | LATIN2 | LATIN3 | LATIN4 | LATIN5 | LATIN6 | LATIN7\n| LATIN8 | LATIN9 | LATIN10 | ISO_8859_5 | ISO_8859_6 | ISO_8859_7 | ISO_8859_8 |\nSQL_ASCII."
    },
    "Label": {
      "en": "CharacterSetName",
      "zh-cn": "字符集"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RDS::Instance::InstanceId",
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "dbdescription" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the database. The description must be 2 to 256 characters in length.\nThe description must start with a letter and can contain letters, digits, underscores\n(_), and hyphens (-).\nNote The description cannot start with http:// or https://."
    },
    "Label": {
      "en": "DBDescription",
      "zh-cn": "数据库描述"
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
      "en": "The name of the database you want to create.\nNote\nThe name must be 2 to 64 characters in length.\nThe name must start with a lowercase letter and end with a lowercase letter or digit.\nThe name can contain lowercase letters, digits, underscores (_), and hyphens (-).\nThe name must be unique in the instance.\nFor more information about invalid characters, see Forbidden keywords table."
    },
    "Label": {
      "en": "DBName",
      "zh-cn": "数据库名称"
    }
  }
  EOT
}

resource "alicloud_db_database" "database" {
  character_set = var.character_set_name
  instance_id   = var.dbinstance_id
  name          = var.dbname
}

output "dbinstance_id" {
  // Could not transform ROS Attribute DBInstanceId to Terraform attribute.
  value       = null
  description = "The ID of the instance."
}

output "dbname" {
  // Could not transform ROS Attribute DBName to Terraform attribute.
  value       = null
  description = "The name of the database."
}

