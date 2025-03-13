variable "logical_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the EDAS namespace. This parameter is required for a non-default namespace."
    },
    "Label": {
      "en": "LogicalRegionId",
      "zh-cn": "EDAS命名空间对应的ID"
    }
  }
  EOT
}

variable "nas_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NAS::FileSystem::FileSystemId",
    "Description": {
      "en": "The ID of the Network Attached Storage (NAS) file system mounted to the container where the application is running. The NAS file system must be in the same region as the cluster. The NAS file system must have an available mount target, or have a mount\ntarget on the vSwitch in the virtual private cloud (VPC) where the application is located. If this parameter is not specified and the mountDescs field exists, a NAS file system is automatically purchased and mounted to the vSwitch in the VPC by default.",
      "zh-cn": "挂载的NAS ID，必须与集群在同一个地域。"
    },
    "Label": {
      "en": "NasId",
      "zh-cn": "挂载的NAS ID"
    }
  }
  EOT
}

variable "liveness" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TimeoutSeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "Exec": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Command": {
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
        },
        "InitialDelaySeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "HttpGet": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Required": false
              },
              "HttpHeaders": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": false
                    },
                    "Name": {
                      "Type": "String",
                      "Required": false
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Required": false
              },
              "Scheme": {
                "Type": "String",
                "AllowedValues": [
                  "HTTP",
                  "HTTPS"
                ],
                "Required": false
              },
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "PeriodSeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "TcpSocket": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "FailureThreshold": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "SuccessThreshold": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        }
      }
    },
    "Description": {
      "en": "The liveness check on the container."
    },
    "Label": {
      "en": "Liveness",
      "zh-cn": "容器存活状态监测"
    }
  }
  EOT
}

variable "intranet_slb_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the internal-facing SLB instance. If this parameter is not specified, Enterprise Distributed Application Service (EDAS) automatically purchases a new SLB instance for you."
    },
    "Label": {
      "en": "IntranetSlbId",
      "zh-cn": "私网SLB ID"
    }
  }
  EOT
}

variable "web_container" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "WAR"
          ]
        }
      }
    },
    "Description": {
      "en": "The version of the Tomcat container on which the deployment package of the application depends. This parameter is applicable to Spring Cloud and Apache Dubbo applications that are deployed by using WAR packages. This parameter is not supported when you deploy an application by using images."
    },
    "Label": {
      "en": "WebContainer",
      "zh-cn": "部署包依赖的Tomcat版本"
    }
  }
  EOT
}

variable "limit_cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of CPUs allowed for each application instance when the application\nis running. Unit: cores.",
      "zh-cn": "应用运行过程中，应用实例的CPU限额。"
    },
    "Label": {
      "zh-cn": "应用运行时实例CPU限额"
    }
  }
  EOT
}

variable "sls_configs" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The collection type. The file type is file and the standard output type is stdout."
          },
          "AllowedValues": [
            "file",
            "stdout"
          ],
          "Required": false
        },
        "LogDir": {
          "Type": "String",
          "Description": {
            "en": "If the standard output type is used, the collection path is stdout.log. If the file type is used, the collection path is the path of the collected file. Wildcards(*) are supported. The collection path must match the following regular expression:\n^/( +)/(. *)^/$."
          },
          "Required": false
        },
        "Logstore": {
          "Type": "String",
          "Description": {
            "en": "The name of the Logstore. Make sure that the name of the Logstore is unique in the cluster. The name must comply with the following rules:\nThe name can contain only lowercase letters, digits, hyphens (-), and underscores(_). The name must start and end with a lowercase letter or a digit. The name must be 3 to 63 characters in length.\nIf this parameter is empty, the system automatically generates a name."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The Logstore configurations."
    },
    "Label": {
      "en": "SlsConfigs",
      "zh-cn": "Logstore配置"
    }
  }
  EOT
}

variable "intranet_slb_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol of the internal-facing SLB instance. Valid values: TCP, HTTP, and HTTPS."
    },
    "AllowedValues": [
      "TCP",
      "HTTP",
      "HTTPS"
    ],
    "Label": {
      "en": "IntranetSlbProtocol",
      "zh-cn": "私网SLB协议"
    }
  }
  EOT
}

