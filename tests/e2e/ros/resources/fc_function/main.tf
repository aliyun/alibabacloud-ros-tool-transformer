variable "memory_size" {
  type        = number
  default     = 128
  description = <<EOT
  {
    "Description": {
      "en": "The amount of memory that’s used to run function, in MB. Function Compute uses this value to allocate CPU resources proportionally. Defaults to 128 MB. It can be multiple of 64 MB and between 128 MB and 3072 MB."
    },
    "MinValue": 128,
    "Label": {
      "en": "MemorySize",
      "zh-cn": "函数的内存规格"
    },
    "MaxValue": 32768
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Function description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "函数的描述"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  default     = 3
  description = <<EOT
  {
    "Description": {
      "en": "The maximum time duration a function can run, in seconds. After which Function Compute terminates the execution. Defaults to 3 seconds, and can be between 1 to 86400 seconds."
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
                  "en": "The timeout period for the execution. Unit: seconds."
                },
                "Required": false,
                "Label": {
                  "en": "Timeout",
                  "zh-cn": "超时时间"
                }
              },
              "Handler": {
                "Type": "String",
                "Description": {
                  "en": "The handler of the function."
                },
                "Required": false,
                "Label": {
                  "en": "Handler",
                  "zh-cn": "函数执行入口"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configuration of lifecycle callbacks."
          },
          "Required": false,
          "Label": {
            "en": "PreStop",
            "zh-cn": "预停止回调函数配置"
          }
        },
        "PreFreeze": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Timeout": {
                "Type": "Number",
                "Description": {
                  "en": "The timeout period for the execution. Unit: seconds."
                },
                "Required": false,
                "Label": {
                  "en": "Timeout",
                  "zh-cn": "超时时间"
                }
              },
              "Handler": {
                "Type": "String",
                "Description": {
                  "en": "The handler of the function."
                },
                "Required": false,
                "Label": {
                  "en": "Handler",
                  "zh-cn": "函数执行入口"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configuration of lifecycle callbacks."
          },
          "Required": false,
          "Label": {
            "en": "PreFreeze",
            "zh-cn": "预冻结回调函数配置"
          }
        }
      }
    },
    "Description": {
      "en": "The configuration of the instance lifecycle function."
    },
    "Label": {
      "en": "InstanceLifecycleConfig",
      "zh-cn": "实例生命周期函数配置"
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
      "en": "The function execution entry point."
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
      "en": "The number of vCPUs of the function. The value must be a multiple of 0.05."
    },
    "Label": {
      "en": "Cpu",
      "zh-cn": "函数的CPU规格"
    }
  }
  EOT
}

