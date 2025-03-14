variable "threat_analysis" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Threat Analysis log storage capacity. Interval type, value interval:[0,9999999999].\n> This module can only be purchased when Threat_analysis_switch = 1. The step size is 10, that is, only multiples of 10 can be filled in."
    },
    "Label": {
      "en": "ThreatAnalysis",
      "zh-cn": "威胁分析日志存储量"
    }
  }
  EOT
}

variable "sas_sls_storage" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Log analysis storage capacity. Unit: GB. Interval type, value interval:[0,600000].\n> The step size is 10, that is, only multiples of 10 can be filled in."
    },
    "Label": {
      "en": "SasSlsStorage",
      "zh-cn": "日志分析存储容量"
    }
  }
  EOT
}

variable "container_image_scan" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Container Image security scan. Interval type, value interval:[0,200000].\n> The step size is 20, that is, only multiples of 20 can be filled in."
    },
    "Label": {
      "en": "ContainerImageScan",
      "zh-cn": "容器镜像安全扫描"
    }
  }
  EOT
}

variable "threat_analysis_switch" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Threat analysis. Value:\n- 0: No.\n- 1: Yes."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "ThreatAnalysisSwitch",
      "zh-cn": "是否配置威胁分析"
    }
  }
  EOT
}

variable "vcore" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Number of cores."
    },
    "Label": {
      "en": "VCore",
      "zh-cn": "核数"
    }
  }
  EOT
}

variable "renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal cycle, in months.\n> When **RenewalStatus** is set to **AutoRenewal**, it must be set."
    },
    "Label": {
      "en": "RenewPeriod",
      "zh-cn": "自动续费周期"
    }
  }
  EOT
}

variable "sas_sc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security screen. Value:\n- true: Yes.\n- false: No."
    },
    "AllowedValues": [
      "false",
      "true"
    ],
    "Label": {
      "en": "SasSc",
      "zh-cn": "是否配置安全大屏"
    }
  }
  EOT
}

variable "sas_cspm_switch" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cloud platform configuration check switch. Value:\n- 0: No.\n- 1: Yes."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "SasCspmSwitch",
      "zh-cn": "云平台配置检查开关"
    }
  }
  EOT
}

variable "buy_number" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Number of servers."
    },
    "Label": {
      "en": "BuyNumber",
      "zh-cn": "保有服务器台数"
    }
  }
  EOT
}

variable "sas_webguard_boolean" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Web tamper-proof switch. Value:\n- 0: No.\n- 1: Yes."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "SasWebguardBoolean",
      "zh-cn": "是否配置网页防篡改开关"
    }
  }
  EOT
}

variable "honeypot_switch" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cloud honeypot. Value:\n- 1: Yes.\n- 2: No."
    },
    "AllowedValues": [
      "1",
      "2"
    ],
    "Label": {
      "en": "HoneypotSwitch",
      "zh-cn": "是否配置云蜜罐"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Description": {
      "en": "The payment type of the resource."
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "sas_sdk" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Number of malicious file detections. Unit: 10,000 times. Interval type, value interval:[10,9999999999].\n> This module can only be purchased when sas_sdk_switch = 1. The step size is 10, that is, only multiples of 10 can be filled in."
    },
    "Label": {
      "en": "SasSdk",
      "zh-cn": "恶意文件检测次数"
    }
  }
  EOT
}

variable "sas_anti_ransomware" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Anti-ransomware capacity. Unit: GB. Interval type, value interval:[0,9999999999].\n> The step size is 10, that is, only multiples of 10 can be filled in."
    },
    "Label": {
      "en": "SasAntiRansomware",
      "zh-cn": "防勒索容量"
    }
  }
  EOT
}

variable "sas_webguard_order_num" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Tamper-proof authorization number. Value:\n- 0: No\n- 1: Yes."
    },
    "Label": {
      "en": "SasWebguardOrderNum",
      "zh-cn": "防篡改授权数"
    }
  }
  EOT
}

variable "renewal_status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal status, value:\n- AutoRenewal: automatic renewal.\n- ManualRenewal: manual renewal.\nDefault ManualRenewal."
    },
    "AllowedValues": [
      "AutoRenewal",
      "ManualRenewal"
    ],
    "Label": {
      "en": "RenewalStatus",
      "zh-cn": "自动续费状态"
    }
  }
  EOT
}