variable "package_version" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${PackageType}",
                "FatJar"
              ]
            },
            {
              "Fn::Equals": [
                "$${PackageType}",
                "WAR"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The version of the deployment package. This parameter is required when the PackageType parameter is set to WAR or FatJar. You must specify a version.\nNote The version of SDK for Java or Python must be 2.44.0 or later."
    },
    "Label": {
      "en": "PackageVersion",
      "zh-cn": "部署包的版本号"
    }
  }
  EOT
}

variable "web_container_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "HttpPort": {
          "Type": "Number",
          "Description": {
            "en": "The port range is from 1024 to 65535. The admin permission is configured for the container, but the root permission is required to perform operations on ports with numbers less than 1024. Therefore, enter a value greater than 1024 within the range. If you do not specify this parameter, 8080 is the default value."
          },
          "Required": false,
          "MinValue": 1024,
          "MaxValue": 65535
        },
        "UriEncoding": {
          "Type": "String",
          "Description": {
            "en": "The encoding format for Tomcat. Valid values: UTF-8, ISO-8859-1, GBK, and GB2312. If you do not specify this parameter, ISO-8859-1 is the default value."
          },
          "Required": false
        },
        "ContextPath": {
          "Type": "String",
          "Description": {
            "en": "The custom path. This parameter is required only when the ContextInputType parameter is set to custom."
          },
          "Required": false
        },
        "ContextInputType": {
          "Type": "String",
          "Description": {
            "en": "Specifies whether to customize the access path for the application. Valid values:\nwar: The application access path is the name of the WAR package. You do not need to enter a custom path.\nroot: The application access path is /. You do not need to enter a custom path.\ncustom: If you select this option, you must set contextPath to a custom path."
          },
          "Required": false
        },
        "UseBodyEncoding": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use BodyEncoding for URL."
          },
          "Required": false
        },
        "ServerXml": {
          "Type": "String",
          "Description": {
            "en": "serverXml: The content of the server.xml file customized in advanced configurations.\nThis parameter takes effect only when UseAdvancedServerXml is set to true."
          },
          "Required": false
        },
        "MaxThreads": {
          "Type": "Number",
          "Description": {
            "en": "The number of connections in the connection pool. Default value: 400.\nNote This parameter greatly affects the application performance. We recommend that you set this parameter under professional guidance."
          },
          "Required": false
        },
        "UseAdvancedServerXml": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use advanced configurations to customize the server.xml file. When the preceding parameter type and specific parameters cannot meet your requirements, you can use advanced configurations to edit the server.xml file of Tomcat."
          },
          "Required": false
        },
        "UseDefaultConfig": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the custom configuration. The value true indicates that the custom configuration is not used, whereas the value false indicates that the custom configuration is used. If the custom configuration is not used, the following parameters do not take effect."
          },
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "WAR"
          ]
        }
      }
    },
    "Description": {
      "en": "The Tomcat container configuration."
    },
    "Label": {
      "en": "WebContainerConfig",
      "zh-cn": "Tomcat容器配置"
    }
  }
  EOT
}

variable "app_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the application. The name must start with a letter and can contain digits,\nletters, and hyphens (-). It can be up to 36 characters in length."
    },
    "Label": {
      "en": "AppName",
      "zh-cn": "应用名称"
    }
  }
  EOT
}

variable "jdk" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${PackageType}",
                "FatJar"
              ]
            },
            {
              "Fn::Equals": [
                "$${PackageType}",
                "WAR"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The version of Java Development Kit (JDK) on which the deployment package of the application depends. \nValid values: Open JDK 7 and Open JDK 8. This parameter is not supported when you deploy an application by using images."
    },
    "AllowedValues": [
      "Open JDK 7",
      "Open JDK 8"
    ],
    "Label": {
      "en": "JDK",
      "zh-cn": "部署的包依赖的JDK版本"
    }
  }
  EOT
}

variable "internet_slb_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Internet-facing SLB instance. If this parameter is not specified, EDAS automatically purchases a new SLB instance for you."
    },
    "Label": {
      "en": "InternetSlbId",
      "zh-cn": "公网SLB ID"
    }
  }
  EOT
}

