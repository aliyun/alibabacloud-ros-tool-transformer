variable "deploy_type" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "DeployType"
    },
    "Description": {
      "en": "The deployment mode of the Message Queue for Apache Kafka instance. Valid values: \n  4: Instance of the public type \n  5: Instance of the VPC type"
    },
    "AllowedValues": [
      4,
      5
    ],
    "Label": {
      "en": "DeployType",
      "zh-cn": "部署类型"
    }
  }
  EOT
}

variable "eip_max" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The public traffic to be configured for the Message Queue for Apache Kafka instance. \nThis parameter must be specified when the DeployType parameter is set to 4."
    },
    "Label": {
      "en": "EipMax",
      "zh-cn": "公网流量"
    }
  }
  EOT
}

variable "spec_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SpecType"
    },
    "Description": {
      "en": "The edition of the Message Queue for Apache Kafka instance. Valid values: \nnormal: Normal version\nprofessional: Professional Edition (high writing edition)\nprofessionalForHighRead: Professional Edition (high reading edition)"
    },
    "AllowedValues": [
      "normal",
      "professional",
      "professionalForHighRead"
    ],
    "Label": {
      "en": "SpecType",
      "zh-cn": "规格类型"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "Hour"
  description = <<EOT
  {
    "Description": {
      "en": "Pay by hour or month."
    },
    "AllowedValues": [
      "Hour",
      "Month",
      "PrePaid",
      "PostPaid",
      "Serverless"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "partition_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Number of partitions(recommended).\nThe number of partitions to be configured for the Message Queue for Apache Kafka instance. \nPartitionNum and TopicQuota must be selected. \nIt is recommended that you only fill in the number of partitions.\n"
    },
    "Label": {
      "en": "PartitionNum",
      "zh-cn": "分区数（推荐）"
    }
  }
  EOT
}

variable "disk_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "Kafka_DiskType"
    },
    "Description": {
      "en": "The type of the disk to be configured for the Message Queue for Apache Kafka instance. Valid values: \n0: Ultra disk \n1: SSD"
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "DiskType",
      "zh-cn": "磁盘类型"
    }
  }
  EOT
}

variable "deploy_option" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "KMSKeyId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the KMS key that is used to encrypt the data disk. This parameter is supported only for instances of the VPC type."
          },
          "Required": false
        },
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "The ID of the zone where you want to deploy the instance. \nThe zone ID of the instance must be the same as that of the vSwitch."
          },
          "Required": false
        },
        "SelectedZones": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "The ID of the availability zone."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Select the primary availability zone candidate set for deployment and the two-dimensional array of the standby availability zone candidate set."
          },
          "Required": false,
          "MinLength": 0,
          "MaxLength": 2
        },
        "VSwitchIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Description": {
                "en": "The ID of the vSwitch."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "List of vSwitch IDs deployed by the instance. This parameter is required for V2 and V3 series instances. Confluent type instances support this parameter, and at least one of VSwitchIds and VSwitchId needs to be filled in. When both are filled in, VSwitchIds is used first."
          },
          "Required": false,
          "MinLength": 0,
          "MaxLength": 10
        },
        "Config": {
          "Type": "Json",
          "Description": {
            "en": "The initial configurations of the Message Queue for Apache Kafka instance. If you do not specify this parameter, it is left empty.The Config parameter supports the following parameters:\nenable.vpc_sasl_ssl: specifies whether to enable VPC transmission encryption. Valid values: \ntrue: indicates that VPC transmission encryption is enabled. If you enable VPC transmission encryption, enable access control list (ACL).\nfalse: indicates that VPC transmission encryption is disabled. By default, VPC transmission encryption is disabled.\n\nenable.acl: specifies whether to enable ACL. Valid values: \ntrue: indicates that ACL is enabled.\nfalse: indicates that ACL is disabled. By default, ACL is disabled.\n\nkafka.log.retention.hours: the maximum message retention period when the disk capacity is sufficient. Unit: hours. Valid values: 24 to 480. Default value: 72. When the disk usage reaches 85%, the disk capacity is considered insufficient, and the system deletes messages in the order in which messages are stored, from the earliest to latest.\n\nkafka.message.max.bytes: the maximum size of messages that Message Queue for Apache Kafka can send and receive. Unit: byte. Valid values: 1048576 to 10485760. Default value: 1048576. Before you modify the maximum message size, make sure that the new value is consistent with those on the producer and consumer."
          },
          "Required": false
        },
        "VSwitchId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${.VpcId}",
            "ZoneId": "$${.ZoneId}"
          },
          "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
          "Type": "String",
          "Description": {
            "en": "The ID of the vSwitch associated with the VPC."
          },
          "Required": true
        },
        "SecurityGroup": {
          "Type": "String",
          "Description": {
            "en": "The security group of the instance. \nIf you do not specify this parameter, Message Queue for Apache Kafka automatically \nconfigures a security group for the instance. If you specify this parameter, \nyou must create the specified security group in advance. \nFor more information, see Create a security group."
          },
          "Required": false
        },
        "IsSetUserAndPassword": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${DeployType}",
                  4
                ]
              }
            }
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to set a new user name and password for instance. Valid values:\n  true: Set a new user name and password.\n  false: Do not set a new user name and password.\nThis parameter is supported only for instances of the Internet and VPC type."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The new name of the instance."
          },
          "Required": false
        },
        "IsEipInner": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${DeployType}",
                  4
                ]
              }
            }
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the instance supports elastic IP addresses (EIPs). Valid values:\n  true: The instance supports EIP mode.\n  false: The instance does not support EIP mode.\nThis parameter must be consistent with the instance type. \nSet the parameter to true for instances of the Internet and VPC type or to false for instances of the VPC type."
          },
          "Required": false
        },
        "CrossZone": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable cross-zone deployment. Valid values: \ntrue: indicates that cross-zone deployment is enabled. \nfalse: indicates that cross-zone deployment is disabled. "
          },
          "Required": false
        },
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "The ID of the VPC on which you want to deploy the instance."
          },
          "Required": false
        },
        "Username": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${DeployType}",
                  4
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The new user name for the instance. \nThis parameter is supported only for instances of the Internet and VPC type.\nSupport characters (uppercase and lowercase), numbers, length 8-40"
          },
          "Required": false,
          "AllowedPattern": "[a-zA-Z0-9]{8,40}"
        },
        "IsForceSelectedZones": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to force deployment in the selected availability zone."
          },
          "Required": false
        },
        "ServiceVersion": {
          "Type": "String",
          "Description": {
            "en": "The version of the Message Queue for Apache Kafka instance. For example: 0.10.2, 2.2.0 and etc."
          },
          "Required": false
        },
        "UserPhoneNum": {
          "Type": "String",
          "Description": {
            "en": "The phone number of the alert contact."
          },
          "Required": false
        },
        "DeployModule": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "DeployOption_DeployModule"
          },
          "Type": "String",
          "Description": {
            "en": "The deployment mode of the instance. Valid values:\n  vpc: virtual private cloud (VPC) \n  eip: Internet and VPC\nThe deployment mode of the instance must be consistent with the instance type. \nSet this value to vpc if your instance type is VPC. \nSet this value to eip if your instance type is Internet and VPC."
          },
          "AllowedValues": [
            "vpc",
            "eip"
          ],
          "Required": true
        },
        "Password": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${DeployType}",
                  4
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The new password for the instance. \nThis parameter is supported only for instances of the Internet and VPC type.\nSupport characters (uppercase and lowercase), numbers, length 8-40, \ncontaining at least one lowercase letter, one uppercase letter, and one number"
          },
          "Required": false,
          "AllowedPattern": "^(?=.*?\\d)(?=.*?[A-Z])(?=.*?[a-z])[A-Za-z\\d]{8,40}$"
        },
        "Notifier": {
          "Type": "String",
          "Description": {
            "en": "Alert contact."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "If you want to deploy instance after create at once, the VSwitchId and DeployModule parameters is required"
    },
    "Label": {
      "en": "DeployOption",
      "zh-cn": "部署选项"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether delete all topics, consumer groups of the kafka instance and then delete instance. Default is false"
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除"
    }
  }
  EOT
}

