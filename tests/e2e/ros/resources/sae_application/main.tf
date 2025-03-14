variable "timezone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application time zone. Default Asia/Shanghai."
    },
    "Label": {
      "en": "Timezone",
      "zh-cn": "时区"
    }
  }
  EOT
}

variable "php_config" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "PHP configuration file contents."
    },
    "Label": {
      "en": "PhpConfig",
      "zh-cn": "PHP 配置文件内容"
    }
  }
  EOT
}

variable "mount_desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mount Description"
    },
    "Label": {
      "en": "MountDesc",
      "zh-cn": "挂载描述"
    }
  }
  EOT
}

variable "micro_registration_config" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Registry configuration information."
    },
    "Label": {
      "en": "MicroRegistrationConfig",
      "zh-cn": "注册中心配置信息"
    }
  }
  EOT
}

variable "liveness" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Container health check, health check fails container will be killed and recovery. Currently only supports mode command issued in the container. The columns: { \"exec\": { \"command\": [ \"sleep\", \"5s\"]}, \"initialDelaySeconds\": 10, \"timeoutSeconds\": 11}",
      "zh-cn": "容器健康检查，健康检查失败的容器将重启。"
    },
    "Label": {
      "en": "Liveness",
      "zh-cn": "容器健康检查"
    }
  }
  EOT
}

variable "war_start_options" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "War Start the application package option. Apply the default startup command: java $ JAVA_OPTS $ CATALINA_OPTS -Options org.apache.catalina.startup.Bootstrap \"$ @\" start"
    },
    "Label": {
      "en": "WarStartOptions",
      "zh-cn": "War包启动应用选项"
    }
  }
  EOT
}

variable "memory" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Each instance of the required memory, in units of MB, can not be zero. Currently only supports fixed specifications instance type.",
      "zh-cn": "每个实例所需的内存。目前仅支持固定规格的实例类型。"
    },
    "MinValue": 1,
    "Label": {
      "en": "Memory",
      "zh-cn": "每个实例所需的内存"
    }
  }
  EOT
}

variable "web_container" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Tomcat deployment of the package depends on the version. Mirroring not supported."
    },
    "Label": {
      "en": "WebContainer",
      "zh-cn": "部署包依赖的Tomcat版本"
    }
  }
  EOT
}

variable "cpu" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Each instance of the CPU required, in units of milli core, can not be zero. Currently only supports fixed specifications instance type.",
      "zh-cn": "每个实例所需的CPU。目前仅支持固定规格的实例类型。"
    },
    "MinValue": 1,
    "Label": {
      "en": "Cpu",
      "zh-cn": "每个实例所需的CPU"
    }
  }
  EOT
}

variable "nas_configs" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Configuration to mount the NAS. The values are explained as follows:\n- mountPath: The container mount path\n- readOnly: A value of false indicates read and write permission.\n- nasId: NAS ID\n- mountDomain: The container mount point address For more information, see DescribeMountTargets.\n- nasPath: NAS relative file directory"
    },
    "Label": {
      "en": "NasConfigs",
      "zh-cn": "挂载 NAS 的配置"
    }
  }
  EOT
}

variable "jar_start_args" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Jar package startup application parameters. Apply the default startup command: $ JAVA_HOME / bin / java $ JarStartOptions -jar $ CATALINA_OPTS \"$ package_path\"\n$ JarStartArgs"
    },
    "Label": {
      "en": "JarStartArgs",
      "zh-cn": "JAR包启动应用参数"
    }
  }
  EOT
}

variable "pre_stop" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Script is executed before stopping the format as: { \"exec\": { \"command\": \"cat\", \"/ etc / group\"}}"
    },
    "Label": {
      "en": "PreStop",
      "zh-cn": "容器删除前执行脚本"
    }
  }
  EOT
}

variable "php_arms_config_location" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The PHP application monitors the mount path and requires you to ensure that the PHP server loads the configuration file for this path. You don't need to worry about the configuration content; SAE will automatically render the correct configuration file.",
      "zh-cn": "PHP 应用监控挂载路径，需要您保证 PHP 服务器一定会加载这个路径的配置文件。"
    },
    "Label": {
      "en": "PhpArmsConfigLocation",
      "zh-cn": "PHP 应用监控挂载路径"
    }
  }
  EOT
}

