variable "origins" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Type": {
              "Type": "String",
              "Description": {
                "en": "Source station type:\nip_domain: ip or domain name type origin station;\n- `OSS`:OSS address source station;\n- `S3`:AWS S3 Source station."
              },
              "AllowedValues": [
                "ip_domain",
                "OSS",
                "S3"
              ],
              "Required": false
            },
            "Header": {
              "Type": "String",
              "Description": {
                "en": "The request header that is sent when returning to the source. Only Host is supported."
              },
              "Required": false
            },
            "Address": {
              "Type": "String",
              "Description": {
                "en": "Origin Address."
              },
              "Required": false
            },
            "Enabled": {
              "Type": "Boolean",
              "Description": {
                "en": "Whether the source station is enabled:\n- `true`: Enabled;\n- `false`: Not enabled."
              },
              "Required": false
            },
            "AuthConf": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "SecretKey": {
                    "Type": "String",
                    "Description": {
                      "en": "The SecretKey to be passed when AuthType is set to private_cross_account or private."
                    },
                    "Required": false
                  },
                  "Version": {
                    "Type": "String",
                    "Description": {
                      "en": "The signature version to be transmitted when the source station is AWS S3."
                    },
                    "Required": false
                  },
                  "Region": {
                    "Type": "String",
                    "Description": {
                      "en": "The Region of the source station to be transmitted when the source station is AWS S3."
                    },
                    "Required": false
                  },
                  "AccessKey": {
                    "Type": "String",
                    "Description": {
                      "en": "The AccessKey to be passed when AuthType is set to private_cross_account or private."
                    },
                    "Required": false
                  },
                  "AuthType": {
                    "Type": "String",
                    "Description": {
                      "en": "Authentication type.\n- `public`: public read/write, which is used when the source station is OSS or S3 and is public read/write;\n- `private_same_account`: Used when the same account is private, the source station is OSS, and the authentication type is private authentication of the same account;\n- `private_cross_account`: private cross-account, used when the origin station is OSS and the authentication type is cross-account private authentication;\n- `private`: Used when the source station is S3 and the authentication type is private."
                    },
                    "AllowedValues": [
                      "public",
                      "private_same_account",
                      "private_cross_account",
                      "private"
                    ],
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The authentication information. When the source Station is an OSS or S3 and other source stations need to be authenticated, the authentication-related configuration information needs to be transmitted."
              },
              "Required": false
            },
            "OriginId": {
              "Type": "Number",
              "Description": {
                "en": "Origin ID."
              },
              "Required": false
            },
            "Weight": {
              "Type": "Number",
              "Description": {
                "en": "The weight, an integer between 0 and 100."
              },
              "Required": false,
              "MinValue": 0,
              "MaxValue": 100
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The name of the origin, which must be unique within an origin address."
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "The Source station information added to the source address pool. Multiple Source stations use arrays to transfer values."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The Source station information added to the source address pool. Multiple Source stations use arrays to transfer values."
    },
    "Label": {
      "en": "Origins",
      "zh-cn": "源地址池里添加的源站信息"
    }
  }
  EOT
}

variable "site_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The site ID."
    },
    "Label": {
      "en": "SiteId",
      "zh-cn": "站点 ID"
    }
  }
  EOT
}

variable "enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the source address pool is enabled:\n- `true`: Enabled;\n- `false`: Not enabled."
    },
    "Label": {
      "en": "Enabled",
      "zh-cn": "源地址池是否启用"
    }
  }
  EOT
}

variable "origin_pool_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source address pool name."
    },
    "Label": {
      "en": "OriginPoolName",
      "zh-cn": "源地址池名称"
    }
  }
  EOT
}

resource "alicloud_esa_origin_pool" "extension_resource" {
  // The value var.origins of arguments origins is not block and will be ignore.
  site_id          = var.site_id
  enabled          = var.enabled
  origin_pool_name = var.origin_pool_name
}

output "origins" {
  value       = alicloud_esa_origin_pool.extension_resource.origins
  description = "The Source station information added to the source address pool. Multiple Source stations use arrays to transfer values."
}

output "origin_pool_id" {
  value       = alicloud_esa_origin_pool.extension_resource.origin_pool_id
  description = "OriginPool Id."
}

