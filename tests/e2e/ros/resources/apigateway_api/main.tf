variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the API, less than 180 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "API描述信息"
    }
  }
  EOT
}

variable "force_nonce_check" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Set ForceNonceCheck to true, compulsorily check X-Ca-Nonce when requesting, \nthis is the unique identifier of the request, generally using UUID to identify. \nThe API gateway will verify the validity of this parameter after receiving this parameter. \nThe same value can only be used once within 15 minutes. It can effectively prevent API replay attacks.\nSet ForceNonceCheck to false, then no check. ",
      "zh-cn": "请求时是否强制检查X-Ca-Nonce"
    },
    "Label": {
      "en": "ForceNonceCheck",
      "zh-cn": "请求时是否强制检查X-Ca-Nonce"
    }
  }
  EOT
}

variable "allow_signature_method" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If the AuthType is APP authentication, you need to pass this value to specify the signature algorithm. If you do not specify this parameter, the default value HmacSHA256 is used. Valid values:\nHmacSHA256\nHmacSHA1,HmacSHA256",
      "zh-cn": "当AuthType为APP认证时，需要传该值明确签名算法。"
    },
    "AllowedValues": [
      "HmacSHA256",
      "HmacSHA1,HmacSHA256"
    ],
    "Label": {
      "en": "AllowSignatureMethod",
      "zh-cn": "当AuthType为APP认证时"
    }
  }
  EOT
}

variable "error_code_samples" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the ERROR, less than 180 characters."
          },
          "Required": false
        },
        "Message": {
          "Type": "String",
          "Description": {
            "en": "Error message."
          },
          "Required": true
        },
        "Code": {
          "Type": "String",
          "Description": {
            "en": "Error code."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The Error Code samples."
    },
    "Label": {
      "en": "ErrorCodeSamples",
      "zh-cn": "后端服务返回的错误码示例"
    }
  }
  EOT
}

variable "request_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RegularExpression": {
          "Type": "String",
          "Description": {
            "en": "The regular expression of the parameter when it is String."
          },
          "Required": false
        },
        "ParameterType": {
          "Type": "String",
          "Description": {
            "en": "The type of the parameter"
          },
          "AllowedValues": [
            "String",
            "Int",
            "Long",
            "Float",
            "Double",
            "Boolean"
          ],
          "Required": true
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the API, less than 180 characters."
          },
          "Required": false
        },
        "JsonScheme": {
          "Type": "String",
          "Description": {
            "en": "The json scheme of the parameter when it is String."
          },
          "Required": false
        },
        "ApiParameterName": {
          "Type": "String",
          "Description": {
            "en": "The name of the request parameter."
          },
          "Required": true
        },
        "EnumValue": {
          "Type": "String",
          "Description": {
            "en": "Allowed parameter value, split with ',' like \"1,2,3,4\""
          },
          "Required": false
        },
        "MinLength": {
          "Type": "Number",
          "Description": {
            "en": "The min length of the parameter when it is String."
          },
          "Required": false
        },
        "MaxValue": {
          "Type": "Number",
          "Description": {
            "en": "The max value of the parameter when it is Int, Long, Float or Double."
          },
          "Required": false
        },
        "MaxLength": {
          "Type": "Number",
          "Description": {
            "en": "The max length of the parameter when it is String."
          },
          "Required": false
        },
        "DemoValue": {
          "Type": "String",
          "Description": {
            "en": "The demo value of the request parameter."
          },
          "Required": false
        },
        "DefaultValue": {
          "Type": "String",
          "Description": {
            "en": "The default value of the request parameter."
          },
          "Required": false
        },
        "Required": {
          "Type": "String",
          "Description": {
            "en": "If required. \"REQUIRED\", \"OPTION\""
          },
          "AllowedValues": [
            "REQUIRED",
            "OPTION"
          ],
          "Required": true
        },
        "DocOrder": {
          "Type": "Number",
          "Description": {
            "en": "The order of the doc."
          },
          "Required": false
        },
        "MinValue": {
          "Type": "Number",
          "Description": {
            "en": "The min value of the parameter when it is Int, Long, Float or Double."
          },
          "Required": false
        },
        "DocShow": {
          "Type": "String",
          "Description": {
            "en": "Visiablity of the Doc. \"PUBLIC\" or \"PRIVATE\""
          },
          "AllowedValues": [
            "PUBLIC",
            "PRIVATE"
          ],
          "Required": false
        },
        "Location": {
          "Type": "String",
          "Description": {
            "en": "The location of the reqest parameter."
          },
          "AllowedValues": [
            "BODY",
            "HEAD",
            "QUERY",
            "PATH"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The request parameters."
    },
    "Label": {
      "en": "RequestParameters",
      "zh-cn": "Consumer向网关发送API请求的参数描述"
    }
  }
  EOT
}