variable "pre_stop" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Exec": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Command": {
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
        },
        "HttpGet": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Required": false
              },
              "HttpHeaders": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": false
                    },
                    "Name": {
                      "Type": "String",
                      "Required": false
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Required": false
              },
              "Scheme": {
                "Type": "String",
                "AllowedValues": [
                  "HTTP",
                  "HTTPS"
                ],
                "Required": false
              },
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The pre-stop script. For example, {\"Exec\": {\"Command\": [\"ls\", \"/\"]}}."
    },
    "Label": {
      "en": "PreStop",
      "zh-cn": "应用停止前的执行脚本"
    }
  }
  EOT
}

variable "readiness" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TimeoutSeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "Exec": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Command": {
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
        },
        "InitialDelaySeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "HttpGet": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Required": false
              },
              "HttpHeaders": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": false
                    },
                    "Name": {
                      "Type": "String",
                      "Required": false
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Required": false
              },
              "Scheme": {
                "Type": "String",
                "AllowedValues": [
                  "HTTP",
                  "HTTPS"
                ],
                "Required": false
              },
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "PeriodSeconds": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "TcpSocket": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "FailureThreshold": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        },
        "SuccessThreshold": {
          "Type": "Number",
          "Required": false,
          "MinValue": 1
        }
      }
    },
    "Description": {
      "en": "The readiness check on the container."
    },
    "Label": {
      "en": "Readiness",
      "zh-cn": "容器业务状态检查"
    }
  }
  EOT
}

variable "internet_slb_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The frontend port of the Internet-facing SLB instance. Valid values: 1 to 65535."
    },
    "MinValue": 1,
    "Label": {
      "en": "InternetSlbPort",
      "zh-cn": "公网SLB前端端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "deploy_across_nodes" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to distribute application instances to multiple nodes. The value true indicates yes, whereas other values indicate no."
    },
    "Label": {
      "en": "DeployAcrossNodes",
      "zh-cn": "是否将应用实例分布到多个节点"
    }
  }
  EOT
}

variable "requests_mem" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum amount of memory allowed for each application instance when the application\nis created. Unit: MB. The value 0 indicates no limit.",
      "zh-cn": "应用创建时，每个应用实例允许的最大内存限额。"
    },
    "MinValue": 0,
    "Label": {
      "zh-cn": "应用创建时最大内存限额"
    }
  }
  EOT
}

variable "package_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "FatJar": {
          "en": "FatJar",
          "zh-cn": "FatJar包"
        },
        "WAR": {
          "en": "WAR",
          "zh-cn": "WAR包"
        },
        "Image": {
          "en": "Image",
          "zh-cn": "镜像"
        }
      }
    },
    "Description": {
      "en": "The type of the deployment package. Valid values: FatJar, WAR, and Image."
    },
    "AllowedValues": [
      "FatJar",
      "WAR",
      "Image"
    ],
    "Label": {
      "en": "PackageType",
      "zh-cn": "应用包类型"
    }
  }
  EOT
}

variable "use_body_encoding" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "WAR"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether useBodyEncodingForURI is enabled.\nNote If this parameter is not specified in application configuration, the default value\nfalse is applied."
    },
    "Label": {
      "en": "UseBodyEncoding",
      "zh-cn": "是否启用BodyEncoding for URL"
    }
  }
  EOT
}

