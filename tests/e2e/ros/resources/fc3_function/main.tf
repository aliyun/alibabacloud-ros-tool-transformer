variable "memory_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The memory size of the function, in MB."
    },
    "MinValue": 128,
    "Label": {
      "en": "MemorySize",
      "zh-cn": "函数的内存规格"
    },
    "MaxValue": 65536
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Function description."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "函数的描述"
    },
    "MaxLength": 256
  }
  EOT
}

variable "tracing_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of the function."
          },
          "Required": false
        },
        "Params": {
          "Type": "Json",
          "Description": {
            "en": "Link tracking parameters."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The tracing configuration of the function."
    },
    "Label": {
      "en": "TracingConfig",
      "zh-cn": "链路追踪配置"
    }
  }
  EOT
}

variable "vpc_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "The ID of the VPC."
          },
          "Required": false
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
                "en": "The ID of the VSwitch."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The IDs of the VSwitch."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "The ID of the security group."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The VPC configuration of the function."
    },
    "Label": {
      "en": "VpcConfig",
      "zh-cn": "VPC 配置"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout of the function."
    },
    "MinValue": 1,
    "Label": {
      "en": "Timeout",
      "zh-cn": "函数运行的超时时间"
    },
    "MaxValue": 86400
  }
  EOT
}

variable "instance_lifecycle_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PreStop": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Timeout": {
                "Type": "Number",
                "Description": {
                  "en": "The timeout for the callback method. "
                },
                "Required": false
              },
              "Handler": {
                "Type": "String",
                "Description": {
                  "en": "The execution entry of the callback method has a similar meaning to the request handler."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Instance lifecycle callback method configuration."
          },
          "Required": false
        },
        "Initializer": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Timeout": {
                "Type": "Number",
                "Description": {
                  "en": "The timeout for the callback method. "
                },
                "Required": false
              },
              "Handler": {
                "Type": "String",
                "Description": {
                  "en": "The execution entry of the callback method has a similar meaning to the request handler."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Instance lifecycle callback method configuration."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The instance lifecycle configuration of the function."
    },
    "Label": {
      "en": "InstanceLifecycleConfig",
      "zh-cn": "实例生命周期回调方法配置"
    }
  }
  EOT
}

variable "handler" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The handler of the function."
    },
    "Label": {
      "en": "Handler",
      "zh-cn": "函数执行的入口"
    }
  }
  EOT
}

variable "cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The CPU size of the function in vCPU as a multiple of 0.05 vCPU. The minimum value is 0.05 and the maximum value is 16. At the same time, the ratio of cpu to memorySize (in GB) should be between 1:1 and 1:4."
    },
    "MinValue": 0.05,
    "Label": {
      "en": "Cpu",
      "zh-cn": "函数的 CPU 规格"
    },
    "MaxValue": 16
  }
  EOT
}