variable "product_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Product type, only China station needs to be set to sas, international station does not need to set."
    },
    "Label": {
      "en": "ProductType",
      "zh-cn": "产品类型"
    }
  }
  EOT
}

variable "vul_switch" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Vulnerability fix switch. Value:\n- 0: No.\n- 1: Yes.\n> When the value of version_code is level7 or level10, the purchase is allowed. Other versions do not need to be purchased separately."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "VulSwitch",
      "zh-cn": "是否配置漏洞修复开关"
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
      "en": "Prepaid cycle. The unit is Monthly, please enter an integer multiple of 12 for annual paid products.\n> must be set when creating a prepaid instance."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "预付费周期"
    }
  }
  EOT
}

variable "rasp_count" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Number of application protection licenses. Interval type, value interval:[1,100000000]."
    },
    "Label": {
      "en": "RaspCount",
      "zh-cn": "应用防护授权数"
    }
  }
  EOT
}

variable "vul_count" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Vulnerability repair times, interval type, value range:[20,100000000].\n> This module can only be purchased when vul_switch = 1. Only when the version_code value is level7 or level10. other versions do not need to be purchased separately."
    },
    "Label": {
      "en": "VulCount",
      "zh-cn": "漏洞修复次数"
    }
  }
  EOT
}

variable "version_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "level2",
      "level8",
      "level7",
      "level3",
      "level10"
    ],
    "Description": {
      "en": "Select the security center version. Value:\n- level7: Antivirus Edition.\n- level3: Premium version.\n- level2: Enterprise Edition.\n- level8: Ultimate.\n- level10: Purchase value-added services only."
    },
    "Label": {
      "en": "VersionCode",
      "zh-cn": "云安全中心版本选择"
    }
  }
  EOT
}

variable "sas_cspm" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cloud platform configuration check scan times, interval type, value range:[1000,9999999999].\n> You must have sas_cspm_switch = 1 to purchase this module. The step size is 100, that is, only multiples of 10 can be filled in."
    },
    "Label": {
      "en": "SasCspm",
      "zh-cn": "云平台配置检查扫描次数"
    }
  }
  EOT
}

variable "modify_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Change configuration type, value\n- Upgrade: Upgrade.\n- Downgrade: Downgrade."
    },
    "AllowedValues": [
      "Upgrade",
      "Downgrade"
    ],
    "Label": {
      "en": "ModifyType",
      "zh-cn": "变配类型"
    }
  }
  EOT
}

variable "sas_sdk_switch" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Malicious file detection SDK."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "SasSdkSwitch",
      "zh-cn": "是否配置恶意文件检测SDK"
    }
  }
  EOT
}

variable "renewal_period_unit" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal period unit, value:\n- M: month.\n- Y: years.\n> Must be set when RenewalStatus = AutoRenewal."
    },
    "AllowedValues": [
      "M",
      "Y"
    ],
    "Label": {
      "en": "RenewalPeriodUnit",
      "zh-cn": "自动续费周期单位"
    }
  }
  EOT
}

variable "container_image_scan_new" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Container Image security scan. Interval type, value interval:[0,200000].\n> The step size is 20, that is, only multiples of 20 can be filled in."
    },
    "Label": {
      "en": "ContainerImageScanNew",
      "zh-cn": "容器镜像安全扫描次数"
    }
  }
  EOT
}

variable "honeypot" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Number of cloud honeypot licenses. Interval type, value interval:[20,500].\n> This module can only be purchased when honeypot_switch = 1, starting with 20."
    },
    "Label": {
      "en": "Honeypot",
      "zh-cn": "云蜜罐授权数"
    }
  }
  EOT
}

resource "alicloud_threat_detection_instance" "extension_resource" {
  threat_analysis          = var.threat_analysis
  sas_sls_storage          = var.sas_sls_storage
  container_image_scan     = var.container_image_scan
  threat_analysis_switch   = var.threat_analysis_switch
  v_core                   = var.vcore
  renew_period             = var.renew_period
  sas_cspm_switch          = var.sas_cspm_switch
  buy_number               = var.buy_number
  sas_webguard_boolean     = var.sas_webguard_boolean
  honeypot_switch          = var.honeypot_switch
  payment_type             = var.payment_type
  sas_sdk                  = var.sas_sdk
  sas_anti_ransomware      = var.sas_anti_ransomware
  sas_webguard_order_num   = var.sas_webguard_order_num
  renewal_status           = var.renewal_status
  vul_switch               = var.vul_switch
  period                   = var.period
  rasp_count               = var.rasp_count
  vul_count                = var.vul_count
  version_code             = var.version_code
  sas_cspm                 = var.sas_cspm
  modify_type              = var.modify_type
  sas_sdk_switch           = var.sas_sdk_switch
  renewal_period_unit      = var.renewal_period_unit
  container_image_scan_new = var.container_image_scan_new
  honeypot                 = var.honeypot
}

