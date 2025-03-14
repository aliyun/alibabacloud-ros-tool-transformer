variable "scaling_configuration_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the scaling configuration. The name must be 2 to 64 characters in length and can contain letters, digits, underscores (_), hyphens (-), and periods (.). The name must start with a letter or a digit.\nThe name of the scaling configuration must be unique in a region. If you do not specify this parameter, the scaling configuration ID is used."
    },
    "Label": {
      "en": "ScalingConfigurationName",
      "zh-cn": "伸缩配置的名称"
    }
  }
  EOT
}

variable "ntp_servers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The Network Time Protocol (NTP) server."
    },
    "Label": {
      "en": "NtpServers",
      "zh-cn": "NTP服务器"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "memory" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The memory size that you want to allocate to the elastic container instance. Unit: GiB."
    },
    "Label": {
      "en": "Memory",
      "zh-cn": "容器内存大小"
    }
  }
  EOT
}

variable "dns_config_searches" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The search domains of the DNS server."
    },
    "Label": {
      "en": "DnsConfigSearches",
      "zh-cn": "DNS搜索域列表"
    }
  }
  EOT
}

variable "data_cachepl" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The performance level (PL) of the disk used for data caching. We recommend that you use ESSDs. Valid values if you use ESSDs:\nPL0: An ESSD can provide up to 10,000 random read/write IOPS.\nPL1: An ESSD can provide up to 50,000 random read/write IOPS.\nPL2: An ESSD can provide up to 100,000 random read/write IOPS.\nPL3: An ESSD can provide up to 1,000,000 random read/write IOPS.\nDefault value: PL1.\nNote\nFor more information about ESSDs, see ESSDs."
    },
    "Label": {
      "en": "DataCachePL",
      "zh-cn": "数据缓存使用的云盘的性能等级"
    }
  }
  EOT
}