variable "custom_container_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RegistryConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "CertConfig": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Insecure": {
                      "Type": "Boolean",
                      "Description": {
                        "en": "Whether to skip certificate verification. Default value is false."
                      },
                      "Required": true,
                      "Default": false
                    },
                    "RootCaCertBase64": {
                      "Type": "String",
                      "Description": {
                        "en": "The certificate authority (CA) certificate of the image repository."
                      },
                      "Required": false
                    }
                  }
                },
                "Type": "Json",
                "Description": {
                  "en": "The certificate configurations."
                },
                "Required": true
              },
              "NetworkConfig": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "VpcId": {
                      "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
                      "Type": "String",
                      "Description": {
                        "en": "The ID of the virtual private cloud (VPC) that can be used to connect to the image repository."
                      },
                      "Required": true
                    },
                    "VSwitchId": {
                      "AssociationPropertyMetadata": {
                        "VpcId": "$${VpcId}",
                        "ZoneId": "$${ZoneId}"
                      },
                      "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
                      "Type": "String",
                      "Description": {
                        "en": "The ID of the vSwitch that can be used to connect to the image repository."
                      },
                      "Required": true
                    },
                    "SecurityGroupId": {
                      "AssociationPropertyMetadata": {
                        "VpcId": "$${VpcId}"
                      },
                      "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
                      "Type": "String",
                      "Description": {
                        "en": "The ID of the security group that can be used to connect to the image repository."
                      },
                      "Required": true
                    }
                  }
                },
                "Type": "Json",
                "Description": {
                  "en": "The network information of the image repository."
                },
                "Required": false
              },
              "AuthConfig": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "UserName": {
                      "Type": "String",
                      "Description": {
                        "en": "The username that is used to log on to the image repository."
                      },
                      "Required": true
                    },
                    "Password": {
                      "Type": "String",
                      "Description": {
                        "en": "The password of the username that is used to log on to the image repository."
                      },
                      "Required": true
                    }
                  }
                },
                "Type": "Json",
                "Description": {
                  "en": "The authentication information of the image repository."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configurations of the image repository."
          },
          "Required": false
        },
        "ResolvedImageUri": {
          "Type": "String",
          "Description": {
            "en": "The actual digest version of the deployed image. The code version specified by this digest is actually used when the function is started."
          },
          "Required": false
        },
        "AccelerationInfo": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Status": {
                "Type": "String",
                "Description": {
                  "en": "Acceleration status."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Acceleration configuration."
          },
          "Required": false
        },
        "AcrInstanceId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the ACR instance."
          },
          "Required": false
        },
        "Entrypoint": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "The entrypoint to run in the container."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The entrypoints to run in the container."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "Command": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "The command to run in the container."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The commands to run in the container."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "AccelerationType": {
          "Type": "String",
          "Description": {
            "en": "Whether to enable mirror acceleration. Default means to turn on mirror acceleration, and None means to turn off mirror acceleration."
          },
          "Required": false
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port number of the container."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 65535
        },
        "HealthCheckConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "TimeoutSeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The timeout for the health check. "
                },
                "Required": false
              },
              "InitialDelaySeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The initial delay for the health check. The value range is 0~120. The default value is 0."
                },
                "Required": false,
                "MinValue": 0,
                "MaxValue": 120
              },
              "HttpGetUrl": {
                "Type": "String",
                "Description": {
                  "en": "Container custom health check URL address. Length cannot exceed 2048 characters."
                },
                "Required": false,
                "MaxLength": 2048
              },
              "PeriodSeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The interval for the health check. The value range is 1~120. The default value is 3."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              },
              "FailureThreshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for the number of health check failures. When this value is reached, the system considers the check to have failed. The value range is 1~120. The default value is 3."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              },
              "SuccessThreshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for the number of successful health checks. When this value is reached, the system considers the check to have succeeded. The value range is 1~120. The default value is 1."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Health check configuration."
          },
          "Required": false
        },
        "Image": {
          "Type": "String",
          "Description": {
            "en": "The image address."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Custom container configuration. Choose one of Code and CustomContainerConfig."
    },
    "Label": {
      "en": "CustomContainerConfig",
      "zh-cn": "自定义容器运行时的相关配置"
    }
  }
  EOT
}

variable "code" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SourceCode": {
          "Type": "String",
          "Description": {
            "en": "(Node.js, PHP and Python) The source code for your FC function. If you include this parameter in a function source inline, ROS places it in a file called index (utf-8 encoded) and then compresses it to create a deployment package. For the Handler property, the first part of the handler identifier must be index. For example: index.handler.\nYour source code can contain up to 4096 characters. For JSON, you must use backslashes to escape quotes and special characters, such as line breaks.\nPriority: ZipFile > SourceCode > OssBucketName&OssObjectName."
          },
          "Required": false,
          "MaxLength": 4096
        },
        "ZipFile": {
          "Type": "String",
          "Description": {
            "en": "Function code Base 64 encoding of the ZIP package."
          },
          "Required": false
        },
        "Checksum": {
          "Type": "String",
          "Description": {
            "en": "CRC-64 value of the function code package. If a checksum is provided, Function Compute will verify whether the checksum of the code package is consistent with the provided checksum."
          },
          "Required": false
        },
        "OssObjectName": {
          "Type": "String",
          "Description": {
            "en": "The name of the OSS object where the code package is stored."
          },
          "Required": false
        },
        "OssBucketName": {
          "Type": "String",
          "Description": {
            "en": "The name of the OSS bucket where the code package is stored."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Function code ZIP package. Choose one of Code and CustomContainerConfig."
    },
    "Label": {
      "en": "Code",
      "zh-cn": "函数代码 ZIP 包"
    }
  }
  EOT
}