variable "service_parameters_map" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RequestParameterName": {
          "Type": "String",
          "Description": {
            "en": "The corresponding request parameter, system parameter or const parameter."
          },
          "Required": true
        },
        "ServiceParameterName": {
          "Type": "String",
          "Description": {
            "en": "The corresponding service parameter."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The mapping relation between (request parameters\\const parameters\\system parameters) and service parameters."
    },
    "Label": {
      "en": "ServiceParametersMap",
      "zh-cn": "Consumer向网关发送请求的参数和网关向后端服务发送请求的参数的映射关系"
    }
  }
  EOT
}

variable "app_code_auth_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "When AuthType is APP authentication, the optional values are as follows: If not passed, the default value is DEFAULT:\nDEFAULT: Default (set by group).\nDISABLE: Not allowed\nHEADER: Allow AppCode header authentication\nHEADER_QUERY: Allow AppCode header and query authentication"
    },
    "AllowedValues": [
      "DEFAULT",
      "DISABLE",
      "HEADER",
      "HEADER_QUERY"
    ],
    "Label": {
      "en": "AppCodeAuthType",
      "zh-cn": "AppCode认证方式"
    }
  }
  EOT
}

variable "result_body_model" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The return result of the API."
    },
    "Label": {
      "en": "ResultBodyModel",
      "zh-cn": "API的返回结果"
    }
  }
  EOT
}

