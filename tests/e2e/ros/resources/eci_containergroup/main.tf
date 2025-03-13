variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "security_context_sysctl" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Name": {
          "Type": "String",
          "AllowedValues": [
            "kernel.shm_rmid_forced",
            "kernel.msgmax"
          ],
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "ECI Sysctl is valid for every container in ECI.\nCurrently only two Sysctl keyNames are supported:\nKernel.shm_rmid_forced\nKernel.msgmax"
    },
    "Label": {
      "en": "SecurityContextSysctl",
      "zh-cn": "实例运行的安全上下文"
    }
  }
  EOT
}

variable "spec_type" {
  type        = string
  default     = "Basic"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Basic": {
          "en": "Basic",
          "zh-cn": "基础模式"
        },
        "InstanceType": {
          "en": "InstanceType",
          "zh-cn": "指定规格"
        }
      }
    },
    "AllowedValues": [
      "Basic",
      "InstanceType"
    ],
    "Label": {
      "en": "ContainerGroupSpecType",
      "zh-cn": "容器组规格选择方式"
    }
  }
  EOT
}

variable "memory" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpecType}",
            "Basic"
          ]
        }
      }
    },
    "Description": {
      "en": "memory size"
    },
    "Label": {
      "en": "Memory",
      "zh-cn": "内存大小"
    }
  }
  EOT
}

variable "init_container" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "WorkingDir": {
              "Type": "String",
              "Description": {
                "en": "The working directory for the container."
              },
              "Required": false
            },
            "ImagePullPolicy": {
              "Type": "String",
              "Description": {
                "en": "The image pull policy. You can use it to pull the image from the image repository."
              },
              "Required": false
            },
            "Command": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false,
                  "MaxLength": 256
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The list of commands that you want to send to a container to run. You can specify a maximum of 1 commands. Maximum length per string: 256 characters."
              },
              "Required": false,
              "MaxLength": 1
            },
            "Memory": {
              "Type": "Number",
              "Description": {
                "en": "The memory assigned to the container. Unit: GiB."
              },
              "Required": false
            },
            "Port": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port number. Valid values: 1-65535."
                    },
                    "Required": false,
                    "MinValue": 1,
                    "MaxValue": 65535
                  },
                  "Protocol": {
                    "Type": "String",
                    "Description": {
                      "en": "The protocol that the port uses. Valid values: TCP and UDP"
                    },
                    "AllowedValues": [
                      "TCP",
                      "UDP"
                    ],
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The open ports and protocols. You can set a maximum of 100 ports."
              },
              "Required": false,
              "MaxLength": 100
            },
            "Arg": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The arguments passed to the commands. A maximum of 10 arguments are supported."
              },
              "Required": false,
              "MaxLength": 10
            },
            "SecurityContext": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "RunAsUser": {
                    "Type": "Number",
                    "Description": {
                      "en": "Valid value: 1337."
                    },
                    "AllowedValues": [
                      1337
                    ],
                    "Required": false
                  },
                  "Capability.Add": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Valid values: NET_ADMIN."
                        },
                        "AllowedValues": [
                          "NET_ADMIN"
                        ],
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false
                  },
                  "ReadOnlyRootFilesystem": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Valid value: True."
                    },
                    "AllowedValues": [
                      true
                    ],
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The security context of the container group."
              },
              "Required": false
            },
            "VolumeMount": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ReadOnly": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Default value: False."
                    },
                    "Required": false,
                    "Default": false
                  },
                  "MountPath": {
                    "Type": "String",
                    "Description": {
                      "en": "A mount path. The data in the target directory is overwritten by the data in the mounted volume. Therefore, use caution when you mount a volume to a directory."
                    },
                    "Required": false
                  },
                  "Name": {
                    "Type": "Number",
                    "Description": {
                      "en": "The name of the volume. The name is the same as that specified for the Name parameter in the Volume section."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The number of volumes that are mounted to the container. A maximum of 16 volumes are supported."
              },
              "Required": false,
              "MaxLength": 16
            },
            "Cpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of vCPUs assigned to the container. Unit: vCPUs (cores)."
              },
              "Required": false
            },
            "Image": {
              "Type": "String",
              "Description": {
                "en": "The container image."
              },
              "Required": false
            },
            "EnvironmentVar": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "FieldRef.FieldPath": {
                    "Type": "String",
                    "Description": {
                      "en": "A reference to another variable. Currently, only status.podIP is supported."
                    },
                    "AllowedValues": [
                      "status.podIP"
                    ],
                    "Required": false
                  },
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of the variable. The value must be [0,256] characters in length."
                    },
                    "Required": false,
                    "MinLength": 0,
                    "MaxLength": 256
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the variable. The name must be [1,128] characters in length and can contain [, 0-9a-zA-Z, ], and underscores (_). It cannot start with a digit."
                    },
                    "Required": false,
                    "MinLength": 1,
                    "MaxLength": 128
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Environment variables in the operating system of the container. Each environment variable is a key/value pair, and both the key and value are strings. A maximum of 100 environment variables are supported. The key indicates the name of a variable. The value indicates the value of the variable."
              },
              "Required": false,
              "MaxLength": 100
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The name of the container."
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
      "en": "The containers that constitute the container group for initializing."
    },
    "Label": {
      "en": "InitContainer",
      "zh-cn": "初始化容器列表"
    }
  }
  EOT
}

