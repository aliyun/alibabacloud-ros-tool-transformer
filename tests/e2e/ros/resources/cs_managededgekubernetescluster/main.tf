variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable the public network API Server:\ntrue: which means that the public network API Server is open.\nfalse: If set to false, the API server on the public network will not be created, only the API server on the private network will be created.Default to true."
    },
    "Label": {
      "en": "EndpointPublicAccess",
      "zh-cn": "是否开启公网API Server"
    }
  }
  EOT
}

variable "container_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = <<EOT
  {
    "Description": {
      "en": "The container network segment cannot conflict with the VPC network segment. When the system is selected to automatically create a VPC, the network segment 172.16.0.0/16 is used by default."
    },
    "Label": {
      "en": "ContainerCidr",
      "zh-cn": "Pod网络地址段"
    }
  }
  EOT
}

variable "key_pair" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Key pair name. Specify one of KeyPair or LoginPassword."
    },
    "Label": {
      "en": "KeyPair",
      "zh-cn": "密钥对名称"
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
      "en": "The ID of resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "集群所属的资源组ID"
    }
  }
  EOT
}

variable "node_cidr_mask" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of IP addresses that can be assigned to nodes. \nThis number is determined by the specified pod CIDR block. \nThis parameter takes effect only if the cluster uses the Flannel plug-in.Default value: 25."
    },
    "Label": {
      "en": "NodeCidrMask",
      "zh-cn": "可分配给节点的最大CIDR地址块数量"
    }
  }
  EOT
}

variable "timeout_mins" {
  type        = number
  default     = 60
  description = <<EOT
  {
    "Description": {
      "en": "Cluster resource stack creation timeout, in minutes. The default value is 60."
    },
    "Label": {
      "en": "TimeoutMins",
      "zh-cn": "集群资源栈创建超时时间"
    }
  }
  EOT
}

variable "addons" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Config": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, no configuration is required."
          },
          "Required": false
        },
        "Disabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to disable default installation."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the add-on."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The add-ons to be installed for the cluster."
    },
    "Label": {
      "en": "Addons",
      "zh-cn": "集群安装的组件列表"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable deletion protection for the cluster. \nAfter deletion protection is enabled, the cluster cannot be deleted \nin the ACK console or by calling API operations. Valid values:true: enables deletion protection for the cluster.\nfalse: disables deletion protection for the cluster.\nDefault value: false.",
      "zh-cn": "是否启用删除保护功能"
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否启用删除保护功能"
    }
  }
  EOT
}

variable "cluster_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The edge managed cluster spec. Value:\nack.pro.small: Professional hosting cluster, namely: \"ACK Pro version cluster\".\nack.standard: Standard hosting cluster.\nDefault value: ack.standard. The value can be empty. When it is empty, a standard managed cluster will be created."
    },
    "Label": {
      "en": "ClusterSpec",
      "zh-cn": "托管版集群类型"
    }
  }
  EOT
}

variable "profile" {
  type        = string
  default     = "Edge"
  description = <<EOT
  {
    "Description": {
      "en": "Edge cluster ID. The default value is Edge."
    },
    "Label": {
      "en": "Profile",
      "zh-cn": "边缘集群标识"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the cluster. The cluster name can use uppercase and lowercase letters, Chinese characters, numbers, and dashes."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "is_enterprise_security_group" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SecurityGroupId}"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to create an advanced security group. \nThis parameter takes effect only if security_group_id is left empty.\nNote You must specify an advanced security group for a cluster that has Terway installed.\ntrue: creates an advanced security group.\nfalse: does not create an advanced security group.\nDefault value: false.",
      "zh-cn": "是否创建高级安全组"
    },
    "Label": {
      "en": "IsEnterpriseSecurityGroup",
      "zh-cn": "是否创建高级安全组"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VPC ID. If not set, the system will automatically create a VPC, and the VPC network segment created by the system is 192.168.0.0/16. \nVpcId and VSwitchId can only be empty at the same time or set the corresponding values at the same time."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "cloud_monitor_flags" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to install the cloud monitoring plugin:\ntrue: indicates installation\nfalse: Do not install\nDefault to false"
    },
    "Label": {
      "en": "CloudMonitorFlags",
      "zh-cn": "是否安装云监控插件"
    }
  }
  EOT
}

variable "service_cidr" {
  type        = string
  default     = "172.19.0.0/20"
  description = <<EOT
  {
    "Description": {
      "en": "The service network segment cannot conflict with the VPC network segment and the container network segment. When the system is selected to automatically create a VPC, the network segment 172.19.0.0/20 is used by default."
    },
    "Label": {
      "en": "ServiceCidr",
      "zh-cn": "服务网段"
    }
  }
  EOT
}

