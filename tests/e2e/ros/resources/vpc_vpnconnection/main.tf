variable "local_subnet" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "A network segment on the VPC side that needs to be interconnected with the local IDC for the second phase negotiation.\nMultiple network segments are separated by commas, for example: 192.168.1.0/24, 192.168.2.0/24.",
      "zh-cn": "和本地IDC互连的VPC侧的网段，用于第二阶段协商。"
    },
    "Label": {
      "en": "LocalSubnet",
      "zh-cn": "和本地IDC互连的VPC侧的网段"
    }
  }
  EOT
}

variable "customer_gateway_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the user gateway."
    },
    "Label": {
      "en": "CustomerGatewayId",
      "zh-cn": "用户网关的ID"
    }
  }
  EOT
}

variable "enable_tunnels_bgp" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the BGP feature for the tunnel. \nValid values: true and false. Default value: false."
    },
    "Label": {
      "en": "EnableTunnelsBgp",
      "zh-cn": "隧道BGP的开启状态"
    }
  }
  EOT
}

variable "auto_config_route" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically configure routes. Valid values:\ntrue (default) \nfalse"
    },
    "Label": {
      "en": "AutoConfigRoute",
      "zh-cn": "是否自动配置路由"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the IPsec connection.\nThe length is 2-128 characters and must start with a letter or Chinese. It can contain numbers, periods (.), underscores (_) and dashes (-), but cannot start with http:// or https:// ."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "IPsec连接的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

variable "effect_immediately" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to delete the currently negotiated IPsec tunnel and re-initiate the negotiation. Value:\nTrue: Negotiate immediately after the configuration is complete.\nFalse (default): Negotiate when traffic enters."
    },
    "Label": {
      "en": "EffectImmediately",
      "zh-cn": "是否删除当前已协商成功的IPsec隧道并重新发起协商"
    }
  }
  EOT
}

variable "bgp_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "EnableBgp": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable the BGP feature for the tunnel. \nValid values: true and false. Default value: false."
          },
          "Required": false
        },
        "LocalAsn": {
          "Type": "Number",
          "Description": {
            "en": "the ASN on the Alibaba Cloud side. Valid values: 1 to 4294967295. Default value: 45104."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 4294967295
        },
        "TunnelCidr": {
          "Type": "String",
          "Description": {
            "en": "the CIDR block of the IPsec tunnel. The CIDR block must fall within 169.254.0.0/16. The subnet mask of the CIDR block must be 30 bits in length."
          },
          "Required": false
        },
        "LocalBgpIp": {
          "Type": "String",
          "Description": {
            "en": "the BGP IP address on the Alibaba Cloud side. \nThis IP address must fall within the CIDR block of the IPsec tunnel."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The Border Gateway Protocol (BGP) configuration.\nThis parameter is required when the VPN gateway has dynamic BGP enabled.\nBefore you configure BGP, we recommend that you learn about how BGP works and its limits. For more information, see VPN Gateway supports BGP dynamic routing.\nWe recommend that you use a private ASN to establish a connection with Alibaba Cloud over BGP. \nRefer to the relevant documentation for the private ASN range."
    },
    "Label": {
      "en": "BgpConfig",
      "zh-cn": "隧道的BGP配置信息"
    }
  }
  EOT
}