variable "package_type" {
  type        = string
  nullable    = false
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
      "en": "Application package type. Support FatJar, War, Image."
    },
    "Label": {
      "en": "PackageType",
      "zh-cn": "应用包类型"
    }
  }
  EOT
}

variable "auto_config" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to automatically configure the network environment. The values are explained as follows:\n- true: SAE automatically config the network environment when creating the application. The values for NamespaceId, VpcId, vSwitchId, and SecurityGroupId are ignored.\n- false: SAE manually config the network environment when creating the application."
    },
    "Label": {
      "en": "AutoConfig",
      "zh-cn": "是否自动配置网络环境"
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
      "en": "Tags to attach to application. Max support 20 tags to add during create application. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "python" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Python version. Supports PYTHON 3.9.15"
    },
    "Label": {
      "en": "Python",
      "zh-cn": "Python 环境"
    }
  }
  EOT
}

variable "oss_ak_secret" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "AccessKey Secret of the OSS."
    },
    "Label": {
      "en": "OssAkSecret",
      "zh-cn": "OSS 读写的 AccessKey Secret"
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
      "en": "Application examples where the elastic card virtual switch. The switch must be located above the VPC. The same switch with EDAS namespace binding relationship. Do not fill was VSwitchId namespace binding."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "应用实例弹性网卡所在的交换机"
    }
  }
  EOT
}

variable "image_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mirroring address. Image only type of application can be configured to mirror address."
    },
    "Label": {
      "en": "ImageUrl",
      "zh-cn": "镜像地址"
    }
  }
  EOT
}

variable "post_start" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Executing the script, such as after starting the format: { \"exec\": { \"command\": \"cat\", \"/ etc / group\"}}"
    },
    "Label": {
      "en": "PostStart",
      "zh-cn": "容器启动后执行脚本"
    }
  }
  EOT
}

variable "base_app_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Base application ID."
    },
    "Label": {
      "en": "BaseAppId",
      "zh-cn": "基础应用 ID"
    }
  }
  EOT
}

variable "config_map_mount_desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "ConfigMap mount description. Use the configuration items created on the namespace configuration items page to inject configuration information into the container."
    },
    "Label": {
      "en": "ConfigMapMountDesc",
      "zh-cn": "ConfigMap挂载描述"
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
      "en": "EDAS namespace corresponding VPC. In Serverless in a corresponding one of the VPC namespace only, and can not be modified. Serverless first created in the application name space will form a binding relationship. You may correspond to a plurality of namespaces VPC. Do not fill was VpcId namespace binding."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "SAE命名空间对应的专有网络"
    }
  }
  EOT
}

variable "enable_ebpf" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable EBPF. Enable application monitoring for non-Java applications. The values are explained as follows:\n- true: Enable.\n- false: Disable.",
      "zh-cn": "基于 eBPF 技术，对非 Java 应用开启应用监控能力。"
    },
    "AllowedValues": [
      "true",
      "false"
    ],
    "Label": {
      "en": "EnableEbpf",
      "zh-cn": "基于 eBPF 技术"
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
      "en": "EDAS pandora runtime environment used by the application."
    },
    "Label": {
      "en": "EdasContainerVersion",
      "zh-cn": "EDAS Pandora应用使用的运行环境"
    }
  }
  EOT
}

variable "service_tags" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Service tags."
    },
    "Label": {
      "en": "ServiceTags",
      "zh-cn": "应用配置的灰度标签"
    }
  }
  EOT
}

variable "namespace_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "EDAS namespace corresponding to ID. Canada supports only the name of the scribe lowercase namespace must begin with a letter.\nNamespace can interface to obtain from DescribeNamespaceList."
    },
    "Label": {
      "en": "NamespaceId",
      "zh-cn": "EDAS命名空间对应ID"
    }
  }
  EOT
}

variable "tomcat_config" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Tomcat file configuration, set to \"\" or \"{}\" to delete the configuration:\n- port: Ports in the range of 1024 to 65535 require Root privileges to operate on ports below 1024 Because the container is configured with Admin access, please specify a port greater than 1024. If not configured, it defaults to 8080.\n- contextPath: The access path, defaults to the root directory \"/\"\n- maxThreads: This config the number of connections in the pool; the default is 400.\n- uriEncoding: Tomcat's encoding formats, including UTF-8, ISO-8859-1, GBK, and GB2312 If not set, it defaults to ISO-8859-1.\n- useBodyEncodingForUri: Whether to useBodyEncoding for URL (defaults to true)."
    },
    "Label": {
      "en": "TomcatConfig",
      "zh-cn": "Tomcat 文件配置"
    }
  }
  EOT
}