variable "cpu" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpecType}",
            "Basic"
          ]
        }
      }
    },
    "Description": {
      "en": "CPU size"
    },
    "Label": {
      "en": "Cpu",
      "zh-cn": "CPU大小"
    }
  }
  EOT
}

variable "eip_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Elastic IP ID"
    },
    "Label": {
      "en": "EipInstanceId",
      "zh-cn": "弹性公网IP ID"
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
      "en": "The name of the container group. \nThe length is [2,128] English lowercase letters, numbers or hyphens (-), cannot begin or end with a hyphens."
    },
    "Label": {
      "en": "ContainerGroupName",
      "zh-cn": "容器组名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

variable "container" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "ReadinessProbe": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "TimeoutSeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of seconds after which the probe times out. Default value: 1. Minimum value: 1."
                    },
                    "Required": false,
                    "MinValue": 1
                  },
                  "InitialDelaySeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of seconds after the container has started before probes are initiated."
                    },
                    "Required": false
                  },
                  "Exec.Command": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The commands for running the readiness probe."
                    },
                    "Required": false
                  },
                  "PeriodSeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "Specifies the period at which the probe is performed. Unit: seconds. Default value: 10. Minimum value: 1."
                    },
                    "Required": false,
                    "MinValue": 1
                  },
                  "HttpGet.Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port to which the system sends an HTTP GET request to perform the check."
                    },
                    "Required": false
                  },
                  "TcpSocket.Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port to which the system sends a TCP SOCKET request to perform the check."
                    },
                    "Required": false
                  },
                  "FailureThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The minimum consecutive failures for the probe to be considered to have failed after having succeeded. Default value: 3."
                    },
                    "Required": false
                  },
                  "HttpGet.Scheme": {
                    "Type": "String",
                    "Description": {
                      "en": "The protocol that is used to connect the host. Valid values: HTTP and HTTPS."
                    },
                    "AllowedValues": [
                      "HTTP",
                      "HTTPS"
                    ],
                    "Required": false
                  },
                  "HttpGet.Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The path to which the system sends an HTTP GET request to perform the check."
                    },
                    "Required": false
                  },
                  "SuccessThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The minimum consecutive successes for the probe to be considered successful after having failed. Default value: 1."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The readiness probe."
              },
              "Required": false
            },
            "LivenessProbe": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "TimeoutSeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of seconds after which the probe times out. Default value: 1. Minimum value: 1."
                    },
                    "Required": false,
                    "MinValue": 1
                  },
                  "InitialDelaySeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of seconds after the container has started before probes are initiated."
                    },
                    "Required": false
                  },
                  "Exec.Command": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The commands for running the readiness probe."
                    },
                    "Required": false
                  },
                  "PeriodSeconds": {
                    "Type": "Number",
                    "Description": {
                      "en": "Specifies the period at which the probe is performed. Unit: seconds. Default value: 10. Minimum value: 1."
                    },
                    "Required": false,
                    "MinValue": 1
                  },
                  "HttpGet.Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port to which the system sends an HTTP GET request to perform the check."
                    },
                    "Required": false
                  },
                  "TcpSocket.Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port to which the system sends a TCP SOCKET request to perform the check."
                    },
                    "Required": false
                  },
                  "FailureThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The minimum consecutive failures for the probe to be considered to have failed after having succeeded. Default value: 3."
                    },
                    "Required": false
                  },
                  "HttpGet.Scheme": {
                    "Type": "String",
                    "Description": {
                      "en": "The protocol that is used to connect the host. Valid values: HTTP and HTTPS."
                    },
                    "AllowedValues": [
                      "HTTP",
                      "HTTPS"
                    ],
                    "Required": false
                  },
                  "HttpGet.Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The path to which the system sends an HTTP GET request to perform the check."
                    },
                    "Required": false
                  },
                  "SuccessThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The minimum consecutive successes for the probe to be considered successful after having failed. Default value: 1."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The liveness probe."
              },
              "Required": false
            },
            "Memory": {
              "Type": "Number",
              "Description": {
                "en": "The memory assigned to the container. Unit: GiB."
              },
              "Required": false
            },
            "Port": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Port": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port number. Valid values: 1-65535."
                    },
                    "Required": false,
                    "MinValue": 1,
                    "MaxValue": 65535
                  },
                  "Protocol": {
                    "Type": "String",
                    "Description": {
                      "en": "The protocol that the port uses. Valid values: TCP and UDP"
                    },
                    "AllowedValues": [
                      "TCP",
                      "UDP"
                    ],
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The open ports and protocols. You can set a maximum of 100 ports."
              },
              "Required": false,
              "MaxLength": 100
            },
            "Cpu": {
              "Type": "Number",
              "Description": {
                "en": "The number of vCPUs assigned to the container. Unit: vCPUs (cores)."
              },
              "Required": false
            },
            "Image": {
              "Type": "String",
              "Description": {
                "en": "The container image."
              },
              "Required": true
            },
            "StdinOnce": {
              "Type": "Boolean",
              "Required": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The name of the container."
              },
              "Required": true
            },
            "Stdin": {
              "Type": "Boolean",
              "Required": false
            },
            "WorkingDir": {
              "Type": "String",
              "Description": {
                "en": "The working directory for the container."
              },
              "Required": false
            },
            "ImagePullPolicy": {
              "Type": "String",
              "Description": {
                "en": "The image pull policy. You can use it to pull the image from the image repository."
              },
              "Required": false
            },
            "Command": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false,
                  "MaxLength": 256
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The list of commands that you want to send to a container to run. You can specify a maximum of 1 commands. Maximum length per string: 256 characters."
              },
              "Required": false,
              "MaxLength": 1
            },
            "Arg": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The arguments passed to the commands. A maximum of 10 arguments are supported."
              },
              "Required": false,
              "MaxLength": 10
            },
            "Tty": {
              "Type": "Boolean",
              "Required": false
            },
            "SecurityContext": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "RunAsUser": {
                    "Type": "Number",
                    "Description": {
                      "en": "User ID."
                    },
                    "Required": false
                  },
                  "Capability.Add": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Valid values: NET_ADMIN."
                        },
                        "AllowedValues": [
                          "NET_ADMIN"
                        ],
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false
                  },
                  "ReadOnlyRootFilesystem": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Valid value: True."
                    },
                    "AllowedValues": [
                      true
                    ],
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The security context of the container group."
              },
              "Required": false
            },
            "VolumeMount": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "MountPath": {
                    "Type": "String",
                    "Description": {
                      "en": "A mount path. The data in the target directory is overwritten by the data in the mounted volume. Therefore, use caution when you mount a volume to a directory."
                    },
                    "Required": false
                  },
                  "ReadOnly": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Default value: False."
                    },
                    "Required": false,
                    "Default": false
                  },
                  "SubPath": {
                    "Type": "String",
                    "Description": {
                      "en": "A subdirectory under the data volume. The convenience instance mounts different directories under the same data volume to different directories of the container."
                    },
                    "Required": false
                  },
                  "MountPropagation": {
                    "Type": "String",
                    "Description": {
                      "en": "Mount propagation Settings for data volumes. Mount propagation allows container mounted volumes to be shared to other containers on the same ECI instance, or even to other ECI instances on the same host machine. Valid values:\n- None: This volume is not aware of any subsequent mount operations performed on this volume or its subdirectories.\n- HostToContainer: This volume will be aware of subsequent mount operations on this volume or its subdirectories\n- Bidirectional: Mount aware, similar to HostToContainer In addition, the volume will be propagated back to the host and to all containers of all ECI instances that use the same volume.\nDefault value: None"
                    },
                    "AllowedValues": [
                      "None",
                      "HostToContainer",
                      "Bidirectional"
                    ],
                    "Required": false
                  },
                  "Name": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the volume. The name is the same as that specified for the Name parameter in the Volume section."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The number of volumes that are mounted to the container. A maximum of 16 volumes are supported."
              },
              "Required": false,
              "MaxLength": 16
            },
            "EnvironmentVar": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "FieldRef.FieldPath": {
                    "Type": "String",
                    "Description": {
                      "en": "A reference to another variable. Currently, only status.podIP is supported."
                    },
                    "AllowedValues": [
                      "status.podIP"
                    ],
                    "Required": false
                  },
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The value of the variable."
                    },
                    "Required": false,
                    "MinLength": 0
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the variable. The name must be [1,128] characters in length and can contain [, 0-9a-zA-Z, ], and underscores (_). It cannot start with a digit."
                    },
                    "Required": false,
                    "MinLength": 1,
                    "MaxLength": 128
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Environment variables in the operating system of the container. Each environment variable is a key/value pair, and both the key and value are strings. A maximum of 100 environment variables are supported. The key indicates the name of a variable. The value indicates the value of the variable."
              },
              "Required": false,
              "MaxLength": 100
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The containers that constitute the container group."
    },
    "Label": {
      "en": "Container",
      "zh-cn": "容器组中包含的容器"
    }
  }
  EOT
}