variable "tunnel_options_specification" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Role": {
              "Type": "String",
              "Description": {
                "en": "The tunnel role. Valid values: master|slave"
              },
              "AllowedValues": [
                "master",
                "slave"
              ],
              "Required": false
            },
            "TunnelIkeConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "IkeAuthAlg": {
                    "Type": "String",
                    "Description": {
                      "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is md5|sha1|sha256|sha384|sha512, and the default value is md5.\nIf the VPN gateway instance type is national secret type, The value is sm3 (default value)."
                    },
                    "AllowedValues": [
                      "md5",
                      "sha1",
                      "sha256",
                      "sha384",
                      "sha512",
                      "sm3"
                    ],
                    "Required": false
                  },
                  "LocalId": {
                    "Type": "String",
                    "Description": {
                      "en": "ID of the VPN gateway. The length is limited to 100 characters. The default value is the public IP address of the VPN gateway."
                    },
                    "Required": false,
                    "MaxLength": 100
                  },
                  "IkeEncAlg": {
                    "Type": "String",
                    "Description": {
                      "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is aes|aes192|aes256|des|3des, and the default value is aes.\nIf the VPN gateway instance type is national secret type, The value is sm4 (default value)."
                    },
                    "AllowedValues": [
                      "aes",
                      "aes192",
                      "aes256",
                      "des",
                      "3des",
                      "sm4"
                    ],
                    "Required": false
                  },
                  "IkeVersion": {
                    "Type": "String",
                    "Description": {
                      "en": "The version of the IKE protocol. Value: ikev1|ikev2, default: ikev1."
                    },
                    "AllowedValues": [
                      "ikev1",
                      "ikev2"
                    ],
                    "Required": false,
                    "Default": "ikev1"
                  },
                  "IkeMode": {
                    "Type": "String",
                    "Description": {
                      "en": "Negotiation mode for IKE V1. Value: main|aggressive, default: main."
                    },
                    "AllowedValues": [
                      "main",
                      "aggressive"
                    ],
                    "Required": false,
                    "Default": "main"
                  },
                  "IkeLifetime": {
                    "Type": "Number",
                    "Description": {
                      "en": "The life cycle of the SA negotiated in the first phase. The value ranges from 0 to 86400, in seconds. The default value is 86400."
                    },
                    "Required": false,
                    "MinValue": 0,
                    "MaxValue": 86400,
                    "Default": 86400
                  },
                  "RemoteId": {
                    "Type": "String",
                    "Description": {
                      "en": "ID of the user gateway. The length is limited to 100 characters. The default value is the public IP address of the user gateway."
                    },
                    "Required": false,
                    "MaxLength": 100
                  },
                  "Psk": {
                    "Type": "String",
                    "Description": {
                      "en": "Used for identity authentication between the IPsec VPN gateway and the user gateway. It is generated randomly by default, or you can specify the key manually. The length is limited to 100 characters."
                    },
                    "Required": false,
                    "MaxLength": 100
                  },
                  "IkePfs": {
                    "Type": "String",
                    "Description": {
                      "en": "Diffie-Hellman key exchange algorithm used in the first phase negotiation. Value: group1|group2|group5|group14|group24, default value: group2."
                    },
                    "AllowedValues": [
                      "group1",
                      "group2",
                      "group5",
                      "group14",
                      "group24"
                    ],
                    "Required": false,
                    "Default": "group2"
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Configuration information for the first phase of negotiation."
              },
              "Required": false
            },
            "CustomerGatewayId": {
              "Type": "String",
              "Description": {
                "en": "The ID of the customer gateway."
              },
              "Required": false
            },
            "TunnelBgpConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "LocalAsn": {
                    "Type": "Number",
                    "Description": {
                      "en": "the ASN on the Alibaba Cloud side. Valid values: 1 to 4294967295. Default value: 45104."
                    },
                    "Required": false,
                    "MinValue": 1,
                    "MaxValue": 4294967295
                  },
                  "TunnelCidr": {
                    "Type": "String",
                    "Description": {
                      "en": "the CIDR block of the IPsec tunnel. The CIDR block must fall within 169.254.0.0/16. The subnet mask of the CIDR block must be 30 bits in length."
                    },
                    "Required": false
                  },
                  "LocalBgpIp": {
                    "Type": "String",
                    "Description": {
                      "en": "the BGP IP address on the Alibaba Cloud side. \nThis IP address must fall within the CIDR block of the IPsec tunnel."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The BGP configurations."
              },
              "Required": false
            },
            "RemoteCaCertificate": {
              "Type": "String",
              "Description": {
                "en": "The peer CA certificate when a ShangMi (SM) VPN gateway is used to establish the IPsec-VPN connection. \nThis parameter is required when an SM VPN gateway is used to establish the IPsec-VPN connection. \nYou can ignore this parameter when a standard VPN gateway is used to create the IPsec-VPN connection."
              },
              "Required": false
            },
            "EnableNatTraversal": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to enable NAT traversal. Valid values: \ntrue (default) After NAT traversal is enabled, the initiator does not check the UDP ports during IKE negotiations and can automatically discover NAT gateway devices along the VPN tunnel. \nfalse"
              },
              "Required": false
            },
            "TunnelIpsecConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "IpsecPfs": {
                    "Type": "String",
                    "Description": {
                      "en": "Forwards all protocol packets. The Diffie-Hellman key exchange algorithm used in the first phase negotiation, the value: group1|group2|group5|group14|group24, default value: group2."
                    },
                    "AllowedValues": [
                      "disabled",
                      "group1",
                      "group2",
                      "group5",
                      "group14",
                      "group24"
                    ],
                    "Required": false,
                    "Default": "group2"
                  },
                  "IpsecEncAlg": {
                    "Type": "String",
                    "Description": {
                      "en": "The authentication algorithm negotiated in the second phase. \nIf the VPN gateway instance type is normal, the value is aes|aes192|aes256|des|3des, and the default value is aes.\nIf the VPN gateway instance type is national secret type, The value is sm4 (default value)."
                    },
                    "AllowedValues": [
                      "aes",
                      "aes192",
                      "aes256",
                      "des",
                      "3des",
                      "sm4"
                    ],
                    "Required": false
                  },
                  "IpsecAuthAlg": {
                    "Type": "String",
                    "Description": {
                      "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is md5|sha1|sha256|sha384|sha512, and the default value is md5.\nIf the VPN gateway instance type is national secret type, The value is sm3 (default value)."
                    },
                    "AllowedValues": [
                      "md5",
                      "sha1",
                      "sha256",
                      "sha384",
                      "sha512",
                      "sm3"
                    ],
                    "Required": false
                  },
                  "IpsecLifetime": {
                    "Type": "Number",
                    "Description": {
                      "en": "IpsecLifetime: The life cycle of the SA negotiated in the second phase. The value ranges from 0 to 86400, in seconds. The default value is 86400."
                    },
                    "Required": false,
                    "MinValue": 0,
                    "MaxValue": 86400,
                    "Default": 86400
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of Phase 2 negotiations."
              },
              "Required": false
            },
            "EnableDpd": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to enable the dead peer detection (DPD) feature. Valid values: \ntrue (default) The initiator of the IPsec-VPN connection sends DPD packets to verify the existence and availability of the peer. If no response is received from the peer within a specified period of time, the connection fails. ISAKMP SAs and IPsec SAs are deleted. The IPsec tunnel is also deleted. \nfalse: disables DPD. The IPsec initiator does not send DPD packets."
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "TunnelOptionsSpecification parameters are supported by dual-tunnel IPsec-VPN gateways. \nYou can modify both the active and standby tunnels of the IPsec-VPN connection."
    },
    "Label": {
      "en": "TunnelOptionsSpecification",
      "zh-cn": "IPsec连接的隧道配置信息"
    }
  }
  EOT
}