variable "role" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The user is authorized to the RAM role of Function Compute. After setting, Function Compute will assume the role and generate temporary access credentials. The temporary access credentials of this role can be used in functions to access specified Alibaba Cloud services, such as OSS and OTS."
    },
    "Label": {
      "en": "Role",
      "zh-cn": "用户授权给函数计算的 RAM 角色"
    }
  }
  EOT
}

variable "function_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the function."
    },
    "Label": {
      "en": "FunctionName",
      "zh-cn": "函数的名称"
    }
  }
  EOT
}

variable "internet_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the function can access the Internet."
    },
    "Label": {
      "en": "InternetAccess",
      "zh-cn": "是否允许函数访问公网"
    }
  }
  EOT
}

variable "runtime" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The programming language of the function."
    },
    "Label": {
      "en": "Runtime",
      "zh-cn": "函数的运行时环境"
    }
  }
  EOT
}

variable "environment_variables" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The environment variables of the function."
    },
    "Label": {
      "en": "EnvironmentVariables",
      "zh-cn": "函数的环境变量"
    }
  }
  EOT
}

variable "custom_runtime_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Args": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "Instance startup parameter."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Instance startup parameters."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "Command": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "Instance startup command."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Instance startup commands."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The listening port of the HTTP Server."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 65535
        },
        "HealthCheckConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "TimeoutSeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The timeout for the health check. "
                },
                "Required": false
              },
              "InitialDelaySeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The initial delay for the health check. The value range is 0~120. The default value is 0."
                },
                "Required": false,
                "MinValue": 0,
                "MaxValue": 120
              },
              "HttpGetUrl": {
                "Type": "String",
                "Description": {
                  "en": "Container custom health check URL address. Length cannot exceed 2048 characters."
                },
                "Required": false,
                "MaxLength": 2048
              },
              "PeriodSeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The interval for the health check. The value range is 1~120. The default value is 3."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              },
              "FailureThreshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for the number of health check failures. When this value is reached, the system considers the check to have failed. The value range is 1~120. The default value is 3."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              },
              "SuccessThreshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for the number of successful health checks. When this value is reached, the system considers the check to have succeeded. The value range is 1~120. The default value is 1."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 120
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Health check configuration."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Custom runtime configuration."
    },
    "Label": {
      "en": "CustomRuntimeConfig",
      "zh-cn": "自定义运行时配置"
    }
  }
  EOT
}

variable "gpu_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "GpuMemorySize": {
          "Type": "Number",
          "Description": {
            "en": "GPU memory specifications in MB, multiples of 1024MB."
          },
          "Required": false
        },
        "GpuType": {
          "Type": "String",
          "Description": {
            "en": "GPU instance type."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The GPU configuration of the function."
    },
    "Label": {
      "en": "GpuConfig",
      "zh-cn": "函数 GPU 配置"
    }
  }
  EOT
}

variable "oss_mount_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPoints": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ReadOnly": {
                "Type": "Boolean",
                "Description": {
                  "en": "Mounted OSS Bucket read-only."
                },
                "Required": false
              },
              "BucketName": {
                "Type": "String",
                "Description": {
                  "en": "Mounted OSS Bucket."
                },
                "Required": false
              },
              "Endpoint": {
                "Type": "String",
                "Description": {
                  "en": "The endpoint of the bucket."
                },
                "Required": false
              },
              "BucketPath": {
                "Type": "String",
                "Description": {
                  "en": "Mounted OSS Bucket path."
                },
                "Required": false
              },
              "MountDir": {
                "Type": "String",
                "Description": {
                  "en": "The mount directory of the function."
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The mount points of the function."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        }
      }
    },
    "Description": {
      "en": "The OSS mount configuration of the function."
    },
    "Label": {
      "en": "OssMountConfig",
      "zh-cn": "OSS 挂载配置"
    }
  }
  EOT
}