variable "snat_entry" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to configure SNAT for the network.\nWhen a VPC can access the public network environment, set it to false.\nWhen an existing VPC cannot access the public network environment:\nWhen set to True, SNAT is configured and the public network environment can be accessed at this time.\nIf set to false, it means that SNAT is not configured and the public network environment cannot be accessed at this time.\nDefault to true."
    },
    "Label": {
      "en": "SnatEntry",
      "zh-cn": "是否为网络配置SNAT"
    }
  }
  EOT
}

variable "zone_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ZoneId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Zone ids of worker node virtual switches belongs to."
    }
  }
  EOT
}

variable "maintenance_window" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Recurrence": {
          "Type": "String",
          "Description": {
            "en": "The RFC5545 Recurrence Rule currently only supports FREQ=WEEKLY and does not support specifying COUNT or UNTIL"
          },
          "Required": false
        },
        "MaintenanceTime": {
          "Type": "String",
          "Description": {
            "en": "Maintenance start time. RFC3339 standard format."
          },
          "Required": false
        },
        "WeeklyPeriod": {
          "Type": "String",
          "Description": {
            "en": "Maintenance cycle. Multiple values are separated by a half-comma (,). Values: {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}"
          },
          "Required": false
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to open the maintenance window. Value:\n- true: Opens the maintenance window.\n- false: The maintenance window is not opened.\nDefault value: false"
          },
          "Required": false
        },
        "Duration": {
          "Type": "String",
          "Description": {
            "en": "Maintenance time. Value range [1,24] in hours.\nDefault value: 3h"
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Cluster maintenance window."
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
          "Description": {
            "en": "Tag value."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Tag key."
          },
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
      "en": "Tag the cluster."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    }
  }
  EOT
}

variable "proxy_mode" {
  type        = string
  default     = "iptables"
  description = <<EOT
  {
    "Description": {
      "en": "kube-proxy proxy mode, supports both iptables and ipvs modes. The default is iptables."
    },
    "Label": {
      "en": "ProxyMode",
      "zh-cn": "kube-proxy代理模式"
    }
  }
  EOT
}

variable "login_password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SSH login password. Password rules are 8-30 characters and contain three items (upper and lower case letters, numbers, and special symbols). Specify one of KeyPair or LoginPassword."
    },
    "Label": {
      "en": "LoginPassword",
      "zh-cn": "登录密码"
    }
  }
  EOT
}

resource "alicloud_cs_edge_kubernetes" "managed_edge_kubernetes_cluster" {
  resource_group_id            = var.resource_group_id
  node_cidr_mask               = var.node_cidr_mask
  addons                       = var.addons
  deletion_protection          = var.deletion_protection
  cluster_spec                 = var.cluster_spec
  name                         = var.name
  is_enterprise_security_group = var.is_enterprise_security_group
  vpc_id                       = var.vpc_id
  service_cidr                 = var.service_cidr
  proxy_mode                   = var.proxy_mode
}

output "task_id" {
  // Could not transform ROS Attribute TaskId to Terraform attribute.
  value       = null
  description = "Task ID. Automatically assigned by the system, the user queries the task status."
}

output "cluster_id" {
  value       = alicloud_cs_edge_kubernetes.managed_edge_kubernetes_cluster.id
  description = "Cluster instance ID."
}

output "apiserverslbid" {
  // Could not transform ROS Attribute APIServerSLBId to Terraform attribute.
  value       = null
  description = "The id of API server SLB"
}

output "scaling_group_id" {
  // Could not transform ROS Attribute ScalingGroupId to Terraform attribute.
  value       = null
  description = "Scaling group id"
}

output "ingressslbid" {
  // Could not transform ROS Attribute IngressSLBId to Terraform attribute.
  value       = null
  description = "The id of ingress SLB"
}

output "scaling_rule_id" {
  // Could not transform ROS Attribute ScalingRuleId to Terraform attribute.
  value       = null
  description = "Scaling rule id"
}

output "default_user_kube_config" {
  // Could not transform ROS Attribute DefaultUserKubeConfig to Terraform attribute.
  value       = null
  description = "Default user kubernetes config which is used for configuring cluster credentials."
}

output "worker_ram_role_name" {
  // Could not transform ROS Attribute WorkerRamRoleName to Terraform attribute.
  value       = null
  description = "Worker ram role name."
}

output "scaling_configuration_id" {
  // Could not transform ROS Attribute ScalingConfigurationId to Terraform attribute.
  value       = null
  description = "Scaling configuration id"
}

output "private_user_kub_config" {
  // Could not transform ROS Attribute PrivateUserKubConfig to Terraform attribute.
  value       = null
  description = "Private user kubernetes config which is used for configuring cluster credentials."
}

output "nodes" {
  // Could not transform ROS Attribute Nodes to Terraform attribute.
  value       = null
  description = "The list of cluster nodes."
}