variable "custom_health_check_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TimeoutSeconds": {
          "Type": "Number",
          "Description": {
            "en": "The timeout period of health checks. Valid values: 1 to 3. Default value: 1."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 3,
          "Default": 1
        },
        "InitialDelaySeconds": {
          "Type": "Number",
          "Description": {
            "en": "The delay between the container startup and the health check. Valid values: 0 to 120. Default value: 0."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 120,
          "Default": 0
        },
        "HttpGetUrl": {
          "Type": "String",
          "Description": {
            "en": "The health check URL of the custom container. The content can be up to 2,048 characters in length."
          },
          "Required": false,
          "MaxLength": 2048
        },
        "PeriodSeconds": {
          "Type": "Number",
          "Description": {
            "en": "The health check period. Value range: 1 to 120. Default value: 3."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 120,
          "Default": 3
        },
        "FailureThreshold": {
          "Type": "Number",
          "Description": {
            "en": "The threshold for health check failures. When this value is reached, the system considers the check failed. Value range: 1 to 120. Default value: 3."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 120,
          "Default": 3
        },
        "SuccessThreshold": {
          "Type": "Number",
          "Description": {
            "en": "The threshold for health check successes. When this value is reached, the system considers the check succeeded. Value range: 1 to 120. Default value: 1."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 120,
          "Default": 1
        }
      }
    },
    "Description": {
      "en": "The health check configurations for the custom runtime and custom container."
    },
    "Label": {
      "en": "Custom Health Check Config",
      "zh-cn": "自定义健康检查配置"
    }
  }
  EOT
}

variable "custom_container_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Args": {
          "Type": "String",
          "Description": {
            "en": "Container startup parameters. For example: [\"-arg1\", \"value1\"]"
          },
          "Required": false
        },
        "InstanceId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the Container Registry Enterprise Edition instance. If you use an Enterprise Edition instance for the container image, you must add the instance ID. The default resolution IP address of the instance must be the IP address of the virtual private cloud (VPC) that the instance belongs. Alibaba Cloud DNS PrivateZone cannot be used for domain name resolution."
          },
          "Required": false
        },
        "AccelerationType": {
          "Type": "String",
          "Description": {
            "en": "Whether to enable image acceleration. Valid Values:\nDefault: Indicates that image acceleration is enabled.\nNone: Indicates that image acceleration is disabled."
          },
          "Required": false
        },
        "Command": {
          "Type": "String",
          "Description": {
            "en": "Container start command. For example: [\"/code/myserver\"]"
          },
          "Required": false
        },
        "WebServerMode": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the web server mode is used for image running.\nA value of true indicates that a web server is implemented in your container image to listen on ports and process requests.\nA value of false indicates that the container must actively exit the process after it runs, and the exit code is 0.\nDefault value: true."
          },
          "Required": false,
          "Default": true
        },
        "Image": {
          "Type": "String",
          "Description": {
            "en": "Container image address. For example: registry-vpc.cn-hangzhou.aliyuncs.com/fc-demo/helloworld:v1beta1"
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Custom container runtime related configuration. After configuration, the function can be replaced with a custom container to execute the function",
      "zh-cn": "Runtime取值为custom-container时的配置，配置后可以使用自定义容器镜像执行函数。"
    },
    "Label": {
      "en": "CustomContainerConfig",
      "zh-cn": "Runtime取值为custom-container时的配置"
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
            "en": "Base64 encoded zip file content.\nPriority: ZipFile > SourceCode > OssBucketName&OssObjectName."
          },
          "Required": false
        },
        "OssObjectName": {
          "AssociationProperty": "ALIYUN::OSS::Object::ObjectName",
          "Type": "String",
          "Description": {
            "en": "OSS object name.\nPriority: ZipFile > SourceCode > OssBucketName&OssObjectName."
          },
          "Required": false,
          "Label": {
            "en": "Object Name",
            "zh-cn": "文件名称"
          }
        },
        "OssBucketName": {
          "AssociationProperty": "ALIYUN::OSS::Bucket::BucketName",
          "Type": "String",
          "Description": {
            "en": "OSS bucket name.\nPriority: ZipFile > SourceCode > OssBucketName&OssObjectName."
          },
          "Required": false,
          "Label": {
            "en": "Bucket Name",
            "zh-cn": "Bucket名称"
          }
        }
      }
    },
    "Description": {
      "en": "The code that contains the function implementation."
    },
    "Label": {
      "en": "Function Code",
      "zh-cn": "函数代码"
    }
  }
  EOT
}

variable "async_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Destination": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "OnSuccess": {
                "Type": "String",
                "Description": {
                  "en": "When the function is invoked successfully, FC will call the target corresponding to the configuration"
                },
                "Required": false,
                "Label": {
                  "en": "OnSuccess",
                  "zh-cn": "成功回调函数配置"
                }
              },
              "OnFailure": {
                "Type": "String",
                "Description": {
                  "en": "When the function is invoked failed (system error or function internal error), FC will call the target corresponding to the configuration"
                },
                "Required": false,
                "Label": {
                  "en": "OnFailure",
                  "zh-cn": "失败回调函数配置"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Set destination of asynchronous function calls"
          },
          "Required": false
        },
        "MaxAsyncEventAgeInSeconds": {
          "Type": "Number",
          "Description": {
            "en": "Configure the maximum lifetime of messages. The duration is calculated from the time the asynchronous call is triggered, and ends when the message is dequeued for processing. If this period of time is longer than the setting value of MaxAsyncEventAgeInSeconds, the message will be discarded. The unconsumed messages will be counted in the cloud monitoring AsyncEventExpiredDropped indicator."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 2592000
        },
        "StatefulInvocation": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether enable stateful invocation"
          },
          "Required": false
        },
        "MaxAsyncRetryAttempts": {
          "Type": "Number",
          "Description": {
            "en": "Configure the number of retries"
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 8
        }
      }
    },
    "Description": {
      "en": "Configuration of asynchronous function calls"
    },
    "Label": {
      "en": "AsyncConfiguration",
      "zh-cn": "异步调用配置"
    }
  }
  EOT
}

variable "caport" {
  type        = number
  default     = 9000
  description = <<EOT
  {
    "Description": {
      "en": "Custom runtime and custom container runtime dedicated fields, which represent the port that the started custom http server listens to. The default value is 9000"
    },
    "Label": {
      "en": "CAPort",
      "zh-cn": "自定义HTTP Server监听的端口"
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
      "en": "Function name"
    },
    "Label": {
      "en": "FunctionName",
      "zh-cn": "函数名称"
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
      "en": "The function runtime environment. Supporting nodejs16、nodejs14、nodejs12、nodejs10、nodejs8、nodejs6、nodejs4.4、python3.10、python3.9、python3、python2.7、java11、java8、go1、php7.2、dotnetcore3.1、dotnetcore2.1、custom.debian10、custom和custom-container and so on"
    },
    "Label": {
      "en": "Runtime",
      "zh-cn": "函数的运行环境"
    }
  }
  EOT
}