variable "app_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application description. No more than 1024 characters."
    },
    "Label": {
      "en": "AppDescription",
      "zh-cn": "应用描述信息"
    },
    "MaxLength": 1024
  }
  EOT
}

variable "nas_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mount the NAS ID, you must be in the same region and cluster. It must be available to create a mount point limit, or switch on its mount point already in the VPC. If you do not fill, and there mountDescs field, the default will automatically purchase a NAS and mount it onto the switch within the VPC."
    },
    "Label": {
      "en": "NasId",
      "zh-cn": "挂载的NAS的ID"
    }
  }
  EOT
}

variable "python_modules" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Install custom module dependencies. The dependencies defined in requirements.txt in the root directory are installed by default. If the package is not configured or customized, you can specify the dependencies to install."
    },
    "Label": {
      "en": "PythonModules",
      "zh-cn": "自定义安装模块依赖"
    }
  }
  EOT
}

variable "acr_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Container Image service ACR Enterprise Edition instance ID. Required when ImageUrl serves enterprise edition for container images."
    },
    "Label": {
      "en": "AcrInstanceId",
      "zh-cn": "ACR 企业版实例 ID"
    }
  }
  EOT
}

variable "kafka_configs" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Logs are ingested to Kafka configuration summary information. The values are explained as follows:\n- kafkaEndpoint: The service access address for the Kafka API\n- kafkaInstanceId: Kafka instance ID\n- kafkaConfigs: Configuration summary information for one or more logs See Request parameters kafkaConfigs for a description of these values."
    },
    "Label": {
      "en": "KafkaConfigs",
      "zh-cn": "日志采集到 Kafka 的配置汇总信息"
    }
  }
  EOT
}

variable "sls_configs" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Log collection configuration file"
    },
    "Label": {
      "en": "SlsConfigs",
      "zh-cn": "文件日志采集配置"
    }
  }
  EOT
}

variable "oss_ak_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "AccessKey ID of the OSS."
    },
    "Label": {
      "en": "OssAkId",
      "zh-cn": "OSS 读写的 AccessKey ID"
    }
  }
  EOT
}

variable "oss_mount_descs" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "OSS mount description information. The parameters are described as follows:\n- bucketName: The name of the Bucket\n- bucketPath: The directory or OSS object you created in OSS that will raise an exception if the OSS mount directory does not exist.\n- mountPath: Your container path in SAE. If the path already exists, it is a covering relationship. If the path doesn't exist, it will be created.\n- readOnly: This specifies whether the container path has read-only permissions for mount directory resources:\n  - true: Read-only permission\n  - false: Read and write permissions"
    },
    "Label": {
      "en": "OssMountDescs",
      "zh-cn": "OSS 挂载描述信息"
    }
  }
  EOT
}

variable "deploy" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether deployed immediately take effect, the default is true."
    },
    "Label": {
      "en": "Deploy",
      "zh-cn": "是否立即部署"
    }
  }
  EOT
}

variable "deployment_type" {
  type        = string
  default     = "Code"
  description = <<EOT
  {
    "Description": {
      "en": "The deployment type of the application, support image deployment and code package deployment.",
      "zh-cn": "应用部署方式，支持镜像部署与代码包部署"
    },
    "AllowedValues": [
      "Code",
      "Image"
    ],
    "Label": {
      "en": "Deployment Type",
      "zh-cn": "部署类型"
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
      "en": "The version number of the deployed package, War FatJar type required. Please customize it meaning."
    },
    "Label": {
      "en": "PackageVersion",
      "zh-cn": "部署的包的版本号"
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
      "en": "Application Name. Allowed numbers, letters and underlined combinations thereof. We must begin with the letters, the maximum length of 36 characters."
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
      "en": "Deployment of JDK version of the package depends on. Mirroring not supported."
    },
    "AllowedValues": [
      "Open JDK 7",
      "Open JDK 8",
      "Dragonwell 11",
      "Dragonwell 8",
      "openjdk-8u191-jdk-alpine3.9",
      "openjdk-7u201-jdk-alpine3.9"
    ],
    "Label": {
      "en": "Jdk",
      "zh-cn": "部署包依赖的JDK版本"
    }
  }
  EOT
}