variable "service_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ServiceAddress": {
          "Type": "String",
          "Description": {
            "en": "Backend service call address. If the complete backend service address is http://api.a.com:8080/object/add?key1=value1&key2=value2, ServiceAddress corresponds to http://api.a.com:8080."
          },
          "Required": false
        },
        "FunctionComputeConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Description": {
                  "en": "The backend request path must contain the Parameter Path in the backend service parameter within brackets ([]). For example: /getUserInfo/[userId]."
                },
                "Required": false
              },
              "fcRegionId": {
                "Type": "String",
                "Description": {
                  "en": "The region id of function compute."
                },
                "Required": false
              },
              "FcVersion": {
                "Type": "String",
                "Description": {
                  "en": "Function version. Default: 2.0.\nValid values: 2.0, 3.0."
                },
                "AllowedValues": [
                  "2.0",
                  "3.0"
                ],
                "Required": false
              },
              "ContentTypeValue": {
                "Type": "String",
                "Description": {
                  "en": "ContentTypeValue is required if ContentTypeCatagory is DEFAULT or CUSTOM."
                },
                "Required": false
              },
              "functionName": {
                "Type": "String",
                "Description": {
                  "en": "The function name of function compute."
                },
                "Required": false
              },
              "Method": {
                "Type": "String",
                "Description": {
                  "en": "The HTTP method of the function. Default is GET."
                },
                "AllowedValues": [
                  "GET",
                  "POST",
                  "DELETE",
                  "PUT",
                  "HEAD",
                  "PATCH",
                  "OPTIONS",
                  "ANY"
                ],
                "Required": false,
                "Default": "GET"
              },
              "OnlyBusinessPath": {
                "Type": "Boolean",
                "Description": {
                  "en": "If set true. The path in the trigger path (for example, /2016-08-15/proxy/xxx/xxx) will not be passed to the backend, and the backend will only receive the customized backend request path."
                },
                "Required": false
              },
              "FcRegionId": {
                "Type": "String",
                "Description": {
                  "en": "The region id of function compute."
                },
                "Required": false
              },
              "serviceName": {
                "Type": "String",
                "Description": {
                  "en": "The service name of function compute."
                },
                "Required": false
              },
              "RoleArn": {
                "Type": "String",
                "Description": {
                  "en": "Ram authorizes the arn of the API gateway access function compute."
                },
                "Required": false
              },
              "FcBaseUrl": {
                "Type": "String",
                "Description": {
                  "en": "Trigger path. Starts with http:// or https://"
                },
                "Required": false
              },
              "FunctionName": {
                "Type": "String",
                "Description": {
                  "en": "The function name of function compute."
                },
                "Required": false
              },
              "ServiceName": {
                "Type": "String",
                "Description": {
                  "en": "The service name of function compute."
                },
                "Required": false
              },
              "roleArn": {
                "Type": "String",
                "Description": {
                  "en": "Ram authorizes the arn of the API gateway access function compute."
                },
                "Required": false
              },
              "qualifier": {
                "Type": "String",
                "Description": {
                  "en": "The service alias name."
                },
                "Required": false
              },
              "FcType": {
                "Type": "String",
                "Description": {
                  "en": "Function type. Default: FCEvent.\nValid values: FCEvent, HttpTrigger."
                },
                "AllowedValues": [
                  "FCEvent",
                  "HttpTrigger"
                ],
                "Required": false,
                "Default": "FCEvent"
              },
              "Qualifier": {
                "Type": "String",
                "Description": {
                  "en": "The service alias name."
                },
                "Required": false
              },
              "ContentTypeCatagory": {
                "Type": "String",
                "Description": {
                  "en": "Specify how to determine ContentType header when using function. \"DEFAULT\" to use API Gateway's default value. \"CUSTOM\" to use self defined value. \"CLIENT\" to use client's ContentType header. Default is CLIENT."
                },
                "AllowedValues": [
                  "DEFAULT",
                  "CUSTOM",
                  "CLIENT"
                ],
                "Required": false,
                "Default": "CLIENT"
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configuration of the function compute. FunctionComputeConfig is required if ServiceFunctionComputeEnable is TRUE."
          },
          "Required": false
        },
        "MockResult": {
          "Type": "String",
          "Description": {
            "en": "The returned value when using Mock model."
          },
          "Required": false
        },
        "ContentTypeValue": {
          "Type": "String",
          "Description": {
            "en": "ContentTypeValue is required if ContentTypeCatagory is DEFAULT or CUSTOM."
          },
          "Required": false
        },
        "VpcConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "VpcId": {
                "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
                "Type": "String",
                "Description": {
                  "en": "The id of the VPC."
                },
                "Required": true
              },
              "InstanceId": {
                "Type": "String",
                "Description": {
                  "en": "The id of the instance (ECS/SLB)."
                },
                "Required": true
              },
              "Port": {
                "Type": "Number",
                "Description": {
                  "en": "The port of the VPC."
                },
                "Required": true
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configuration of the VPC. VpcConfig is required if ServiceVpcEnable is TRUE. "
          },
          "Required": false
        },
        "ServiceVpcEnable": {
          "Type": "String",
          "Description": {
            "en": "Whether to use VPC. \"TRUE\" or \"FALSE\". Default is FALSE."
          },
          "AllowedValues": [
            "TRUE",
            "FALSE"
          ],
          "Required": false,
          "Default": "FALSE"
        },
        "MockStatusCode": {
          "Type": "Number",
          "Description": {
            "en": "Status code, returned in the format compatible with HTTP 1.1 response status code and its status"
          },
          "Required": false
        },
        "MockHeaders": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "HeaderValue": {
                "Type": "String",
                "Description": {
                  "en": "Response header value"
                },
                "Required": true
              },
              "HeaderName": {
                "Type": "String",
                "Description": {
                  "en": "Response header name"
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "Custom Mock response header related information when Mock is enabled."
          },
          "Required": false
        },
        "ServiceHttpMethod": {
          "Type": "String",
          "Description": {
            "en": "The HTTP method to the service. Default is GET."
          },
          "AllowedValues": [
            "GET",
            "POST",
            "DELETE",
            "PUT",
            "HEAD",
            "TRACE",
            "PATCH",
            "CONNECT",
            "OPTIONS",
            "ANY"
          ],
          "Required": false,
          "Default": "GET"
        },
        "ServicePath": {
          "Type": "String",
          "Description": {
            "en": "Backend service call path. If the complete backend service address is http://api.a.com:8080/object/add?key1=value1&key2=value2, ServicePath corresponds to /object/add."
          },
          "Required": false
        },
        "AoneAppName": {
          "Type": "String",
          "Description": {
            "en": "Aone APP Name."
          },
          "Required": false
        },
        "Mock": {
          "Type": "String",
          "Description": {
            "en": "Whether to use Mock model. \"TRUE\" or \"FALSE\". Default is FALSE."
          },
          "AllowedValues": [
            "TRUE",
            "FALSE"
          ],
          "Required": false,
          "Default": "FALSE"
        },
        "ServiceTimeOut": {
          "Type": "Number",
          "Description": {
            "en": "Time out (ms) when using service."
          },
          "Required": false
        },
        "ServiceProtocol": {
          "Type": "String",
          "Description": {
            "en": "Backend service protocol type, which must be HTTP, HTTPS or FunctionCompute currently."
          },
          "AllowedValues": [
            "HTTP",
            "HTTPS",
            "FunctionCompute"
          ],
          "Required": false,
          "Default": "HTTP"
        },
        "ContentTypeCatagory": {
          "Type": "String",
          "Description": {
            "en": "Specify how to determine ContentType header when using service. \"DEFAULT\" to use API Gateway's default value. \"CUSTOM\" to use self defined value. \"CLIENT\" to use client's ContentType header. Default is CLIENT."
          },
          "AllowedValues": [
            "DEFAULT",
            "CUSTOM",
            "CLIENT"
          ],
          "Required": false,
          "Default": "CLIENT"
        }
      }
    },
    "Description": {
      "en": "The configuration of the service."
    },
    "Label": {
      "en": "ServiceConfig",
      "zh-cn": "网关向后端服务发送API请求的相关配置项"
    }
  }
  EOT
}