variable "remote_subnet" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The network segment of the local IDC is used for the second phase negotiation.\nMultiple network segments are separated by commas, for example: 192.168.3.0/24, 192.168.4.0/24.",
      "zh-cn": "本地IDC的网段，用于第二阶段协商。"
    },
    "Label": {
      "en": "RemoteSubnet",
      "zh-cn": "本地IDC的网段"
    }
  }
  EOT
}

variable "vpn_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ID of the VPN gateway."
    },
    "Label": {
      "en": "VpnGatewayId",
      "zh-cn": "VPN网关的ID"
    }
  }
  EOT
}

variable "ipsec_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IpsecPfs": {
          "Type": "String",
          "Description": {
            "en": "Forwards all protocol packets. The Diffie-Hellman key exchange algorithm used in the first phase negotiation, the value: group1|group2|group5|group14|group24, default value: group2."
          },
          "AllowedValues": [
            "disabled",
            "group1",
            "group2",
            "group5",
            "group14",
            "group24"
          ],
          "Required": false,
          "Default": "group2"
        },
        "IpsecEncAlg": {
          "Type": "String",
          "Description": {
            "en": "The authentication algorithm negotiated in the second phase. \nIf the VPN gateway instance type is normal, the value is aes|aes192|aes256|des|3des, and the default value is aes.\nIf the VPN gateway instance type is national secret type, The value is sm4 (default value)."
          },
          "AllowedValues": [
            "aes",
            "aes192",
            "aes256",
            "des",
            "3des",
            "sm4"
          ],
          "Required": false
        },
        "IpsecAuthAlg": {
          "Type": "String",
          "Description": {
            "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is md5|sha1|sha256|sha384|sha512, and the default value is md5.\nIf the VPN gateway instance type is national secret type, The value is sm3 (default value)."
          },
          "AllowedValues": [
            "md5",
            "sha1",
            "sha256",
            "sha384",
            "sha512",
            "sm3"
          ],
          "Required": false
        },
        "IpsecLifetime": {
          "Type": "Number",
          "Description": {
            "en": "IpsecLifetime: The life cycle of the SA negotiated in the second phase. The value ranges from 0 to 86400, in seconds. The default value is 86400."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 86400,
          "Default": 86400
        }
      }
    },
    "Description": {
      "en": "Configuration information for the second phase negotiation."
    },
    "Label": {
      "en": "IpsecConfig",
      "zh-cn": "第二阶段协商的配置信息"
    }
  }
  EOT
}