variable "image_snapshot_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Image cache ID or snapshot ID."
    },
    "Label": {
      "en": "ImageSnapshotId",
      "zh-cn": "镜像缓存ID或快照ID"
    }
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The RAM role that the container group assumes. ECI and ECS share the same RAM role."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "dns_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "NameServer": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The list of IP addresses for DNS servers."
          },
          "Required": false
        },
        "Search": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The list of DNS search domains."
          },
          "Required": false
        },
        "Option": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Value": {
                "Type": "String",
                "Description": {
                  "en": "The value of the option."
                },
                "Required": false
              },
              "Name": {
                "Type": "String",
                "Description": {
                  "en": "The name of the option."
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The list of options. Each option includes a name and a value. The value is optional."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The information about DNS configurations."
    },
    "Label": {
      "en": "DnsConfig",
      "zh-cn": "DNS配置"
    }
  }
  EOT
}

variable "auto_match_image_cache" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically match the image cache."
    },
    "Label": {
      "en": "AutoMatchImageCache",
      "zh-cn": "自动匹配镜像缓存"
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
      "zh-cn": "Ipv6地址数量"
    }
  }
  EOT
}

variable "image_registry_credential" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "The username that is used to log on to the image repository."
          },
          "Required": true
        },
        "Server": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the image repository. This address does not include a protocol prefix, such as http:// or https://."
          },
          "Required": true
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "The password that is used to log on to the image repository."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The information that you need to log on to the container image repository, including the server address, username, and password.",
      "zh-cn": "登录容器映像仓库的信息，包括服务器地址、用户名和密码。"
    },
    "Label": {
      "en": "ImageRegistryCredential",
      "zh-cn": "登录容器映像仓库的信息"
    },
    "MaxLength": 10
  }
  EOT
}