variable "web_socket_api_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ApiGatewayWebSocketApiType"
    },
    "Description": {
      "en": "The type of the two-way communication API.\nCOMMON: common API\nREGISTER: registered API\nUNREGISTER: unregistered API\nNOTIFY: downstream notification API",
      "zh-cn": "双向通信API类型"
    },
    "AllowedValues": [
      "COMMON",
      "REGISTER",
      "UNREGISTER",
      "NOTIFY"
    ],
    "Label": {
      "en": "WebSocketApiType",
      "zh-cn": "双向通信API类型"
    }
  }
  EOT
}

variable "result_descriptions" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The return description of the API."
    },
    "Label": {
      "en": "ResultDescriptions",
      "zh-cn": "结果描述"
    }
  }
  EOT
}

variable "open_id_connect_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "OpenIdApiType": {
          "Type": "String",
          "Description": {
            "en": "The type of the open id. \"IDTOKEN\" or \"BUSINESS\". If OpenIdApiType is specified as IDTOKEN, PublicKey and PublicKeyId are required. If OpenIdApiType is specified as BUSINESS, IdTokenParamName is required."
          },
          "AllowedValues": [
            "IDTOKEN",
            "BUSINESS"
          ],
          "Required": true
        },
        "PublicKey": {
          "Type": "String",
          "Description": {
            "en": "The public key."
          },
          "Required": false
        },
        "PublicKeyId": {
          "Type": "String",
          "Description": {
            "en": "The public key id."
          },
          "Required": false
        },
        "IdTokenParamName": {
          "Type": "String",
          "Description": {
            "en": "The token's parameter name."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of the open id."
    },
    "Label": {
      "en": "OpenIdConnectConfig",
      "zh-cn": "第三方账号认证OpenID Connect相关配置项"
    }
  }
  EOT
}