output "threat_analysis" {
  value       = alicloud_threat_detection_instance.extension_resource.threat_analysis
  description = "Threat Analysis log storage capacity. Interval type, value interval:[0,9999999999]."
}

output "sas_sls_storage" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_sls_storage
  description = "Log analysis storage capacity. Unit: GB. Interval type, value interval:[0,600000]."
}

output "container_image_scan" {
  value       = alicloud_threat_detection_instance.extension_resource.container_image_scan
  description = "Container Image security scan. Interval type, value interval:[0,200000]."
}

output "threat_analysis_switch" {
  value       = alicloud_threat_detection_instance.extension_resource.threat_analysis_switch
  description = "Threat analysis."
}

output "vcore" {
  value       = alicloud_threat_detection_instance.extension_resource.v_core
  description = "Number of cores."
}

output "renew_period" {
  value       = alicloud_threat_detection_instance.extension_resource.renew_period
  description = "Automatic renewal cycle, in months."
}

output "sas_sc" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_sc
  description = "Security screen."
}

output "sas_cspm_switch" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_cspm_switch
  description = "Cloud platform configuration check switch."
}

output "buy_number" {
  value       = alicloud_threat_detection_instance.extension_resource.buy_number
  description = "Number of servers."
}

output "sas_webguard_boolean" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_webguard_boolean
  description = "Web tamper-proof switch."
}

output "honeypot_switch" {
  value       = alicloud_threat_detection_instance.extension_resource.honeypot_switch
  description = "Cloud honeypot."
}

output "payment_type" {
  value       = alicloud_threat_detection_instance.extension_resource.payment_type
  description = "The payment type of the resource."
}

output "sas_sdk" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_sdk
  description = "Number of malicious file detections. Unit: 10,000 times. Interval type, value interval:[10,9999999999]."
}

output "sas_anti_ransomware" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_anti_ransomware
  description = "Anti-ransomware capacity. Unit: GB. Interval type, value interval:[0,9999999999]."
}

output "instance_id" {
  value       = alicloud_threat_detection_instance.extension_resource.id
  description = "The first ID of the resource."
}

output "sas_webguard_order_num" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_webguard_order_num
  description = "Tamper-proof authorization number."
}

output "create_time" {
  value       = alicloud_threat_detection_instance.extension_resource.create_time
  description = "The creation time of the resource."
}

output "renewal_status" {
  value       = alicloud_threat_detection_instance.extension_resource.renewal_status
  description = "Automatic renewal status, value:."
}

output "vul_switch" {
  value       = alicloud_threat_detection_instance.extension_resource.vul_switch
  description = "Vulnerability fix switch."
}

output "rasp_count" {
  value       = alicloud_threat_detection_instance.extension_resource.rasp_count
  description = "Number of application protection licenses. Interval type, value interval:[1,100000000]."
}

output "vul_count" {
  value       = alicloud_threat_detection_instance.extension_resource.vul_count
  description = "Vulnerability repair times, interval type, value range:[20,100000000]."
}

output "version_code" {
  value       = alicloud_threat_detection_instance.extension_resource.version_code
  description = "Select the security center version."
}

output "sas_cspm" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_cspm
  description = "Cloud platform configuration check scan times, interval type, value range:[1000,9999999999]."
}

output "sas_sdk_switch" {
  value       = alicloud_threat_detection_instance.extension_resource.sas_sdk_switch
  description = "Malicious file detection SDK."
}

output "renewal_period_unit" {
  value       = alicloud_threat_detection_instance.extension_resource.renewal_period_unit
  description = "Automatic renewal period unit, value:."
}

output "container_image_scan_new" {
  value       = alicloud_threat_detection_instance.extension_resource.container_image_scan_new
  description = "Container Image security scan. Interval type, value interval:[0,200000]."
}

output "honeypot" {
  value       = alicloud_threat_detection_instance.extension_resource.honeypot
  description = "Number of cloud honeypot licenses. Interval type, value interval:[20,500]."
}