variable "containers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "EnvironmentVars": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of the environment variable. The value can be up to 256 characters in length."
                    },
                    "Required": false
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the environment variable. The name must be 1 to 128 characters in length. Specify the value in the [0-9a-zA-Z] format. The name can contain underscores and cannot start with a digit."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            },
            "ReadinessProbeExecCommands": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The command that you want to run by using the command line interface (CLI) in the container to perform readiness probes."
              },
              "Required": false
            },
            "Memory": {
              "Type": "Number",
              "Description": {
                "en": "The memory size that you want to allocate to the container. Unit: GiB."
              },
              "Required": false
            },
            "ReadinessProbeTcpSocketPort": {
              "Type": "Number",
              "Description": {
                "en": "The port that is detected by TCP sockets when you use the TCP sockets to perform readiness probes."
              },
              "Required": false
            },
            "Cpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of CPU cores that you want to allocate to the container."
              },
              "Required": false
            },
            "ReadinessProbeHttpGetPath": {
              "Type": "String",
              "Description": {
                "en": "The path to which HTTP GET requests are sent when you use the HTTP GET requests to perform readiness probes."
              },
              "Required": false
            },
            "ReadinessProbeHttpGetScheme": {
              "Type": "String",
              "Description": {
                "en": "The protocol type of the HTTP GET requests that you use to perform readiness probes. Valid values:\nHTTP\nHTTPS"
              },
              "AllowedValues": [
                "HTTP",
                "HTTPS"
              ],
              "Required": false
            },
            "Image": {
              "Type": "String",
              "Description": {
                "en": "The image of the container."
              },
              "Required": true
            },
            "Gpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of GPUs that you want to allocate to the container."
              },
              "Required": false
            },
            "StdinOnce": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether standard input streams remain connected during multiple sessions when Container.N.StdinOnce is set to true.\nIf you set Container.N.StdinOnce to true, standard input streams are connected after the container is started and remain idle until a client is connected to receive data. After the client is disconnected, the standard input streams are also disconnected and remain disconnected until the container is restarted."
              },
              "Required": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The image name of the container."
              },
              "Required": true
            },
            "LivenessProbeHttpGetScheme": {
              "Type": "String",
              "Description": {
                "en": "The protocol type of the HTTP GET requests that you use to perform liveness probes. Valid values:\nHTTP\nHTTPS"
              },
              "AllowedValues": [
                "HTTP",
                "HTTPS"
              ],
              "Required": false
            },
            "LivenessProbeTimeoutSeconds": {
              "Type": "Number",
              "Description": {
                "en": "The timeout period for a liveness probe. Unit: seconds. Default value: 1. Minimum value: 1."
              },
              "Required": false
            },
            "LivenessProbeFailureThreshold": {
              "Type": "Number",
              "Description": {
                "en": "The minimum number of consecutive failures before a successful liveness probe is considered failed.\nDefault value: 3."
              },
              "Required": false
            },
            "LivenessProbeHttpGetPath": {
              "Type": "String",
              "Description": {
                "en": "The path to which HTTP GET requests are sent when you use the HTTP GET requests to perform liveness probes."
              },
              "Required": false
            },
            "VolumeMounts": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ReadOnly": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Specifies whether the volume is read-only. Valid values:\ntrue\nfalse\nDefault value: false."
                    },
                    "Required": false
                  },
                  "MountPath": {
                    "Type": "String",
                    "Description": {
                      "en": "The directory on which the volume is mounted.\nNote\nData in this directory is overwritten by the data on the volume. Proceed with caution if you specify this parameter."
                    },
                    "Required": false
                  },
                  "SubPath": {
                    "Type": "String",
                    "Description": {
                      "en": "The subdirectory of the volume."
                    },
                    "Required": false
                  },
                  "MountPropagation": {
                    "Type": "String",
                    "Description": {
                      "en": "The mount propagation setting of the volume. Mount propagation allows volumes that are mounted on one container to be shared with other containers in the same pod, or even with other pods on the same node. Valid values:\nNone: The volume mount does not receive subsequent mounts that are mounted to the volume or the subdirectories of the volume.\nHostToCotainer: The volume mount receives all subsequent mounts that are mounted to the volume or its subdirectories.\nBidirectional: This value is similar to HostToCotainer. The volume mount receives all subsequent mounts that are mounted to the volume or its subdirectories. In addition, all volume mounts that are mounted on the container are propagated back to the instance and to all containers of all pods that use the same volume.\nDefault value: None."
                    },
                    "AllowedValues": [
                      "None",
                      "HostToCotainer",
                      "Bidirectional"
                    ],
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Description": {
                      "en": "The volume name. The value of this parameter is the same as the value of Volume.N.Name."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            },
            "LivenessProbeInitialDelaySeconds": {
              "Type": "Number",
              "Description": {
                "en": "The number of seconds that elapses from the startup of the container to the start time of a liveness probe. Unit: seconds."
              },
              "Required": false
            },
            "SecurityContextRunAsUser": {
              "Type": "Number",
              "Description": {
                "en": "The ID of the user that runs the container."
              },
              "Required": false
            },
            "LivenessProbeTcpSocketPort": {
              "Type": "Number",
              "Description": {
                "en": "The port detected by TCP sockets when you use the TCP sockets to perform liveness probes."
              },
              "Required": false
            },
            "Commands": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The container startup commands. You can specify up to 20 commands. Each command can contain up to 256 characters."
              },
              "Required": false
            },
            "Tty": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to enable interaction. Valid values:\ntrue\nfalse\nDefault value: false.\nIf the command is a /bin/bash command, set the value to true."
              },
              "Required": false
            },
            "ReadinessProbePeriodSeconds": {
              "Type": "Number",
              "Description": {
                "en": "The interval at which readiness probes are performed. Unit: seconds. Default value: 10. Minimum value: 1."
              },
              "Required": false
            },
            "LivenessProbePeriodSeconds": {
              "Type": "Number",
              "Description": {
                "en": "The interval at which liveness probes are performed. Unit: seconds. Default value: 10. Minimum value: 1."
              },
              "Required": false
            },
            "LivenessProbeExecCommands": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The command that you want to run by using the CLI in the container to perform liveness probes."
              },
              "Required": false
            },
            "LivenessProbeSuccessThreshold": {
              "Type": "Number",
              "Description": {
                "en": "The minimum number of consecutive successes before a failed liveness probe is considered successful. Default value: 1. Set the value to 1."
              },
              "Required": false
            },
            "ReadinessProbeSuccessThreshold": {
              "Type": "Number",
              "Description": {
                "en": "The minimum number of consecutive successes before a failed readiness probe is considered successful. Default value: 1. Set the value to 1."
              },
              "Required": false
            },
            "ReadinessProbeInitialDelaySeconds": {
              "Type": "Number",
              "Description": {
                "en": "The number of seconds that elapses from the startup of the container to the start time of a readiness probe. Unit: seconds."
              },
              "Required": false
            },
            "Args": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The container startup arguments. You can specify up to 10 arguments."
              },
              "Required": false
            },
            "ReadinessProbeFailureThreshold": {
              "Type": "Number",
              "Description": {
                "en": "The minimum number of consecutive failures before a successful readiness probe is considered failed. Default value: 3."
              },
              "Required": false
            },
            "SecurityContextCapabilitiesAdd": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The permissions that are granted to the processes in the container. Only NET_ADMIN and NET_RAW are supported.\nNote\nIf you want to use NET_RAW, submit a ticket."
              },
              "Required": false
            },
            "Ports": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port number. Valid values: 1 to 65535."
                    },
                    "Required": true
                  },
                  "Protocol": {
                    "Type": "String",
                    "Description": {
                      "en": "The protocol type. Valid values:\nTCP\nUDP"
                    },
                    "AllowedValues": [
                      "TCP",
                      "UDP"
                    ],
                    "Required": true
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            },
            "ReadinessProbeHttpGetPort": {
              "Type": "Number",
              "Description": {
                "en": "The port to which HTTP GET requests are sent when you use the HTTP GET requests to perform readiness probes."
              },
              "Required": false
            },
            "Stdin": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether the container allocates buffer resources to standard input streams when the container is running. If you do not specify this parameter, an end-of-file (EOF) error occurs.\nDefault value: false."
              },
              "Required": false
            },
            "WorkingDir": {
              "Type": "String",
              "Description": {
                "en": "The working directory of the container."
              },
              "Required": false
            },
            "ImagePullPolicy": {
              "Type": "String",
              "Description": {
                "en": "The image pulling policy. Valid values:\nAlways: Each time instances are created, image pulling is performed.\nIfNotPresent: Image pulling is performed as needed. On-premises images are preferentially used. If no on-premises images are available, image pulling is performed.\nNever: Image pulling is not performed. On-premises images are always used."
              },
              "AllowedValues": [
                "Always",
                "IfNotPresent",
                "Never"
              ],
              "Required": false
            },
            "LivenessProbeHttpGetPort": {
              "Type": "Number",
              "Description": {
                "en": "The port to which HTTP GET requests are sent when you use the HTTP GET requests to perform liveness probes."
              },
              "Required": false
            },
            "ReadinessProbeTimeoutSeconds": {
              "Type": "Number",
              "Description": {
                "en": "The timeout period for a readiness probe. Unit: seconds. Default value: 1. Minimum value: 1."
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
    "Label": {
      "en": "Containers",
      "zh-cn": "实例包含的容器列表"
    },
    "MaxLength": 10
  }
  EOT
}