variable "environment_variables" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The environment variable set for the function, you can get the value of the environment variable in the function."
    },
    "Label": {
      "en": "EnvironmentVariables",
      "zh-cn": "函数设置的环境变量"
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
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The startup parameters."
          },
          "Required": false
        },
        "Command": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The startup command."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Custom runtime related configuration."
    },
    "Label": {
      "en": "CustomRuntimeConfig",
      "zh-cn": "Custom Runtime函数详细配置"
    }
  }
  EOT
}

variable "initialization_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "the max execution time of the initializer, in second"
    },
    "Label": {
      "en": "InitializationTimeout",
      "zh-cn": "初始化函数运行的超时时间"
    }
  }
  EOT
}

variable "service_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Service name"
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "服务名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "initializer" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "the entry point of the initializer"
    },
    "Label": {
      "en": "Initializer",
      "zh-cn": "初始化函数执行的入口"
    }
  }
  EOT
}

variable "gpu_memory_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The GPU memory capacity for the function. Unit: MB. The value must be a multiple of 1,024."
    },
    "Label": {
      "en": "GpuMemorySize",
      "zh-cn": "function的GPU显存规格"
    }
  }
  EOT
}

variable "customdns" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Searches": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The value of the DNS search domain."
          },
          "Required": false
        },
        "DnsOptions": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Value": {
                "Type": "String",
                "Required": false
              },
              "Name": {
                "Type": "String",
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Required": false
        },
        "NameServers": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The IP address of the DNS server."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The custom DNS configurations of the function."
    },
    "Label": {
      "en": "CustomDNS",
      "zh-cn": "函数自定义DNS配置"
    }
  }
  EOT
}

variable "disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The disk size of the function. Unit: MB. Valid values: 512 and 10240."
    },
    "AllowedValues": [
      512,
      10240
    ],
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
      "en": "Function instance concurrency. Value can be between 1 to 100."
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceConcurrency",
      "zh-cn": "实例并发度"
    },
    "MaxValue": 100
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance type. Value:e1: flexible instance. Memory size between 128 and 3072c1: performance instance. Memory size allow values are 4096, 8192, 16384 and 32768"
    },
    "AllowedValues": [
      "e1",
      "c1",
      "fc.gpu.tesla.1",
      "fc.gpu.ampere.1",
      "g1"
    ],
    "Label": {
      "en": "InstanceType",
      "zh-cn": "函数实例类型"
    }
  }
  EOT
}

variable "instance_soft_concurrency" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The soft concurrency of the instance. You can use this parameter to implement graceful scale-up of instances. If the number of concurrent requests on an instance is greater than the value of soft concurrency, an instance scale-up is triggered. For example, if your instance requires a long time to start, you can specify a suitable soft concurrency to start the instance in advance.The value must be less than or equal to that of the instanceConcurrency parameter.",
      "zh-cn": "实例软并发度，用于优雅扩容。"
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceSoftConcurrency",
      "zh-cn": "实例软并发度"
    },
    "MaxValue": 100
  }
  EOT
}

resource "alicloud_fc_function" "function" {
  memory_size            = var.memory_size
  description            = var.description
  timeout                = var.timeout
  handler                = var.handler
  name                   = var.function_name
  runtime                = var.runtime
  environment_variables  = var.environment_variables
  initialization_timeout = var.initialization_timeout
  service                = var.service_name
  initializer            = var.initializer
  instance_concurrency   = var.instance_concurrency
  instance_type          = var.instance_type
}

output "function_id" {
  value       = alicloud_fc_function.function.function_id
  description = "The function ID"
}

output "function_name" {
  // Could not transform ROS Attribute FunctionName to Terraform attribute.
  value       = null
  description = "The function name"
}

output "service_name" {
  // Could not transform ROS Attribute ServiceName to Terraform attribute.
  value       = null
  description = "The service name"
}

output "arn" {
  // Could not transform ROS Attribute ARN to Terraform attribute.
  value       = null
  description = "The ARN for ALIYUN::ROS::CustomResource"
}

output "service_id" {
  // Could not transform ROS Attribute ServiceId to Terraform attribute.
  value       = null
  description = "The service ID"
}