variable "remote_ca_certificate" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The peer CA certificate when a ShangMi (SM) VPN gateway is used to establish the IPsec-VPN connection. \nThis parameter is required when an SM VPN gateway is used to establish the IPsec-VPN connection. \nYou can ignore this parameter when a standard VPN gateway is used to create the IPsec-VPN connection."
    },
    "Label": {
      "en": "RemoteCaCertificate",
      "zh-cn": "对端的CA证书"
    }
  }
  EOT
}

variable "health_check_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Policy": {
          "Type": "String",
          "Description": {
            "en": "Whether to revoke published routes when the health check fails."
          },
          "Required": false
        },
        "Enable": {
          "Type": "Boolean",
          "Required": false
        },
        "Dip": {
          "Type": "String",
          "Required": false
        },
        "Retry": {
          "Type": "Number",
          "Required": false
        },
        "Sip": {
          "Type": "String",
          "Required": false
        },
        "Interval": {
          "Type": "Number",
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Whether to enable the health check configuration."
    },
    "Label": {
      "en": "HealthCheckConfig",
      "zh-cn": "健康检查的配置信息"
    }
  }
  EOT
}

variable "enable_nat_traversal" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable NAT traversal. Valid values: \ntrue (default) After NAT traversal is enabled, the initiator does not check the UDP ports during IKE negotiations and can automatically discover NAT gateway devices along the VPN tunnel. \nfalse"
    },
    "Label": {
      "en": "EnableNatTraversal",
      "zh-cn": "隧道是否已开启NAT穿越功能"
    }
  }
  EOT
}