variable "spot_price_limit" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpotStrategy}",
            "SpotWithPriceLimit"
          ]
        }
      }
    },
    "Description": {
      "en": "Set the hourly maximum price of the instance. It supports a maximum of 3 decimal places. It takes effect when the value of the parameter SpotStrategy is SpotWithPriceLimit."
    },
    "Label": {
      "en": "SpotPriceLimit",
      "zh-cn": "实例的每小时最高价格"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpecType}",
            "InstanceType"
          ]
        }
      }
    },
    "Description": {
      "en": "The type of the ECS instance."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "spot_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance preemption strategy.\nRanges:\nNoSpot (default): normal pay-as-you-go instances.\nSpotWithPriceLimit: Preemptive instance that sets a cap price.\nSpotAsPriceGo: The system automatically bids, following the current market actual price."
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "实例的抢占策略"
    }
  }
  EOT
}

variable "active_deadline_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The validity period in seconds."
    },
    "Label": {
      "en": "ActiveDeadlineSeconds",
      "zh-cn": "有效期限"
    }
  }
  EOT
}

variable "host_aliase" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Ip": {
              "Type": "String",
              "Required": false
            },
            "Hostname": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
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
    "Description": {
      "en": "Customize the hostname mapping of a container inside the pod"
    },
    "Label": {
      "en": "HostAliase",
      "zh-cn": "自定义pod内一个容器的hostname映射"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The ID of the zone in which the instance resides. If you leave the parameter blank, the system assigns a zone for you. The default value is blank."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "实例所属的可用区ID"
    }
  }
  EOT
}