variable "custom_dns" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Searches": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "DNS search domain."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "List of DNS search domains."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "DnsOptions": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Value": {
                "Type": "String",
                "Description": {
                  "en": "The value of the DNS resolution configuration."
                },
                "Required": false
              },
              "Name": {
                "Type": "String",
                "Description": {
                  "en": "The name of the DNS resolution configuration."
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "List of DNS resolution configurations in the resolv.conf file."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "NameServers": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "DNS server."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "List of DNS servers."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        }
      }
    },
    "Description": {
      "en": "Custom DNS configuration."
    },
    "Label": {
      "en": "CustomDns",
      "zh-cn": "自定义 DNS 配置"
    }
  }
  EOT
}

variable "disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The disk size of the function, in MB. "
    },
    "Label": {
      "en": "DiskSize",
      "zh-cn": "函数的磁盘规格"
    }
  }
  EOT
}

variable "instance_concurrency" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of concurrent instances of the function."
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceConcurrency",
      "zh-cn": "实例最大并发度"
    },
    "MaxValue": 100
  }
  EOT
}

variable "layers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The layer name."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The layers of the function."
    },
    "Label": {
      "en": "Layers",
      "zh-cn": "层的列表"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "nas_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPoints": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "EnableTls": {
                "Type": "Boolean",
                "Description": {
                  "en": "Mount using transport encryption. Note: Only general-purpose NAS supports transmission encryption."
                },
                "Required": false
              },
              "ServerAddr": {
                "Type": "String",
                "Description": {
                  "en": "NAS server address."
                },
                "Required": false
              },
              "MountDir": {
                "Type": "String",
                "Description": {
                  "en": "The mount directory of the function."
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The mount points of the function."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 100
        },
        "UserId": {
          "Type": "Number",
          "Description": {
            "en": "The user ID of the function."
          },
          "Required": false
        },
        "GroupId": {
          "Type": "Number",
          "Description": {
            "en": "The group ID of the function."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The NAS configuration of the function."
    },
    "Label": {
      "en": "NasConfig",
      "zh-cn": "NAS 配置"
    }
  }
  EOT
}

variable "log_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Project": {
          "Type": "String",
          "Description": {
            "en": "The project of the function."
          },
          "Required": false
        },
        "LogBeginRule": {
          "Type": "String",
          "Description": {
            "en": "The log begin rule."
          },
          "Required": false
        },
        "Logstore": {
          "Type": "String",
          "Description": {
            "en": "The logstore of the function."
          },
          "Required": false
        },
        "EnableInstanceMetrics": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable the instance metrics."
          },
          "Required": false
        },
        "EnableRequestMetrics": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable the request metrics."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The log configuration of the function."
    },
    "Label": {
      "en": "LogConfig",
      "zh-cn": "日志配置"
    }
  }
  EOT
}

resource "alicloud_fcv3_function" "function" {
  memory_size           = var.memory_size
  description           = var.description
  timeout               = var.timeout
  handler               = var.handler
  cpu                   = var.cpu
  role                  = var.role
  function_name         = var.function_name
  internet_access       = var.internet_access
  runtime               = var.runtime
  environment_variables = var.environment_variables
  disk_size             = var.disk_size
  instance_concurrency  = var.instance_concurrency
  layers                = var.layers
}

output "function_id" {
  value       = alicloud_fcv3_function.function.id
  description = "The function ID"
}

output "function_name" {
  value       = alicloud_fcv3_function.function.function_name
  description = "The function name"
}

output "arn" {
  // Could not transform ROS Attribute ARN to Terraform attribute.
  value       = null
  description = "The ARN for ALIYUN::ROS::CustomResource"
}