variable "io_max_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Flow specification (recommended) \nThe IoMax and IoMaxSpec must be optional. \nWhen filling in at the same time, subject to IoMaxSpec. \nIt is recommended that you only fill in the flow specification \n"
    },
    "Label": {
      "en": "IoMaxSpec",
      "zh-cn": "流量规格（推荐）"
    }
  }
  EOT
}

variable "serverless_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ReservedPublishCapacity": {
          "Type": "Number",
          "Description": {
            "en": "Reserved sending traffic specification value, minimum 60"
          },
          "Required": true,
          "MinValue": 60
        },
        "ReservedSubscribeCapacity": {
          "Type": "Number",
          "Description": {
            "en": "Reserved consumption traffic specification value, minimum 20"
          },
          "Required": true,
          "MinValue": 20
        }
      }
    },
    "Description": {
      "en": "Serverless instance related settings."
    },
    "Label": {
      "en": "ServerlessConfig",
      "zh-cn": "Serverless 实例的相关设置"
    }
  }
  EOT
}

variable "disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the disk to be configured for the Message Queue for Apache Kafka instance."
    },
    "Label": {
      "en": "DiskSize",
      "zh-cn": "磁盘容量"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "open_connector" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether open kafka connector or not"
    },
    "Label": {
      "en": "OpenConnector",
      "zh-cn": "是否开启Connector"
    }
  }
  EOT
}

resource "alicloud_alikafka_instance" "instance" {
  deploy_type   = var.deploy_type
  eip_max       = var.eip_max
  spec_type     = var.spec_type
  partition_num = var.partition_num
  disk_type     = var.disk_type
  io_max_spec   = var.io_max_spec
  disk_size     = var.disk_size
  tags          = var.tags
}

output "ssl_domain_endpoint" {
  // Could not transform ROS Attribute SslDomainEndpoint to Terraform attribute.
  value       = null
  description = "The SSL endpoints of the instance in domain name mode."
}

output "domain_endpoint" {
  // Could not transform ROS Attribute DomainEndpoint to Terraform attribute.
  value       = null
  description = "The default endpoints of the instance in domain name mode."
}

output "endpoint" {
  // Could not transform ROS Attribute Endpoint to Terraform attribute.
  value       = null
  description = "The SSL endpoints of the instance in IP address mode."
}

output "instance_id" {
  value       = alicloud_alikafka_instance.instance.id
  description = "Id of the instance. "
}

output "ssl_endpoint" {
  // Could not transform ROS Attribute SslEndpoint to Terraform attribute.
  value       = null
  description = "The SSL endpoints of the instance in IP address mode."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Id of the order. "
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "sasl_domain_endpoint" {
  // Could not transform ROS Attribute SaslDomainEndpoint to Terraform attribute.
  value       = null
  description = "The Simple Authentication and Security Layer (SASL) endpoints of the instance in domain name mode."
}

output "name" {
  value       = alicloud_alikafka_instance.instance.name
  description = "Name of the instance."
}