variable "readiness" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application launch status check, health check fails repeatedly container will be killed and restarted. Do not pass health check of the vessel will not have to enter SLB traffic. For example: { \"exec\": { \"command\": [ \"sleep\", \"6s\"]}, \"initialDelaySeconds\": 15, \"timeoutSeconds\": 12}"
    },
    "Label": {
      "en": "Readiness",
      "zh-cn": "应用启动状态检查脚本"
    }
  }
  EOT
}

variable "micro_registration" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Select the Nacos registry with the following values:\n- 0: SAE built-in Nacos.\n- 1: User-built Nacos.\n- 2: MSE commercial version of Nacos."
    },
    "AllowedValues": [
      "0",
      "1",
      "2"
    ],
    "Label": {
      "en": "MicroRegistration",
      "zh-cn": "选择 Nacos 注册中心"
    }
  }
  EOT
}

variable "php" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "PHP version."
    },
    "Label": {
      "en": "Php",
      "zh-cn": "PHP 部署包依赖的 PHP 版本"
    }
  }
  EOT
}

variable "command_args" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mirroring the start command parameters. Parameters required for the start-command. For example: [ \"1d\"]"
    },
    "Label": {
      "en": "CommandArgs",
      "zh-cn": "镜像启动命令参数"
    }
  }
  EOT
}

variable "acr_assume_role_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ARN of the RAM role required when pulling the image across accounts."
    },
    "Label": {
      "en": "AcrAssumeRoleArn",
      "zh-cn": "跨账号拉取镜像时所需的 RAM 角色的 ARN"
    }
  }
  EOT
}

variable "sae_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SAE version."
    },
    "Label": {
      "en": "SaeVersion",
      "zh-cn": "SAE 版本"
    }
  }
  EOT
}

variable "termination_grace_period_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Graceful offline timeout, default 30, unit of seconds. The value ranges from 1 to 300."
    },
    "MinValue": 1,
    "Label": {
      "en": "TerminationGracePeriodSeconds",
      "zh-cn": "优雅下线超时时间"
    },
    "MaxValue": 300
  }
  EOT
}

variable "envs" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Container environment variable parameters. For example: [{ \"name\": \"envtmp\", \"value\": \"0\"}]"
    },
    "Label": {
      "en": "Envs",
      "zh-cn": "容器环境变量参数"
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
      "en": "Security group ID."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "pvtz_discovery_svc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Enable K8s Service registration discovery. The values are explained as follows:\n- serviceName: The name of the service The format is custom-namespace ID, in which the postfix-namespace ID does not support customization and needs to be filled in according to the namespace of the application. For example, choosing the default namespace for the North China 2 (Beijing) region would be -cn-beijing-default.\n- namespaceId: The namespace ID\n- portProtocols: Ports and protocols The port is in the range [1,65535] and supports both TCP and UDP protocols.\n- portAndProtocol: Ports and protocols The port is in the range [1,65535] and supports both TCP and UDP protocols. portProtocols is preferred. If portProtocols is set, only portProtocols will take effect.\n- enable: Enable K8s Service registration discovery."
    },
    "Label": {
      "en": "PvtzDiscoverySvc",
      "zh-cn": "开启 K8s Service 服务注册发现"
    }
  }
  EOT
}

variable "image_pull_secrets" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Corresponding to the secret dictionary ID."
    },
    "Label": {
      "en": "ImagePullSecrets",
      "zh-cn": "对应保密字典 ID"
    }
  }
  EOT
}

variable "jar_start_options" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Jar start the application package option. Apply the default startup command: $ JAVA_HOME / bin / java $ JarStartOptions -jar $ CATALINA_OPTS \"$ package_path\"\n$ JarStartArgs"
    },
    "Label": {
      "en": "JarStartOptions",
      "zh-cn": "JAR包启动应用选项"
    }
  }
  EOT
}

variable "mount_host" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "nas mount point in the application of vpc."
    },
    "Label": {
      "en": "MountHost",
      "zh-cn": "NAS在专有网络内的挂载点"
    }
  }
  EOT
}

