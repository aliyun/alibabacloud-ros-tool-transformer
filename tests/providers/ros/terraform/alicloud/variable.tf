variable "common_name" {
  type    = string
  default = "HZ"
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
      "en": "ECS Instance Password",
      "zh-cn": "ECS实例密码"
    },
    "ConstraintDescription": {
      "en": "Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::Password"
  }
  EOT
}

variable "instance_type" {
  type        = string
  default     = "ecs.e-c1m2.large"
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}",
      "SystemDiskCategory": "cloud_essd",
      "InstanceChargeType": "PostPaid"
    },
    "Label": {
      "zh-cn": "实例类型",
      "en": "Instance Type"
    }
  }
  EOT
}

variable "zone_id1" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "Description": {
      "zh-cn": "可用区ID。<br><b>注： <font color='blue'>选择可用区前请确认该可用区是否支持创建ECS资源的规格</font></b>",
      "en": "Availability Zone ID,<br><b>note： <font color='blue'>Before selecting, please confirm that the Availability Zone supports the specification of creating ECS resources</font></b>"
    },
    "Label": {
      "zh-cn": "交换机可用区ID",
      "en": "Available Zone ID"
    }
  }
  EOT
}

variable "bai_lian_api_key" {
  type        = map
  description = <<EOT
  {
    "Label": {
      "en": "BaiLian API-KEY",
      "zh-cn": "百炼 API-KEY"
    },
    "AssociationProperty": "ALIYUN::Bailian::ApiKey::ApiKeyInfo",
    "Description": {
      "zh-cn": "开通百炼模型服务，并获得 API-KEY，请参考： <a href=\"https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key\"  target=\"_blank\">获取 API-KEY</a>。",
      "en": "Activate BaiLian and obtain the API-KEY. Please refer to:  <a href=\"https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key\"  target=\"_blank\">Get API-KEY</a>."
    }
  }
  EOT
}