variable "cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of vCPUs that you want to allocate to the elastic container instance."
    },
    "Label": {
      "en": "Cpu",
      "zh-cn": "容器 CPU 核数"
    }
  }
  EOT
}

variable "container_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the elastic container instance."
    },
    "Label": {
      "en": "ContainerGroupName",
      "zh-cn": "ECI实例名称"
    }
  }
  EOT
}

variable "ingress_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum inbound bandwidth. Unit: bytes."
    },
    "Label": {
      "en": "IngressBandwidth",
      "zh-cn": "入方向带宽限制"
    }
  }
  EOT
}

variable "image_snapshot_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the image cache snapshot."
    },
    "Label": {
      "en": "ImageSnapshotId",
      "zh-cn": "镜像缓存ID"
    }
  }
  EOT
}

variable "data_cache_provisioned_iops" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The IOPS provisioned for the ESSD AutoPL disk used for data caching. Valid values: 0 to min{50000, 1000 × Capacity - Baseline IOPS}, where Baseline IOPS = min{1800 + 50 × Capacity - 50000}.\nNote\nFor more information about ESSD AutoPL disks, see ESSD AutoPL disks."
    },
    "Label": {
      "en": "DataCacheProvisionedIops",
      "zh-cn": "ESSD AutoPL云盘预配置的读写IOPS"
    }
  }
  EOT
}

