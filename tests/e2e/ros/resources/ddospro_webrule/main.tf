variable "rs_type" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      0,
      1
    ],
    "Description": {
      "en": "The address type of the origin server. Valid values:\n0: IP address\n1: domain name The domain name of the origin server is returned if you deploy proxies, such as Web Application Firewall (WAF), between the origin server and the instance. In this case, the address of the proxy, such as the CNAME provided by WAF, is returned."
    },
    "Label": {
      "en": "RsType",
      "zh-cn": "源站服务器的地址类型"
    }
  }
  EOT
}

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
      "zh-cn": "DDoS高防实例在资源管理服务中所属的资源组ID"
    }
  }
  EOT
}

variable "defense_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the associated defense. This parameter applies to scenarios in which other cloud services, such as Object Storage Service (OSS), are integrated with Anti-DDoS Pro or Anti-DDoS Premium."
    },
    "Label": {
      "en": "DefenseId",
      "zh-cn": "要关联的防护ID"
    }
  }
  EOT
}

variable "domain" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The domain name of the website that you want to add to the instance."
    },
    "Label": {
      "en": "Domain",
      "zh-cn": "要接入DDoS高防进行防护的网站域名"
    }
  }
  EOT
}

variable "instance_ids" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of the instance that you want to associate. If you do not specify this parameter, only the domain name of the website is added but no instance is associated with the website."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "An array consisting of the IDs of instances that you want to associate."
    },
    "Label": {
      "en": "InstanceIds",
      "zh-cn": "要关联的DDoS高防实例的ID列表"
    },
    "MinLength": 0,
    "MaxLength": 100
  }
  EOT
}

variable "rules" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The details of the forwarding rule. The value is a string that consists of JSON arrays. Each element in a JSON array is a JSON struct that contains the following fields: \nProxyRules: the information about the origin server. The information includes the port number and IP address. This field is required and must be a JSON array. Each element in a JSON array is a JSON struct that contains the following fields: ProxyPort: the port number. This field is required and must be an integer; RealServers: the IP address. This field is required and must be a string array.\nProxyType: the protocol type. This field is required and must be a string. Valid values: http, https, websocket, and websockets."
    },
    "Label": {
      "en": "Rules",
      "zh-cn": "网站业务转发规则的详细配置"
    }
  }
  EOT
}

variable "https_ext" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The advanced HTTPS settings. This parameter takes effect only when the value of the ProxyType parameter includes https. The value is a string that consists of a JSON struct. The JSON struct contains the following fields: \nHttp2https: specifies whether to turn on Enforce HTTPS Routing. This field is optional and must be an integer. Valid values: 0 and 1. The value 0 indicates that Enforce HTTPS Routing is turned off. The value 1 indicates that Enforce HTTPS Routing is turned on. The default value is 0. If your website supports both HTTP and HTTPS, this feature meets your business requirements. If you enable this feature, all HTTP requests to access the website are redirected to HTTPS requests on the standard port 443.\nHttps2http: specifies whether to turn on Enable HTTP. This field is optional and must be an integer. Valid values: 0 and 1. The value 0 indicates that Enable HTTP is turned off. The value 1 indicates that Enable HTTP is turned on. The default value is 0. If your website does not support HTTPS, this feature meets your business requirements If this feature is enabled, all HTTPS requests are redirected to HTTP requests and forwarded to origin servers. This feature can redirect WebSockets requests to WebSocket requests. Requests are redirected over the standard port 80.\nHttp2: specifies whether to turn on Enable HTTP/2. This field is optional and must be an integer. Valid values: 0 and 1. The value 0 indicates that Enable HTTP/2 is turned off. The value 1 indicates that Enable HTTP/2 is turned on. The default value is 0. After you turn on Enable HTTP/2, the protocol type is HTTP/2.",
      "zh-cn": "HTTPS 高级设置，仅在网站协议类型支持 HTTPS（ProxyType包含https）时生效。"
    },
    "Label": {
      "en": "HttpsExt",
      "zh-cn": "HTTPS 高级设置"
    }
  }
  EOT
}

resource "alicloud_ddoscoo_domain_resource" "extension_resource" {
  rs_type      = var.rs_type
  domain       = var.domain
  instance_ids = var.instance_ids
  https_ext    = var.https_ext
}