variable "java_start_up_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MaxHeapSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The maximum heap size. Unit: MB. Value range: 0 to (0.85 x Available memory for ECS instances of the application)"
          },
          "Required": false
        },
        "UseGCLogFileRotation": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "CustomParams": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "String",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "If the preceding options cannot meet your requirements, you can use custom parameters. Separate parameters with spaces."
          },
          "Required": false
        },
        "ParallelGCThreads": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Number of parallel threads parallel gc will use."
          },
          "Required": false
        },
        "InitialHeapSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The size of the initial heap. Unit: MB. The value 0 indicates that the size is unlimited."
          },
          "Required": false
        },
        "NacosUseEndpointParsingRule": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Whether enable rule parsing."
          },
          "Required": false
        },
        "ThreadStackSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Thread stack size (KB)."
          },
          "Required": false
        },
        "SurvivorRatio": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Eden/Survivor Memory Size Ratio."
          },
          "Required": false
        },
        "PermSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Initial Permanent Generation Size (MB)."
          },
          "Required": false
        },
        "NewSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Initial Young Generation Size (MB)."
          },
          "Required": false
        },
        "ConcGCThreads": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Number of threads concurrent gc will use."
          },
          "Required": false
        },
        "NewRatio": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Old/Young Generation Memory Size Ratio."
          },
          "Required": false
        },
        "GCLogFileSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "GC log file size."
          },
          "Required": false
        },
        "MaxNewSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The maximum size of young generation. Unit: MB. The value max_uintx indicates that no upper limit is specified for memory usage."
          },
          "Required": false
        },
        "G1HeapRegionSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Size of the G1 regions."
          },
          "Required": false
        },
        "PrintGC": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "MaxDirectMemorySize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The maximum size of NIO direct memory. Unit: MB."
          },
          "Required": false
        },
        "MaxPermSize": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Number",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The maximum size of permanent generation. Unit: MB."
          },
          "Required": false
        },
        "HeapDumpOnOutOfMemoryError": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Whether dump memory when OOM occurs."
          },
          "Required": false
        },
        "NacosUseCloudNamespaceParsing": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Whether enable automatic namespace parsing."
          },
          "Required": false
        },
        "HeapDumpPath": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "String",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Dump File Path."
          },
          "Required": false
        },
        "GCLogFilePath": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "String",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "GC log directory."
          },
          "Required": false
        },
        "PrintGCDateStamps": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "Boolean",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "YoungGarbageCollector": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "String",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "It is used to configure young generation garbage collector."
          },
          "Required": false
        },
        "OldGarbageCollector": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Original": {
                "Type": "String",
                "Description": {
                  "en": "Indicates the configuration value."
                },
                "Required": false
              },
              "Startup": {
                "Type": "String",
                "Description": {
                  "en": "Indicates a startup parameter."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "It is used to configure the old generation garbage collector. You must configure the young generation garbage collector first."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of Java startup parameters for a Java application. These startup parameters involve the memory, application, garbage collection (GC) policy, tools, service registration and discovery, and custom configurations. Proper parameter settings help reduce the GC overhead, shorten the server response time, and improve the throughput.\nThe system automatically concatenates all startup values as the configuration of Java startup parameters for the application."
    },
    "Label": {
      "en": "JavaStartUpConfig",
      "zh-cn": "用于在Java应用启动时配置启动参数"
    }
  }
  EOT
}

variable "is_multilingual_app" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the application is a multi-language application."
    },
    "Label": {
      "en": "IsMultilingualApp",
      "zh-cn": "是否为多语言应用"
    }
  }
  EOT
}

variable "requests_cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of CPUs allowed for each application instance when the application is created. Unit: cores. The value 0 indicates no limit.",
      "zh-cn": "应用创建时，应用实例的CPU限额。"
    },
    "MinValue": 0,
    "Label": {
      "zh-cn": "应用创建时CPU限额"
    }
  }
  EOT
}

variable "command_args" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Argument": {
          "Type": "String",
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "Image"
          ]
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The collection of commands. For example, [{\"argument\":\"-c\"},{\"argument\":\"test\"}], where -c and test are two parameters that can be set."
    },
    "Label": {
      "en": "CommandArgs",
      "zh-cn": "命令集合"
    }
  }
  EOT
}

variable "storage_type" {
  type        = string
  default     = "SSD"
  description = <<EOT
  {
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "Only SSD is supported."
    },
    "AllowedValues": [
      "SSD"
    ],
    "Label": {
      "en": "StorageType",
      "zh-cn": "存储类型"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The cluster ID. You can query the cluster ID by calling the ListCluster operation.\nFor more information, see ListCluster."
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout interval of the change process. Unit: seconds."
    },
    "MinValue": 1,
    "Label": {
      "en": "Timeout",
      "zh-cn": "变更流程超时时间"
    }
  }
  EOT
}

variable "envs" {
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
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The collection of deployment environment variables. For example, [{\"Name\":\"x\",\"Value\":\"y\"},{\"Name\":\"x2\",\"Value\":\"y2\"}]."
    },
    "Label": {
      "en": "Envs",
      "zh-cn": "部署环境变量的集合"
    }
  }
  EOT
}

variable "image_url" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "Image"
          ]
        }
      }
    },
    "Description": {
      "en": "The image URL. When PackageType is set to Image, this parameter is required."
    },
    "Label": {
      "en": "ImageUrl",
      "zh-cn": "镜像地址"
    }
  }
  EOT
}

variable "deploy_across_zones" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to distribute application instances to multiple zones. The value true indicates yes, whereas other values indicate no."
    },
    "Label": {
      "en": "DeployAcrossZones",
      "zh-cn": "是否将应用实例分布到多可用区"
    }
  }
  EOT
}