variable "termination_grace_period_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The buffer time for the program to handle operations before it is stopped.",
      "zh-cn": "给程序预留的最后缓冲时间，用于处理关闭之前的操作。"
    },
    "Label": {
      "en": "TerminationGracePeriodSeconds",
      "zh-cn": "给程序预留的最后缓冲时间"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the specified VSwitch.\nIf no switch is specified, the system automatically uses the default switch in the default VPC in the selected region.\nIf no default VPC or default switch is available in the region, the system automatically creates a default VPC and a default switch",
      "zh-cn": "交换机ID。当前ECI实例均为专有网络实例。"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "The ID of the security group to which the instance belongs. Instances in the same security group can access one another.\nIf no security group is specified, the system automatically uses the default security group in the region you select.\nIf you do not have a default security group in this region, the system automatically creates a default security group and adds the container protocol and port you declared to the inbound direction rules of this security group."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "指定新创建实例所属于的安全组ID"
    }
  }
  EOT
}

variable "sls_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enable user log collection. The default is False."
    },
    "Label": {
      "en": "SlsEnable",
      "zh-cn": "是否开启用户日志收集"
    }
  }
  EOT
}

variable "restart_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The policy for restarting the instance. Default value: Always."
    },
    "AllowedValues": [
      "Always",
      "OnFailure",
      "Never"
    ],
    "Label": {
      "en": "RestartPolicy",
      "zh-cn": "实例重启策略"
    }
  }
  EOT
}

variable "volume" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "FlexVolume.FsType": {
              "Type": "String",
              "Description": {
                "en": "The type of file system to mount depends, by default, on FlexVolume's script."
              },
              "Required": false
            },
            "Type": {
              "Type": "String",
              "Description": {
                "en": "The type of volume. Valid values:\n- EmptyDirVolume: A data volume of type EmptyDir that represents an empty directory.\n- NFSVolume: A data volume of type NFS that represents a network filesystem\n- ConfigFileVolume: A data volume of type ConfigFile, which represents configuration files\n- FlexVolume: Use FlexVolume plug-in to extend the storage type and support mounting cloud disk.\n- HostPathVolume: A data volume of type HostPath, representing a file or directory of the host node.\n- DiskVolume (not recommended) : Cloud disk volume FlexVolume is recommended to mount the cloud disk."
              },
              "AllowedValues": [
                "EmptyDirVolume",
                "NFSVolume",
                "ConfigFileVolume",
                "FlexVolume",
                "HostPathVolume",
                "DiskVolume"
              ],
              "Required": true
            },
            "NFSVolume.Server": {
              "Type": "String",
              "Description": {
                "en": "The IP address of the NFS server."
              },
              "Required": false
            },
            "FlexVolume.Options": {
              "Type": "Json",
              "Description": {
                "en": "The options of FlexVolume."
              },
              "Required": false
            },
            "FlexVolume.Driver": {
              "Type": "String",
              "Description": {
                "en": "Driver type when using the FlexVolume plug-in to mount a data volume. Valid values:\n- alicloud/disk: Mount the cloud disk\n- alicloud/nas: Mount NAS\n- alicloud/oss: Mount OSS"
              },
              "AllowedValues": [
                "alicloud/disk",
                "alicloud/nas",
                "alicloud/oss"
              ],
              "Required": false
            },
            "NFSVolume.ReadOnly": {
              "Type": "Boolean",
              "Description": {
                "en": "Default value: False."
              },
              "Required": false
            },
            "ConfigFileVolume.ConfigFileToPath": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The relative path in the configuration file. You can specify a location of a directory relative to another directory."
                    },
                    "Required": true
                  },
                  "Content": {
                    "Type": "String",
                    "Description": {
                      "en": "The content of the configuration file. Maximum size: 32 KB."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The path to the configuration file."
              },
              "Required": false
            },
            "NFSVolume.Path": {
              "Type": "String",
              "Description": {
                "en": "The path to the NFS volume."
              },
              "Required": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "The name of the volume."
              },
              "Required": true
            },
            "EmptyDirVolume.Medium": {
              "Type": "String",
              "Description": {
                "en": "The storage medium for EmptyDirVolume. By default, the file system on the node is used. Default value: not specified. Valid value: Memory. If this parameter is set to Memory, the EmptyDirVolume volume is stored in memory."
              },
              "AllowedValues": [
                "Memory"
              ],
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
      "en": "The data volume. You can specify a maximum of 20 data volumes."
    },
    "Label": {
      "en": "Volume",
      "zh-cn": "数据卷列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "acr_registry_info" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "InstanceName": {
              "Type": "String",
              "Description": {
                "en": "instance name"
              },
              "Required": false
            },
            "InstanceId": {
              "Type": "String",
              "Description": {
                "en": "Instance id"
              },
              "Required": true
            },
            "RegionId": {
              "Type": "String",
              "Description": {
                "en": "The region to which it belongs. Optional, the default is the local region"
              },
              "Required": false
            },
            "Domain": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "Optional, the default is all domain names of the corresponding instance"
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "domain"
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
      "en": "Enterprise Edition access credential configuration information. "
    },
    "Label": {
      "en": "AcrRegistryInfo",
      "zh-cn": "企业版访问凭证配置信息"
    }
  }
  EOT
}