variable "egress_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum outbound bandwidth. Unit: bytes."
    },
    "Label": {
      "en": "EgressBandwidth",
      "zh-cn": "出方向带宽限制"
    }
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Resource Access Management (RAM) role that you want to assign to the elastic container instance. Elastic container instances and Elastic Compute Service (ECS) instances can share the same RAM role. For more information, see Use an instance RAM role by calling API operations."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "volumes" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "HostPathVolumeType": {
              "Type": "String",
              "Description": {
                "en": "The type of the Host directory. Examples: File, Directory, and Socket."
              },
              "Required": false
            },
            "EmptyDirVolumeSizeLimit": {
              "Type": "String",
              "Description": {
                "en": "The storage size of the EmptyDirVolume-typed volume. Unit: GiB or MiB."
              },
              "Required": false
            },
            "FlexVolumeFsType": {
              "Type": "String",
              "Description": {
                "en": "The file system type of the FlexVolume-typed volume. The default value is determined by the script of the FlexVolume plug-in."
              },
              "Required": false
            },
            "NFSVolumeServer": {
              "Type": "String",
              "Description": {
                "en": "The address of the NFS server."
              },
              "Required": false
            },
            "DiskVolumeDiskSize": {
              "Type": "Number",
              "Description": {
                "en": "The storage size of the DiskVolume-typed volume. Unit: GiB."
              },
              "Required": false
            },
            "ConfigFileVolumeConfigFileToPaths": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The relative path to the configuration file."
                    },
                    "Required": true
                  },
                  "Content": {
                    "Type": "String",
                    "Description": {
                      "en": "The content of the configuration file (32 KB)."
                    },
                    "Required": false
                  },
                  "Mode": {
                    "Type": "Number",
                    "Description": {
                      "en": "The permissions on the ConfigFileVolume directory."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The volume name."
              },
              "Required": true
            },
            "NFSVolumeReadOnly": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether the NFSVolume-typed volume is read-only. Valid values:\ntrue\nfalse\nDefault value: false."
              },
              "Required": false
            },
            "HostPathVolumePath": {
              "Type": "String",
              "Description": {
                "en": "The absolute path on the host."
              },
              "Required": false
            },
            "NFSVolumePath": {
              "Type": "String",
              "Description": {
                "en": "The path to the NFSVolume-typed volume."
              },
              "Required": false
            },
            "Type": {
              "Type": "String",
              "Description": {
                "en": "The volume type. Valid values:\nEmptyDirVolume: an empty volume.\nNFSVolume: a network file system (NFS) volume.\nConfigFileVolume: a configuration file.\nFlexVolume: a volume that uses the FlexVolume plug-in to extend storage and supports disks.\nHostPathVolume: a file or path of the host node.\nDiskVolume: a disk volume. This value is not recommended. We recommend that you set Volume.N.Type to FlexVolume."
              },
              "AllowedValues": [
                "EmptyDirVolume",
                "NFSVolume",
                "ConfigFileVolume",
                "FlexVolume",
                "HostPathVolume"
              ],
              "Required": true
            },
            "FlexVolumeDriver": {
              "Type": "String",
              "Description": {
                "en": "The driver name of the FlexVolume-typed volume."
              },
              "Required": false
            },
            "DiskVolumeDiskId": {
              "Type": "String",
              "Description": {
                "en": "The ID of the DiskVolume-typed volume."
              },
              "Required": false
            },
            "ConfigFileVolumeDefaultMode": {
              "Type": "Number",
              "Description": {
                "en": "The default permissions on the ConfigFileVolume-typed volume."
              },
              "Required": false
            },
            "FlexVolumeOptions": {
              "Type": "String",
              "Description": {
                "en": "The options of the FlexVolume-typed volume. Each option is a key-value pair contained in a JSON string.\nWhen you use the FlexVolume plug-in to mount a disk, specify the options in the {\"volumeId\":\"d-2zehdahrwoa7srg****\",\"performanceLevel\": \"PL2\"} format."
              },
              "Required": false
            },
            "EmptyDirVolumeMedium": {
              "Type": "String",
              "Description": {
                "en": "The storage medium of the EmptyDirVolume-typed volume. If you leave this parameter empty, the file system that backs the node is used as the storage medium. If you set this parameter to memory, the memory is used as the storage medium."
              },
              "Required": false
            },
            "DiskVolumeFsType": {
              "Type": "String",
              "Description": {
                "en": "The file system type of the DiskVolume-typed volume. We recommend that you specify FlexVolume.FsType instead of this parameter."
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
    "Label": {
      "en": "Volumes",
      "zh-cn": "数据卷信息"
    }
  }
  EOT
}