variable "post_start" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Exec": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Command": {
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
        },
        "HttpGet": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Required": false
              },
              "HttpHeaders": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": false
                    },
                    "Name": {
                      "Type": "String",
                      "Required": false
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Required": false
              },
              "Scheme": {
                "Type": "String",
                "AllowedValues": [
                  "HTTP",
                  "HTTPS"
                ],
                "Required": false
              },
              "Port": {
                "Type": "String",
                "Required": false
              },
              "Host": {
                "Type": "String",
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The post-start script. For example, {\"Exec\": {\"Command\": [\"ls\", \"/\"]}}."
    },
    "Label": {
      "en": "PostStart",
      "zh-cn": "应用启动后的脚本"
    }
  }
  EOT
}

variable "internet_target_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The backend port of the internal-facing SLB instance, which is also the service port of the application.\nValid values: 1 to 65535.",
      "zh-cn": "公网SLB后端端口，也是应用的服务端口。"
    },
    "MinValue": 1,
    "Label": {
      "en": "InternetTargetPort",
      "zh-cn": "公网SLB后端端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "replicas" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "The number of instances for the application that you want to create. Default: 1"
    },
    "MinValue": 1,
    "Label": {
      "en": "Replicas",
      "zh-cn": "应用实例个数"
    }
  }
  EOT
}

variable "namespace" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The namespace of the Kubernetes cluster. This parameter determines the Kubernetes namespace where your application is deployed. By default, this parameter is set to default."
    },
    "Label": {
      "en": "Namespace",
      "zh-cn": "应用程序部署的Kubernetes集群的命名空间"
    }
  }
  EOT
}

variable "application_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the application."
    },
    "Label": {
      "en": "ApplicationDescription",
      "zh-cn": "应用程序的描述"
    }
  }
  EOT
}

variable "uri_encoding" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "WAR"
          ]
        }
      }
    },
    "Description": {
      "en": "The uniform resource identifier (URI) encoding scheme. Valid values: ISO-8859-1, GBK, GB2312, and UTF-8.\nNote If this parameter is not specified in application configuration, the default URI encoding\nscheme in the Tomcat container is applied."
    },
    "Label": {
      "en": "UriEncoding",
      "zh-cn": "统一资源标识符（URI）编码方案"
    }
  }
  EOT
}

variable "intranet_target_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The backend port of the internal-facing Server Load Balancer (SLB) instance, which is also the service port of the application. Valid values: 1 to 65535.",
      "zh-cn": "私网SLB后端端口，也是应用的服务端口。"
    },
    "Label": {
      "en": "IntranetTargetPort",
      "zh-cn": "私网SLB后端端口"
    }
  }
  EOT
}

variable "mount_descs" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPath": {
          "Type": "String",
          "Description": {
            "en": "Specifies the path to mount the file system to the container where the application is running."
          },
          "Required": false
        },
        "NasPath": {
          "Type": "String",
          "Description": {
            "en": "Specifies the file storage path."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The description of the NAS mounting configuration. For example, the value can be [{\"NasPath\": \"/k8s\",\"MountPath\": \"/mnt\"}, {\"NasPath\": \"/files\", \"MountPath\": \"/app/files\"}]."
    },
    "Label": {
      "en": "MountDescs",
      "zh-cn": "挂载配置描述"
    }
  }
  EOT
}

variable "local_volume" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPath": {
          "Type": "String",
          "Description": {
            "en": "Specifies the path within the container."
          },
          "Required": false
        },
        "Type": {
          "Type": "String",
          "Description": {
            "en": "Specifies the mounting type."
          },
          "Required": false
        },
        "NodePath": {
          "Type": "String",
          "Description": {
            "en": "Specifies the host path."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The configuration for mounting host files to the container where the application is running. For example, the value can be [{\"type\":\"\", \"nodePath\":\"/localfiles\", \"mountPath\":\"/app/files\"}, {\"type\":\"Directory\", \"nodePath\":\"/mnt\", \"mountPath\":\"/app/storage\"}]."
    },
    "Label": {
      "en": "LocalVolume",
      "zh-cn": "宿主机文件挂载到容器内的配置"
    }
  }
  EOT
}

variable "runtime_class_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the container runtime. This parameter is applicable only to clusters that use sandboxed containers."
    },
    "Label": {
      "en": "RuntimeClassName",
      "zh-cn": "容器运行时的类型"
    }
  }
  EOT
}