variable "replicas" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The initial number of instances."
    },
    "Label": {
      "en": "Replicas",
      "zh-cn": "初始实例数"
    }
  }
  EOT
}

variable "custom_host_alias" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Custom mapping host vessel. For example: [{ \"hostName\": \"samplehost\", \"ip\": \"127.0.0.1\"}]"
    },
    "Label": {
      "en": "CustomHostAlias",
      "zh-cn": "容器内自定义host映射"
    }
  }
  EOT
}

variable "app_source" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application source."
    },
    "Label": {
      "en": "AppSource",
      "zh-cn": "微服务应用"
    }
  }
  EOT
}

variable "associate_eip" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to bind EIP. The values are explained as follows:\n- true: Binding.\n- false: No binding"
    },
    "Label": {
      "en": "AssociateEip",
      "zh-cn": "是否绑定 EIP"
    }
  }
  EOT
}

variable "command" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mirroring the start command. The command object in memory executable container must be. For example: sleep. This command will cause the image to set the original startup command failure."
    },
    "Label": {
      "en": "Command",
      "zh-cn": "镜像启动命令"
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
      "en": "Deployment packages address. Only FatJar War or the type of application can be configured to deploy packet address."
    },
    "Label": {
      "en": "PackageUrl",
      "zh-cn": "部署包地址"
    }
  }
  EOT
}

variable "php_config_location" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "PHP application launch configuration mount path, you need to ensure that the PHP server will be started with this configuration file."
    },
    "Label": {
      "en": "PhpConfigLocation",
      "zh-cn": "PHP 应用启动配置挂载路径"
    }
  }
  EOT
}

variable "programming_language" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Create the stack language for the application. The values are explained as follows:\n- java: The Java language\n- php: PHP language.\n- other: Multiple languages such as Python, C++, Go,.NET, Node.js, etc."
    },
    "AllowedValues": [
      "java",
      "php",
      "other"
    ],
    "Label": {
      "en": "ProgrammingLanguage",
      "zh-cn": "创建应用的技术栈语言"
    }
  }
  EOT
}

resource "alicloud_sae_application" "application" {
  timezone                         = var.timezone
  php_config                       = var.php_config
  mount_desc                       = var.mount_desc
  liveness                         = var.liveness
  war_start_options                = var.war_start_options
  memory                           = var.memory
  web_container                    = var.web_container
  cpu                              = var.cpu
  jar_start_args                   = var.jar_start_args
  pre_stop                         = var.pre_stop
  php_arms_config_location         = var.php_arms_config_location
  package_type                     = var.package_type
  auto_config                      = var.auto_config
  tags                             = var.tags
  oss_ak_secret                    = var.oss_ak_secret
  vswitch_id                       = var.vswitch_id
  image_url                        = var.image_url
  post_start                       = var.post_start
  config_map_mount_desc            = var.config_map_mount_desc
  vpc_id                           = var.vpc_id
  edas_container_version           = var.edas_container_version
  namespace_id                     = var.namespace_id
  tomcat_config                    = var.tomcat_config
  app_description                  = var.app_description
  nas_id                           = var.nas_id
  acr_instance_id                  = var.acr_instance_id
  sls_configs                      = var.sls_configs
  oss_ak_id                        = var.oss_ak_id
  deploy                           = var.deploy
  package_version                  = var.package_version
  app_name                         = var.app_name
  jdk                              = var.jdk
  readiness                        = var.readiness
  micro_registration               = var.micro_registration
  php                              = var.php
  command_args                     = var.command_args
  acr_assume_role_arn              = var.acr_assume_role_arn
  termination_grace_period_seconds = var.termination_grace_period_seconds
  envs                             = var.envs
  security_group_id                = var.security_group_id
  image_pull_secrets               = var.image_pull_secrets
  jar_start_options                = var.jar_start_options
  mount_host                       = var.mount_host
  replicas                         = var.replicas
  custom_host_alias                = var.custom_host_alias
  command                          = var.command
  package_url                      = var.package_url
  php_config_location              = var.php_config_location
  programming_language             = var.programming_language
}

output "app_id" {
  value       = alicloud_sae_application.application.id
  description = "Creating successful application ID."
}

output "change_order_id" {
  // Could not transform ROS Attribute ChangeOrderId to Terraform attribute.
  value       = null
  description = "Return to release a single ID, used to query task execution status."
}

