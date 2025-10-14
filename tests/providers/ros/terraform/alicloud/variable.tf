variable "common_name" {
  type    = string
  default = "high-availability"
}

variable "zone_id1" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "AssociationPropertyMetadata": {
      "AutoSelectFirst": true,
      "ExclusiveTo": [
        "ZoneId2"
      ]
    },
    "Label": {
      "en": "Availability Zone",
      "zh-cn": "可用区1"
    }
  }
  EOT
}

variable "zone_id2" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "AssociationPropertyMetadata": {
      "AutoSelectFirst": true,
      "ExclusiveTo": [
        "ZoneId1"
      ]
    },
    "Label": {
      "en": "Availability Zone",
      "zh-cn": "可用区2"
    }
  }
  EOT
}

variable "instance_type1" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "InstanceChargeType": "PostPaid",
      "SystemDiskCategory": "cloud_essd",
      "ZoneId": "$${ZoneId}",
      "DefaultValueStrategy": "recent",
      "AutoSelectFirst": true
    },
    "Label": {
      "en": "Instance Type",
      "zh-cn": "实例规格1"
    }
  }
  EOT
}

variable "instance_type2" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "InstanceChargeType": "PostPaid",
      "SystemDiskCategory": "cloud_essd",
      "ZoneId": "$${ZoneId}",
      "DefaultValueStrategy": "recent",
      "AutoSelectFirst": true
    },
    "Label": {
      "en": "Instance Type",
      "zh-cn": "实例规格2"
    }
  }
  EOT
}

variable "instance_password" {
  type        = string
  sensitive   = true
  description = <<EOT
  {
    "Description": {
      "en": "Server login password, Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "Label": {
      "en": "Instance Password",
      "zh-cn": "实例密码"
    },
    "ConstraintDescription": {
      "en": "Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::Password"
  }
  EOT
}

variable "dbuser_name" {
  type        = string
  default     = "high_availability"
  description = <<EOT
  {
    "ConstraintDescription": {
      "en": "Consist of 2 to 32 characters of lowercase letters, underline.  Must begin with a letter and be end with an alphanumeric character",
      "zh-cn": "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
    },
    "Label": {
      "zh-cn": "RDS数据库账号",
      "en": "RDS DB Username"
    },
    "AllowedPattern": "^[a-z][a-z0-9_]{0,31}$"
  }
  EOT
}

variable "dbpassword" {
  type        = string
  sensitive   = true
  description = <<EOT
  {
    "Description": {
      "en": "RDS user password, Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "数据库账号密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "Label": {
      "en": "RDS Instance Password",
      "zh-cn": "RDS数据库密码"
    },
    "ConstraintDescription": {
      "en": "Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括!@#$%^&*()_+-="
    },
    "AssociationProperty": "ALIYUN::RDS::Instance::AccountPassword"
  }
  EOT
}

variable "dbinstance_class" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "RDS Instance Class",
      "zh-cn": "RDS实例规格"
    },
    "AssociationProperty": "ALIYUN::RDS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "AutoSelectFirst": true,
      "ZoneId": {
        "Ref": "ZoneId"
      },
      "EngineVersion": "8.0",
      "DBInstanceStorageType": "cloud_essd",
      "Engine": "MySQL",
      "Category": "HighAvailability",
      "CommodityCode": "bards"
    }
  }
  EOT
}

variable "enablecdt" {
  type        = bool
  description = <<EOT
  {
    "Label": {
      "en": "EnableCDT",
      "zh-cn": "是否开通 CDT"
    }
  }
  EOT
}