variable "auth_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Type of authorization of the API . \"APP\",\"ANONYMOUS\", or \"APPOPENID\""
    },
    "AllowedValues": [
      "APP",
      "ANONYMOUS",
      "APPOPENID"
    ],
    "Label": {
      "en": "AuthType",
      "zh-cn": "API安全认证类型"
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

variable "request_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RequestPath": {
          "Type": "String",
          "Description": {
            "en": "API Path."
          },
          "Required": true
        },
        "RequestMode": {
          "Type": "String",
          "Description": {
            "en": "API request mode. \"MAPPING\" or \"PASSTHROUGH\". Default is \"MAPPING\"."
          },
          "AllowedValues": [
            "MAPPING",
            "PASSTHROUGH"
          ],
          "Required": true,
          "Default": "MAPPING"
        },
        "RequestProtocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol of the request, \"HTTP\", \"HTTPS\", or \"HTTP,HTTPS\", Default is \"HTTP\"."
          },
          "AllowedValues": [
            "HTTP",
            "HTTPS",
            "HTTP,HTTPS"
          ],
          "Required": true,
          "Default": "HTTP"
        },
        "RequestHttpMethod": {
          "Type": "String",
          "Description": {
            "en": "The HTTP method of the request. Default is GET."
          },
          "AllowedValues": [
            "GET",
            "POST",
            "DELETE",
            "PUT",
            "HEAD",
            "TRACE",
            "PATCH",
            "CONNECT",
            "OPTIONS",
            "ANY"
          ],
          "Required": true,
          "Default": "GET"
        },
        "PostBodyDescription": {
          "Type": "String",
          "Description": {
            "en": "Description of the post body."
          },
          "Required": false
        },
        "BodyFormat": {
          "Type": "String",
          "Description": {
            "en": "Describe how data transform to the server, \"FORM\" for k-v and \"STREAM\" for bit stream.BodyFormat is required if RequestMode is specified as MAPPING and RequestHttpMethod is POST/PUT/PATCH."
          },
          "AllowedValues": [
            "FORM",
            "STREAM"
          ],
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of the request"
    },
    "Label": {
      "en": "RequestConfig",
      "zh-cn": "Consumer向网关发送API请求的相关配置项"
    }
  }
  EOT
}

variable "result_sample" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The sample of the result."
    },
    "Label": {
      "en": "ResultSample",
      "zh-cn": "后端服务返回应答的示例"
    }
  }
  EOT
}

variable "disable_internet" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Set DisableInternet to true, only support intranet to call API. \nSet DisableInternet to false, then the call is not restricted. \n",
      "zh-cn": "是否禁止公网调用API"
    },
    "Label": {
      "en": "DisableInternet",
      "zh-cn": "是否禁止公网调用API"
    }
  }
  EOT
}

variable "api_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the API.It must be 4 to 128 characters in length, and can contain letters, digits, underscores (_), dashes (-), spaces and dots (.), It must start with a letter."
    },
    "Label": {
      "en": "ApiName",
      "zh-cn": "API名称"
    }
  }
  EOT
}

variable "service_vpc_enable" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "zh-cn": "是否使用专有网络"
    }
  }
  EOT
}

variable "result_type" {
  type        = string
  default     = "JSON"
  description = <<EOT
  {
    "Description": {
      "en": "The format of service's response, \"JSON\", \"TEXT\", \"BINARY\", \"XML\", \"HTML\" or \"PASSTHROUGH\". Default is \"JSON\"."
    },
    "AllowedValues": [
      "JSON",
      "TEXT",
      "BINARY",
      "XML",
      "HTML",
      "PASSTHROUGH"
    ],
    "Label": {
      "en": "ResultType",
      "zh-cn": "后端服务返回应答的格式"
    }
  }
  EOT
}