variable "auto_match_image_cache" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically match the image cache. Valid values:\ntrue\nfalse\nDefault value: false."
    },
    "Label": {
      "en": "AutoMatchImageCache",
      "zh-cn": "是否自动匹配镜像缓存"
    }
  }
  EOT
}

variable "data_cache_bucket" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The bucket that stores data caches."
    },
    "Label": {
      "en": "DataCacheBucket",
      "zh-cn": "数据缓存Bucket"
    }
  }
  EOT
}

variable "ipv6_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of IPv6 addresses."
    },
    "Label": {
      "en": "Ipv6AddressCount",
      "zh-cn": "IPv6地址数"
    }
  }
  EOT
}

variable "dns_config_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The variable value of the option."
          },
          "Required": true
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The variable name of the option."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "DnsConfigOptions",
      "zh-cn": "对象选项列表，"
    }
  }
  EOT
}

variable "spot_price_limit" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum hourly price of the preemptible elastic container instance. The value can be accurate to three decimal places.\nIf you set SpotStrategy to SpotWithPriceLimit, you must specify SpotPriceLimit."
    },
    "Label": {
      "en": "SpotPriceLimit",
      "zh-cn": "抢占式实例的每小时最高价格"
    }
  }
  EOT
}

variable "instance_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The specified ECS instance types. You can specify up to five ECS instance types. For more information, see Specify ECS instance types to create an elastic container instance."
    },
    "Label": {
      "en": "InstanceTypes",
      "zh-cn": "指定的ECS实例规格"
    },
    "MaxLength": 5
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
            "en": "The tag value of the elastic container instance. You can specify 1 to 20 tags.\nYou can specify an empty string as a tag value. The tag value can be up to 128 characters in length and cannot contain http:// or https://. The tag value cannot start with acs:."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The tag key of the elastic container instance. You can specify 1 to 20 tags.\nYou cannot specify an empty string as a tag key. The tag key can be up to 128 characters in length and cannot contain http:// or https://. The tag key cannot start with acs: or aliyun."
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
    "Label": {
      "en": "Tags",
      "zh-cn": "实例的标签键值对"
    },
    "MaxLength": 128
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The hostname of the elastic container instance."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "主机名称"
    }
  }
  EOT
}

variable "spot_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The bidding policy of the instance. Valid values:\nNoSpot: The instance is created as a pay-as-you-go instance.\nSpotWithPriceLimit: The instance is created as a preemptible instance with a user-defined maximum hourly price.\nSpotAsPriceGo: The instance is created as a preemptible instance for which the market price at the time of purchase is used as the bid price.\nDefault value: NoSpot."
    },
    "AllowedValues": [
      "NoSpot",
      "SpotAsPriceGo",
      "SpotWithPriceLimit"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "实例的抢占策略"
    }
  }
  EOT
}

variable "dns_config_name_servers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IP addresses of the DNS servers."
    },
    "Label": {
      "en": "DnsConfigNameServers",
      "zh-cn": "DNS服务器的IP地址列表"
    }
  }
  EOT
}

