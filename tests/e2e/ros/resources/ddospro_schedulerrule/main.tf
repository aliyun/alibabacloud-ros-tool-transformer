variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the instance belongs in Resource Management. This parameter is empty by default, which indicates that the instance belongs to the default resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "DDoS高防实例在资源管理产品中所属的资源组ID"
    }
  }
  EOT
}

variable "param" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The details of the CDN interaction rule. This parameter is a JSON string. The following list describes the fields in the value of the parameter: \nParamType: the type of the scheduling rule. This field is required and must be of the string type. Set the value to cdn. This indicates that you want to modify a CDN interaction rule. \nParamData: the values of parameters that you want to modify for the CDN interaction rule. This field is required and must be of the map type. ParamData contains the following parameters: Domain: the accelerated domain in CDN. This parameter is required and must be of the string type; Cname: the CNAME that is assigned to the accelerated domain. This parameter is required and must be of the string type; AccessQps: the queries per second (QPS) threshold that is used to switch service traffic to Anti-DDoS Pro or Anti-DDoS Premium. This parameter is required and must be of the integer type; UpstreamQps: the QPS threshold that is used to switch service traffic to CDN. This parameter is optional and must be of the integer type.",
      "zh-cn": "CDN联动规则的详细信息，使用JSON格式的字符串表达。"
    },
    "Label": {
      "en": "Param",
      "zh-cn": "CDN联动规则的详细信息"
    }
  }
  EOT
}

variable "rule_type" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      2,
      3,
      5,
      6,
      8
    ],
    "Description": {
      "en": "The type of the custom defense rule. Valid values: \n2: tiered protection \n3: network acceleration \n5: CDN interaction \n6: cloud service interaction\n8: secure acceleration"
    },
    "Label": {
      "en": "RuleType",
      "zh-cn": "规则类型"
    }
  }
  EOT
}

variable "rules" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The details of the scheduling rule. This parameter is a JSON string. The following list describes the fields in the value of the parameter: \nType: the address type of the interaction resource that you want to use in the scheduling rule. This field is required and must be of the string type. Valid values: A: IP address. CNAME: domain name\nValue: the address of the interaction resource that you want to use in the scheduling rule. This field is required and must be of the string type.\nPriority: the priority of the scheduling rule. This field is required and must be of the integer type. Valid values: 0 to 100. A larger value indicates a higher priority.\nValueType: the type of the interaction resource that you want to use in the scheduling rule. This field is required and must be of the integer type. Valid values: 1: the IP address of the Anti-DDoS Pro or Anti-DDoS Premium instance. 2: the IP address of the interaction resource in the tiered protection scenario. 3: the IP address that is used to accelerate access in the network acceleration scenario. 5: the domain name that is configured in Alibaba Cloud CDN (CDN) in the CDN interaction scenario. 6 the IP address of the interaction resource in the cloud service interaction scenario \nRegionId: the region where the interaction resource is deployed. This parameter must be specified when ValueType is set to 2. The value must be of the string type.",
      "zh-cn": "通用联动规则的详细信息，使用JSON格式的字符串表述。"
    },
    "Label": {
      "en": "Rules",
      "zh-cn": "通用联动规则的详细信息"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "规则名称"
    }
  }
  EOT
}

resource "alicloud_ddoscoo_scheduler_rule" "extension_resource" {
  resource_group_id = var.resource_group_id
  param             = var.param
  rule_type         = var.rule_type
  rules             = var.rules
  rule_name         = var.rule_name
}

output "rule_name" {
  value       = alicloud_ddoscoo_scheduler_rule.extension_resource.id
  description = "The name of the rule."
}