variable "ike_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IkeAuthAlg": {
          "Type": "String",
          "Description": {
            "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is md5|sha1|sha256|sha384|sha512, and the default value is md5.\nIf the VPN gateway instance type is national secret type, The value is sm3 (default value)."
          },
          "AllowedValues": [
            "md5",
            "sha1",
            "sha256",
            "sha384",
            "sha512",
            "sm3"
          ],
          "Required": false
        },
        "LocalId": {
          "Type": "String",
          "Description": {
            "en": "ID of the VPN gateway. The length is limited to 100 characters. The default value is the public IP address of the VPN gateway."
          },
          "Required": false,
          "MaxLength": 100
        },
        "IkeEncAlg": {
          "Type": "String",
          "Description": {
            "en": "The authentication algorithm negotiated in the first phase. \nIf the VPN gateway instance type is normal, the value is aes|aes192|aes256|des|3des, and the default value is aes.\nIf the VPN gateway instance type is national secret type, The value is sm4 (default value)."
          },
          "AllowedValues": [
            "aes",
            "aes192",
            "aes256",
            "des",
            "3des",
            "sm4"
          ],
          "Required": false
        },
        "LocalIdIPsec": {
          "Type": "String",
          "Description": {
            "en": "ID of the VPN gateway. The length is limited to 100 characters. The default value is the public IP address of the VPN gateway."
          },
          "Required": false,
          "MaxLength": 100
        },
        "IkeVersion": {
          "Type": "String",
          "Description": {
            "en": "The version of the IKE protocol. Value: ikev1|ikev2, default: ikev1."
          },
          "AllowedValues": [
            "ikev1",
            "ikev2"
          ],
          "Required": false,
          "Default": "ikev1"
        },
        "IkeMode": {
          "Type": "String",
          "Description": {
            "en": "Negotiation mode for IKE V1. Value: main|aggressive, default: main."
          },
          "AllowedValues": [
            "main",
            "aggressive"
          ],
          "Required": false,
          "Default": "main"
        },
        "IkeLifetime": {
          "Type": "Number",
          "Description": {
            "en": "The life cycle of the SA negotiated in the first phase. The value ranges from 0 to 86400, in seconds. The default value is 86400."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 86400,
          "Default": 86400
        },
        "RemoteId": {
          "Type": "String",
          "Description": {
            "en": "ID of the user gateway. The length is limited to 100 characters. The default value is the public IP address of the user gateway."
          },
          "Required": false,
          "MaxLength": 100
        },
        "Psk": {
          "Type": "String",
          "Description": {
            "en": "Used for identity authentication between the IPsec VPN gateway and the user gateway. It is generated randomly by default, or you can specify the key manually. The length is limited to 100 characters."
          },
          "Required": false,
          "MaxLength": 100
        },
        "IkePfs": {
          "Type": "String",
          "Description": {
            "en": "Diffie-Hellman key exchange algorithm used in the first phase negotiation. Value: group1|group2|group5|group14|group24, default value: group2."
          },
          "AllowedValues": [
            "group1",
            "group2",
            "group5",
            "group14",
            "group24"
          ],
          "Required": false,
          "Default": "group2"
        }
      }
    },
    "Description": {
      "en": "Configuration information for the first phase of negotiation."
    },
    "Label": {
      "en": "IkeConfig",
      "zh-cn": "第一阶段协商的配置信息"
    }
  }
  EOT
}

variable "enable_dpd" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the dead peer detection (DPD) feature. Valid values: \ntrue (default) The initiator of the IPsec-VPN connection sends DPD packets to verify the existence and availability of the peer. If no response is received from the peer within a specified period of time, the connection fails. ISAKMP SAs and IPsec SAs are deleted. The IPsec tunnel is also deleted. \nfalse: disables DPD. The IPsec initiator does not send DPD packets."
    },
    "Label": {
      "en": "EnableDpd",
      "zh-cn": "IPsec连接是否已开启DPD（对等体存活检测）功能"
    }
  }
  EOT
}

resource "alicloud_vpn_connection" "vpn_connection" {
  local_subnet                 = var.local_subnet
  customer_gateway_id          = var.customer_gateway_id
  enable_tunnels_bgp           = var.enable_tunnels_bgp
  auto_config_route            = var.auto_config_route
  name                         = var.name
  effect_immediately           = var.effect_immediately
  tunnel_options_specification = var.tunnel_options_specification
  remote_subnet                = var.remote_subnet
  vpn_gateway_id               = var.vpn_gateway_id
  ipsec_config                 = var.ipsec_config
  enable_nat_traversal         = var.enable_nat_traversal
  ike_config                   = var.ike_config
  enable_dpd                   = var.enable_dpd
}

output "status" {
  value       = alicloud_vpn_connection.vpn_connection.status
  description = "Status of the IPsec connection."
}

output "peer_vpn_connection_config" {
  // Could not transform ROS Attribute PeerVpnConnectionConfig to Terraform attribute.
  value       = null
  description = "Peer vpc connection config."
}

output "vpn_connection_id" {
  value       = alicloud_vpn_connection.vpn_connection.id
  description = "ID of the IPsec connection."
}