variable "active_deadline_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The validity period of the scaling configuration. Unit: seconds."
    },
    "Label": {
      "en": "ActiveDeadlineSeconds",
      "zh-cn": "有效期限"
    }
  }
  EOT
}

variable "acr_registry_infos" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Domains": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The domain names of the Container Registry Enterprise Edition instance. By default, all domain names of the instance are displayed. You can specify one or more domain names. Separate multiple domain names with commas (,)."
              },
              "Required": false
            },
            "InstanceName": {
              "Type": "String",
              "Description": {
                "en": "The name of the Container Registry Enterprise Edition instance."
              },
              "Required": false
            },
            "InstanceId": {
              "Type": "String",
              "Description": {
                "en": "The ID of the Container Registry Enterprise Edition instance."
              },
              "Required": true
            },
            "RegionId": {
              "Type": "String",
              "Description": {
                "en": "The region ID of the Container Registry Enterprise Edition instance."
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
    "Label": {
      "en": "AcrRegistryInfos",
      "zh-cn": "ACR 企业版实例的信息"
    }
  }
  EOT
}

variable "init_containers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Args": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The container startup arguments."
              },
              "Required": false
            },
            "SecurityContextCapabilitiesAdd": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The permissions that are granted to the processes in the init container. Only NET_ADMIN and NET_RAW are supported.\nNote\nIf you want to use NET_RAW, submit a ticket."
              },
              "Required": false
            },
            "Memory": {
              "Type": "Number",
              "Description": {
                "en": "The memory size that you want to allocate to the init container. Unit: GiB."
              },
              "Required": false
            },
            "Cpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of vCPUs that you want to allocate to the init container."
              },
              "Required": false
            },
            "Image": {
              "Type": "String",
              "Description": {
                "en": "The image of the init container."
              },
              "Required": true
            },
            "Gpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of GPUs that you want to allocate to the init container."
              },
              "Required": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The name of the init container."
              },
              "Required": true
            },
            "InitContainerEnvironmentVars": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of the environment variable. The value can be up to 256 characters in length."
                    },
                    "Required": false
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the environment variable. The name must be 1 to 128 characters in length. Specify the name in the [0-9a-zA-Z] format. The name can contain underscores and cannot start with a digit."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            },
            "WorkingDir": {
              "Type": "String",
              "Description": {
                "en": "The working directory of the init container."
              },
              "Required": false
            },
            "ImagePullPolicy": {
              "Type": "String",
              "Description": {
                "en": "The image pulling policy."
              },
              "Required": false
            },
            "Commands": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The container startup commands."
              },
              "Required": false
            },
            "SecurityContextRunAsUser": {
              "Type": "Number",
              "Description": {
                "en": "The ID of the user that runs the init container."
              },
              "Required": false
            },
            "InitContainerVolumeMounts": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ReadOnly": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Specifies whether the mount directory is read-only.\nDefault value: false."
                    },
                    "Required": false
                  },
                  "MountPath": {
                    "Type": "String",
                    "Description": {
                      "en": "The directory on which the volume is mounted. Data in this directory is overwritten by the data of the volume."
                    },
                    "Required": false
                  },
                  "SubPath": {
                    "Type": "String",
                    "Description": {
                      "en": "The subdirectory of the volume. The pod can mount different directories of the same volume to different directories of the init container."
                    },
                    "Required": false
                  },
                  "MountPropagation": {
                    "Type": "String",
                    "Description": {
                      "en": "The mount propagation setting of the volume. Mount propagation allows volumes that are mounted on one container to be shared with other containers in the same pod, or even with other pods on the same node. Valid values:\nNone: The volume mount does not receive subsequent mounts that are mounted to the volume or the subdirectories of the volume.\nHostToCotainer: The volume mount receives all subsequent mounts that are mounted to the volume or the subdirectories of the volume.\nBidirectional: This value is similar to HostToCotainer. The volume mount receives all subsequent mounts that are mounted to the volume or its subdirectories. In addition, all volume mounts that are mounted on the container are propagated back to the instance and to all containers of all pods that use the same volume."
                    },
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the mounted volume."
                    },
                    "Required": true
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "InitContainers",
      "zh-cn": "Init容器列表"
    }
  }
  EOT
}