variable "fail_result_sample" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The sample of the fail result."
    },
    "Label": {
      "en": "FailResultSample",
      "zh-cn": "后端服务失败返回应答的示例"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The id of the Group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "API分组编号"
    }
  }
  EOT
}

variable "const_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ConstValue": {
          "Type": "String",
          "Description": {
            "en": "The value of the parameter."
          },
          "Required": true
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the const parameter, less than 180 characters."
          },
          "Required": false
        },
        "ServiceParameterName": {
          "Type": "String",
          "Description": {
            "en": "The service parameter name."
          },
          "Required": true
        },
        "Location": {
          "Type": "String",
          "Description": {
            "en": "The location of the parameter. Default is HEAD. "
          },
          "AllowedValues": [
            "BODY",
            "HEAD",
            "QUERY",
            "PATH"
          ],
          "Required": true,
          "Default": "HEAD"
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The const parameters."
    },
    "Label": {
      "en": "ConstParameters",
      "zh-cn": "指定API的常量参数"
    }
  }
  EOT
}

variable "system_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DemoValue": {
          "Type": "String",
          "Description": {
            "en": "The demo value of the system parameter."
          },
          "Required": false
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the system parameter, less than 180 characters."
          },
          "Required": false
        },
        "ParameterName": {
          "Type": "String",
          "Description": {
            "en": "The system parameter name."
          },
          "AllowedValues": [
            "CaClientIp",
            "CaDomain",
            "CaRequestHandleTime",
            "CaAppId",
            "CaRequestId",
            "CaHttpSchema",
            "CaProxy"
          ],
          "Required": true
        },
        "ServiceParameterName": {
          "Type": "String",
          "Description": {
            "en": "The service parameter name."
          },
          "Required": true
        },
        "Location": {
          "Type": "String",
          "Description": {
            "en": "The location of the system parameter. Default is HEAD. "
          },
          "AllowedValues": [
            "BODY",
            "HEAD",
            "QUERY",
            "PATH"
          ],
          "Required": true,
          "Default": "HEAD"
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The system parameters."
    },
    "Label": {
      "en": "SystemParameters",
      "zh-cn": "API的系统参数"
    }
  }
  EOT
}

variable "visibility" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ApiGatewayVisibilityType"
    },
    "Description": {
      "en": "Whether to make the API public. \"PUBLIC\" or \"PRIVATE\".",
      "zh-cn": "API是否公开"
    },
    "AllowedValues": [
      "PUBLIC",
      "PRIVATE"
    ],
    "Label": {
      "en": "Visibility",
      "zh-cn": "API是否公开"
    }
  }
  EOT
}

variable "service_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ParameterType": {
          "Type": "String",
          "Description": {
            "en": "The type of the parameter."
          },
          "AllowedValues": [
            "STRING",
            "NUMBER",
            "BOOLEAN"
          ],
          "Required": true
        },
        "ServiceParameterName": {
          "Type": "String",
          "Description": {
            "en": "The name of the parameter"
          },
          "Required": true
        },
        "Location": {
          "Type": "String",
          "Description": {
            "en": "The location of the parameter"
          },
          "AllowedValues": [
            "BODY",
            "HEAD",
            "QUERY",
            "PATH"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The service parameters."
    },
    "Label": {
      "en": "ServiceParameters",
      "zh-cn": "网关向后端服务发送API请求的参数描述"
    }
  }
  EOT
}

resource "alicloud_api_gateway_api" "api" {
  description         = var.description
  force_nonce_check   = var.force_nonce_check
  request_parameters  = var.request_parameters
  auth_type           = var.auth_type
  request_config      = var.request_config
  name                = var.api_name
  group_id            = var.group_id
  constant_parameters = var.const_parameters
  system_parameters   = var.system_parameters
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "api_id" {
  value       = alicloud_api_gateway_api.api.id
  description = "The id of the API."
}