variable "command" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "Image"
          ]
        }
      }
    },
    "Description": {
      "en": "The command that is specified. If it is specified, it replaces the startup command in the image when the image is started."
    },
    "Label": {
      "en": "Command",
      "zh-cn": "命令"
    }
  }
  EOT
}

variable "internet_slb_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol of the Internet-facing SLB instance. Valid values: TCP, HTTP, and HTTPS."
    },
    "AllowedValues": [
      "TCP",
      "HTTP",
      "HTTPS"
    ],
    "Label": {
      "en": "InternetSlbProtocol",
      "zh-cn": "公网SLB协议"
    }
  }
  EOT
}

variable "edas_container_version" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${PackageType}",
                "FatJar"
              ]
            },
            {
              "Fn::Equals": [
                "$${PackageType}",
                "WAR"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The version of EDAS Container on which the deployment package of the application depends.\nNote This parameter is not supported when you deploy an application by using images."
    },
    "Label": {
      "en": "EdasContainerVersion",
      "zh-cn": "应用程序的部署包所依赖的EDAS容器的版本"
    }
  }
  EOT
}

variable "package_url" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${PackageType}",
                "FatJar"
              ]
            },
            {
              "Fn::Equals": [
                "$${PackageType}",
                "WAR"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The URL of the deployment package. This parameter must be set for the applications\nthat are deployed by using FatJar or WAR packages.\nNote The version of SDK for Java or Python must be 2.44.0 or later."
    },
    "Label": {
      "en": "PackageUrl",
      "zh-cn": "部署包地址"
    }
  }
  EOT
}

variable "intranet_slb_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The frontend port of the internal-facing SLB instance. Valid values: 1 to 65535."
    },
    "MinValue": 1,
    "Label": {
      "en": "IntranetSlbPort",
      "zh-cn": "私网SLB前端端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "repo_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PackageType}",
            "Image"
          ]
        }
      }
    },
    "Description": {
      "en": "The ID of the image repository."
    },
    "Label": {
      "en": "RepoId",
      "zh-cn": "镜像的仓库ID"
    }
  }
  EOT
}

variable "enable_ahas" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable access to Application High Availability Service (AHAS)."
    },
    "Label": {
      "en": "EnableAhas",
      "zh-cn": "是否接入应用高可用服务AHAS"
    }
  }
  EOT
}

variable "limit_mem" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum amount of memory allowed for each application instance when the application is running. Unit: MB.",
      "zh-cn": "应用运行过程中，应用实例的内存限额。"
    },
    "MinValue": 1,
    "Label": {
      "zh-cn": "应用运行时实例内存限额"
    }
  }
  EOT
}

resource "alicloud_edas_k8s_application" "k8s_application" {
  logical_region_id      = var.logical_region_id
  nas_id                 = var.nas_id
  web_container          = var.web_container
  package_version        = var.package_version
  internet_slb_id        = var.internet_slb_id
  internet_slb_port      = var.internet_slb_port
  requests_mem           = var.requests_mem
  package_type           = var.package_type
  cluster_id             = var.cluster_id
  image_url              = var.image_url
  internet_target_port   = var.internet_target_port
  replicas               = var.replicas
  namespace              = var.namespace
  command                = var.command
  internet_slb_protocol  = var.internet_slb_protocol
  edas_container_version = var.edas_container_version
  package_url            = var.package_url
  limit_mem              = var.limit_mem
}

output "app_id" {
  value       = alicloud_edas_k8s_application.k8s_application.id
  description = "The ID of the application."
}

output "cluster_id" {
  value       = alicloud_edas_k8s_application.k8s_application.cluster_id
  description = "The cluster ID of the application."
}

output "change_order_id" {
  // Could not transform ROS Attribute ChangeOrderId to Terraform attribute.
  value       = null
  description = "The ID of the change process."
}

output "cs_cluster_id" {
  // Could not transform ROS Attribute CsClusterId to Terraform attribute.
  value       = null
  description = "The K8s cluster ID of the application."
}

output "app_name" {
  value       = alicloud_edas_k8s_application.k8s_application.application_name
  description = "The name of the application."
}