variable "load_balancer_weight" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The weight of the elastic container instance as a backend server. Valid values: 1 to 100.\nDefault value: 50.",
      "zh-cn": "ECI实例作为后端服务器时的权重，。"
    },
    "Label": {
      "en": "LoadBalancerWeight",
      "zh-cn": "ECI实例作为后端服务器时的权重"
    }
  }
  EOT
}

variable "cpu_options_threads_per_core" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of threads per core. You can specify this parameter for only specific instance types. If you set this parameter to 1, Hyper-Threading is disabled. For more information, see Specify custom CPU options."
    },
    "Label": {
      "en": "CpuOptionsThreadsPerCore",
      "zh-cn": "每核线程数"
    }
  }
  EOT
}

variable "data_cache_bursting_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the Performance Burst feature for the ESSD AutoPL disk used for data caching. Valid values:\ntrue\nfalse\nDefault value: false.\nNote\nFor more information about ESSD AutoPL disks, see ESSD AutoPL disks."
    },
    "Label": {
      "en": "DataCacheBurstingEnabled",
      "zh-cn": "是否开启Burst（性能突发）"
    }
  }
  EOT
}

variable "termination_grace_period_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The buffer period during which a program handles operations before the program is stopped. Unit: seconds."
    },
    "Label": {
      "en": "TerminationGracePeriodSeconds",
      "zh-cn": "程序的缓冲时间"
    }
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the scaling group for which you want to create the scaling configuration."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩配置所属的伸缩组的ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "The ID of the security group with which you want to associate the elastic container instance. Elastic container instances that are associated with the same security group can access each other.\nIf you do not specify a security group, the system uses the default security group in the region that you selected. Make sure that the inbound rules of the security group contain the protocols and the port numbers of the containers that you want to expose. If you do not have a default security group in the region, the system creates a default security group and adds the declared container protocols and port numbers to the inbound rules of the security group."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "ECI实例所属的安全组ID"
    }
  }
  EOT
}

variable "restart_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The restart policy of the elastic container instance. Valid values:\nAlways: always restarts the elastic container instance.\nNever: never restarts the elastic container instance.\nOnFailure: restarts the elastic container instance upon failures.\nDefault value: Always."
    },
    "AllowedValues": [
      "Always",
      "Never",
      "OnFailure"
    ],
    "Label": {
      "en": "RestartPolicy",
      "zh-cn": "容器组的重启策略"
    }
  }
  EOT
}

variable "cpu_options_core" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of physical CPU cores. You can specify this parameter for only specific instance types. For more information, see Specify custom CPU options."
    },
    "Label": {
      "en": "CpuOptionsCore",
      "zh-cn": "cpu 物理核心数"
    }
  }
  EOT
}

variable "auto_create_eip" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically create an elastic IP address (EIP) and bind the EIP to the elastic container instance."
    },
    "Label": {
      "en": "AutoCreateEip",
      "zh-cn": "是否自动创建弹性公网 IP"
    }
  }
  EOT
}

variable "cost_optimization" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the Cost Optimization feature. Valid values:\ntrue\nfalse\nDefault value: false."
    },
    "Label": {
      "en": "CostOptimization",
      "zh-cn": "是否开启成本优化开关"
    }
  }
  EOT
}

variable "host_aliases" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Ip": {
              "Type": "String",
              "Description": {
                "en": "The IP address of the host that you want to add."
              },
              "Required": true
            },
            "Hostnames": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The name of the host that you want to add."
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
    "Label": {
      "en": "HostAliases",
      "zh-cn": "自定义实例内一个容器的Hostname映射"
    }
  }
  EOT
}

variable "security_context_sysctls" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The variable value of the security context in which the elastic container instance runs."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The system name of the security context in which the elastic container instance runs."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "SecurityContextSysctls",
      "zh-cn": "实例运行的安全上下文的系统信息"
    }
  }
  EOT
}

variable "eip_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth of the EIP. Default value: 5. Unit: Mbit/s."
    },
    "Label": {
      "en": "EipBandwidth",
      "zh-cn": "弹性公网IP的带宽"
    }
  }
  EOT
}

