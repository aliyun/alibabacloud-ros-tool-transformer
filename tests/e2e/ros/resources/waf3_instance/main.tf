variable "ignore_existing" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to ignore existing WAF3 instance\nFalse: ROS will perform a uniqueness check.If the WAF3 instance exists, an error will be reported when creating it.\nTrue: ROS will not check the uniqueness.If the WAF3 instance exists, the creation process will be ignored.\nIf the WAF3 instance is not created by ROS, it will be ignored during update and delete stage."
    },
    "Label": {
      "en": "IgnoreExisting",
      "zh-cn": "是否忽略已有的WAF3实例"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to auto renew the prepay instance."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否到期自动续费"
    }
  }
  EOT
}

variable "intelligent_load_balancing" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Intelligent load balancer for WAF instance."
    },
    "Label": {
      "en": "IntelligentLoadBalancing",
      "zh-cn": "是否开启智能负载均衡"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period of the firewallIf PeriodUnit is month, the valid range is 1, 3, 6\nIf periodUnit is year, the valid range is 1, 2, 3"
    },
    "AllowedValues": [
      1,
      2,
      3,
      6
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "bot_web_protection" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Bot management module for Web application protection."
    },
    "Label": {
      "en": "BotWebProtection",
      "zh-cn": "是否开启Bot管理Web防护"
    }
  }
  EOT
}

variable "traffic_billing_protection_threshold" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "In pay-as-you-go WAF 3.0, the traffic billing protection feature is automatically enabled to prevent unexpected and unusually high bills that result from unpredictable factors such as HTTP flood attacks. A bill is not generated for an hour if the peak traffic exceeds the traffic billing protection threshold within the hour. Then, your WAF instance is added to a sandbox. If the peak traffic is lower than the traffic billing protection threshold the next hour, your WAF instance is removed from the sandbox."
    },
    "MinValue": 1000,
    "Label": {
      "en": "TrafficBillingProtectionThreshold",
      "zh-cn": "流量计费保护阈值"
    },
    "MaxValue": 100000
  }
  EOT
}

variable "api_security" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The API security feature detects responses with specified characteristics to check whether data leaks occur. After you enable the feature, WAF is authorized to perform related analysis on your data. If you select Chinese Mainland, service deployment and data processing are performed in the Chinese mainland."
    },
    "Label": {
      "en": "ApiSecurity",
      "zh-cn": "是否开启API安全"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "PayAsYouGo"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Subscription": {
          "Month": [
            1,
            3,
            6
          ],
          "Year": [
            1,
            2,
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the firewall instance. Valid values:\nPayAsYouGo: pay-as-you-go\nSubscription: subscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费模式"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to auto pay the bill."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动付款"
    }
  }
  EOT
}

variable "log_storage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Log storage capacity."
    },
    "MinValue": 3,
    "Label": {
      "en": "LogStorage",
      "zh-cn": "日志存储容量"
    },
    "MaxValue": 150
  }
  EOT
}

variable "elastic_qps" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The burstable QPS (pay-as-you-go) feature is suitable for scenarios that involve short-term or sudden traffic surges, for example, during promotions. In these scenarios, the traffic peak may exceed the sum of the maximum QPS that is supported by your WAF edition and the extended QPS. If you enable the feature, you are charged based on the amount of excess QPS resources that you use. This helps prevent your domain names from being added to a sandbox when QPS resources are excessively used and helps ensure service continuity."
    },
    "MinValue": 0,
    "Label": {
      "en": "ElasticQps",
      "zh-cn": "弹性后付费QPS"
    },
    "MaxValue": 60000
  }
  EOT
}

variable "domains_extension" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "If the actual number of required access domain names exceeds the number of free domain names in the version, the number of domain names can be expanded according to this specification.Domain name counting does not differentiate between domain name types. The main domain name, sub-domain name, and pan-domain name are each counted as one domain name."
    },
    "MinValue": 0,
    "Label": {
      "en": "DomainsExtension",
      "zh-cn": "域名扩展"
    },
    "MaxValue": 5000
  }
  EOT
}

variable "waf_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of WAF3.0.\n"
    },
    "AllowedValues": [
      "Basic",
      "Pro",
      "Enterprise",
      "Ultimate"
    ],
    "Label": {
      "en": "WafVersion",
      "zh-cn": "Web应用防火墙3.0版本"
    }
  }
  EOT
}

variable "additional_protection_nodes" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Each protection cluster has at least two protection nodes, and each node provides the protection capabilities of up to 5,000 QPS for HTTP requests or up to 3,000 QPS for HTTPS requests. You can add protection nodes to increase protection capabilities. "
    },
    "MinValue": 0,
    "Label": {
      "en": "AdditionalProtectionNodes",
      "zh-cn": "多云或混合云防护扩展节点"
    },
    "MaxValue": 500
  }
  EOT
}

variable "exclusiveipaddress" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Excluesive IP address number."
    },
    "MinValue": 0,
    "Label": {
      "en": "ExclusiveIPAddress",
      "zh-cn": "独享IP数量"
    },
    "MaxValue": 100
  }
  EOT
}

variable "region" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "OutsideChineseMainland",
      "ChineseMainland"
    ],
    "Description": {
      "en": "Web Application Firewall is available in the following regions: regions in the Chinese mainland, China (Hong Kong), Singapore (Singapore), Malaysia (Kuala Lumpur), US (Silicon Valley), Australia (Sydney), Germany (Frankfurt), India (Mumbai), Indonesia (Jakarta), UAE (Dubai), and Japan (Tokyo).\n If your origin server is deployed within the Chinese mainland, select Chinese Mainland. If your origin server is deployed outside the Chinese mainland, select Outside Chinese mainland. Intelligent region selection is supported."
    },
    "Label": {
      "en": "Region",
      "zh-cn": "Web应用防火墙3.0支持的地区"
    }
  }
  EOT
}

variable "qps_extension" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Extended QPS."
    },
    "MinValue": 0,
    "Label": {
      "en": "QpsExtension",
      "zh-cn": "QPS扩展"
    },
    "MaxValue": 30000
  }
  EOT
}

variable "fraud_detection" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "You can enable this feature only after you enable the bot management module. If abnormal phone numbers are used in logon or registration scenarios, anomaly tags are matched. Requests from the abnormal phone numbers are blocked or CAPTCHA verification is required. You are charged based on the number of times that anomaly tags are matched. "
    },
    "Label": {
      "en": "FraudDetection",
      "zh-cn": "是否启动风险识别"
    }
  }
  EOT
}

variable "bot_app_protection" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Bot management module for App protection."
    },
    "Label": {
      "en": "BotAppProtection",
      "zh-cn": "是否开启Bot管理APP防护"
    }
  }
  EOT
}

variable "log_service" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Log service for WAF instance."
    },
    "Label": {
      "en": "LogService",
      "zh-cn": "WAF实例是否支持日志服务"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "订阅持续时间的单位"
    }
  }
  EOT
}

resource "alicloud_wafv3_instance" "instance" {}

output "instance_id" {
  value       = alicloud_wafv3_instance.instance.id
  description = "Instance Id."
}