variable "tag" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The value of the tag."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The keyword of the tag."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of container group tags in the form of key/value pairs. You can define a maximum of 20 tags for each container group."
    },
    "Label": {
      "en": "Tag",
      "zh-cn": "键值对形式的容器组标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_eci_container_group" "container_group" {
  resource_group_id                = var.resource_group_id
  memory                           = var.memory
  cpu                              = var.cpu
  eip_instance_id                  = var.eip_instance_id
  container_group_name             = var.container_group_name
  ram_role_name                    = var.ram_role_name
  auto_match_image_cache           = var.auto_match_image_cache
  image_registry_credential        = var.image_registry_credential
  spot_price_limit                 = var.spot_price_limit
  instance_type                    = var.instance_type
  spot_strategy                    = var.spot_strategy
  zone_id                          = var.zone_id
  termination_grace_period_seconds = var.termination_grace_period_seconds
  vswitch_id                       = var.vswitch_id
  security_group_id                = var.security_group_id
  restart_policy                   = var.restart_policy
  acr_registry_info                = var.acr_registry_info
}

output "internet_ip" {
  value       = alicloud_eci_container_group.container_group.internet_ip
  description = "Internet IP."
}

output "zone_id" {
  value       = alicloud_eci_container_group.container_group.zone_id
  description = "The ID of the zone in which the instance resides. If you leave the parameter blank, the system assigns a zone for you. The default value is blank."
}

output "security_group_id" {
  value       = alicloud_eci_container_group.container_group.security_group_id
  description = "The ID of the security group to which the instance belongs. Instances in the same security group can access one another."
}

output "vswitch_id" {
  value       = alicloud_eci_container_group.container_group.vswitch_id
  description = "The ID of the VSwitch. Currently, ECI instances can only be deployed in VPCs."
}

output "eni_instance_id" {
  // Could not transform ROS Attribute EniInstanceId to Terraform attribute.
  value       = null
  description = "ENI instance ID."
}

output "container_group_id" {
  value       = alicloud_eci_container_group.container_group.id
  description = "The ID of the container group."
}

output "region_id" {
  // Could not transform ROS Attribute RegionId to Terraform attribute.
  value       = null
  description = "The ID of the region in which the instance resides."
}

output "container_group_name" {
  value       = alicloud_eci_container_group.container_group.container_group_name
  description = "The name of the container group."
}

output "intranet_ip" {
  value       = alicloud_eci_container_group.container_group.intranet_ip
  description = "Intranet IP."
}

output "ipv6_address" {
  // Could not transform ROS Attribute Ipv6Address to Terraform attribute.
  value       = null
  description = "Ipv6 address."
}