variable "image_registry_credentials" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "The username of the image repository."
          },
          "Required": true
        },
        "Server": {
          "Type": "String",
          "Description": {
            "en": "The registered address of the image repository."
          },
          "Required": true
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "The password of the image repository."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "ImageRegistryCredentials",
      "zh-cn": "镜像仓库信息"
    }
  }
  EOT
}

variable "dns_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Domain Name System (DNS) policy. Valid values:\nNone: uses the DNS that is specified by DnsConfig.\nDefault: uses the DNS that is specified for the runtime environment."
    },
    "AllowedValues": [
      "Default",
      "None"
    ],
    "Label": {
      "en": "DnsPolicy",
      "zh-cn": "DNS策略"
    }
  }
  EOT
}

variable "instance_family_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The level of the instance family. You can use this parameter to filter instance types that meet the specified criteria. This parameter takes effect only if you set CostOptimization to true. Valid values:\nEntryLevel: entry level (shared instance types) Instance types of this level are the most cost-effective but may not provide stable computing performance. Instance types of this level are suitable for scenarios in which CPU utilization is low. For more information, see Shared instance families.\nEnterpriseLevel: enterprise level. Instance types of this level provide stable performance and dedicated resources and are suitable for business scenarios that require high stability. For more information, see Overview of instance families.\nCreditEntryLevel: credit entry level (burstable instance types). CPU credits are used to ensure computing performance. Instance types of this level are suitable for business scenarios in which CPU utilization is low but may fluctuate in specific scenarios. For more information, see Overview of burstable instances."
    },
    "AllowedValues": [
      "CreditEntryLevel",
      "EnterpriseLevel",
      "EntryLevel"
    ],
    "Label": {
      "en": "InstanceFamilyLevel",
      "zh-cn": "实例规格族级别"
    }
  }
  EOT
}

variable "ephemeral_storage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the temporary storage space. By default, an enhanced SSD (ESSD) of the PL1 level is used. Unit: GiB."
    },
    "Label": {
      "en": "EphemeralStorage",
      "zh-cn": "临时存储空间大小"
    }
  }
  EOT
}

resource "alicloud_ess_eci_scaling_configuration" "eci_scaling_configuration" {
  scaling_configuration_name       = var.scaling_configuration_name
  resource_group_id                = var.resource_group_id
  memory                           = var.memory
  containers                       = var.containers
  cpu                              = var.cpu
  container_group_name             = var.container_group_name
  ingress_bandwidth                = var.ingress_bandwidth
  image_snapshot_id                = var.image_snapshot_id
  egress_bandwidth                 = var.egress_bandwidth
  ram_role_name                    = var.ram_role_name
  volumes                          = var.volumes
  auto_match_image_cache           = var.auto_match_image_cache
  ipv6_address_count               = var.ipv6_address_count
  spot_price_limit                 = var.spot_price_limit
  instance_types                   = var.instance_types
  tags                             = var.tags
  host_name                        = var.host_name
  spot_strategy                    = var.spot_strategy
  active_deadline_seconds          = var.active_deadline_seconds
  acr_registry_infos               = var.acr_registry_infos
  init_containers                  = var.init_containers
  load_balancer_weight             = var.load_balancer_weight
  cpu_options_threads_per_core     = var.cpu_options_threads_per_core
  termination_grace_period_seconds = var.termination_grace_period_seconds
  scaling_group_id                 = var.scaling_group_id
  security_group_id                = var.security_group_id
  restart_policy                   = var.restart_policy
  cpu_options_core                 = var.cpu_options_core
  auto_create_eip                  = var.auto_create_eip
  host_aliases                     = var.host_aliases
  eip_bandwidth                    = var.eip_bandwidth
  image_registry_credentials       = var.image_registry_credentials
  dns_policy                       = var.dns_policy
  ephemeral_storage                = var.ephemeral_storage
}

output "scaling_configuration_id" {
  value       = alicloud_ess_eci_scaling_configuration.eci_scaling_configuration.id
  description = "The ID of the elastic container instance."
}

