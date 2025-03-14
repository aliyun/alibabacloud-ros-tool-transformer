variable "policy" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Bucket policy"
    },
    "Label": {
      "en": "Policy",
      "zh-cn": "存储空间策略"
    }
  }
  EOT
}

variable "enable_oss_hdfs_service" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether enable OSS-HDFS service. \n**Note**: Once it's enabled, it can't be disabled again."
    },
    "Label": {
      "en": "EnableOssHdfsService",
      "zh-cn": "是否开启OSS-HDFS服务"
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
      "en": "The resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "storage_class" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "OSSStorageClass"
    },
    "Description": {
      "en": "Specifies the storage class of the bucket. Default is \"Standard\"."
    },
    "AllowedValues": [
      "Standard",
      "IA",
      "Archive",
      "ColdArchive"
    ],
    "Label": {
      "en": "StorageClass",
      "zh-cn": "存储空间类型"
    }
  }
  EOT
}

variable "redundancy_type" {
  type        = string
  default     = "LRS"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "OSSRedundancyType"
    },
    "Description": {
      "en": "Specifies the data disaster recovery type of the storage space. The value range is as follows:\nLRS (default): Local redundant LRS stores your data redundantly on different storage devices in the same availability zone, and can support data loss and normal access even when two storage devices are damaged concurrently.\nZRS: Intra-city redundant ZRS adopts a data redundancy storage mechanism in multiple availability zones (AZ), and stores user data redundantly in multiple availability zones in the same region. When an availability zone is unavailable, normal access to data can still be guaranteed."
    },
    "AllowedValues": [
      "LRS",
      "ZRS"
    ],
    "Label": {
      "zh-cn": "存储冗余类型"
    }
  }
  EOT
}

variable "lifecycle_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Rule": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Status": {
                    "Type": "String",
                    "AllowedValues": [
                      "Enabled",
                      "Disabled"
                    ],
                    "Required": false,
                    "Label": {
                      "zh-cn": "规则是否启用"
                    }
                  },
                  "AbortMultipartUpload": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "CreatedBeforeDate": {
                          "Type": "String",
                          "Required": false,
                          "Label": {
                            "zh-cn": "最后更新日期早于该日期的数据执行规则"
                          }
                        },
                        "Days": {
                          "Type": "Number",
                          "Required": false,
                          "Label": {
                            "zh-cn": "对象修改后规则生效时间"
                          }
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "未完成分片上传的过期属性"
                    }
                  },
                  "Filter": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Not": {
                          "AssociationPropertyMetadata": {
                            "Parameters": {
                              "Prefix": {
                                "Type": "String",
                                "Description": {
                                  "en": "The Object prefix to which this exclusion rule applies.\n- If Prefix is configured under Rule node, the Prefix under Not node must be prefixed by the Prefix under Rule node. For example, if the Prefix configured under the Rule node is dir, the Prefix under the Not node must begin with dir, such as dir1, dir2, and so on.\n- If the Tag is Not configured under the Not node, the Prefix configured under the NOT node cannot be the same as the Prefix configured under the Rule node."
                                },
                                "Required": false
                              },
                              "Tag": {
                                "AssociationPropertyMetadata": {
                                  "Parameter": {
                                    "Type": "String",
                                    "Required": false
                                  }
                                },
                                "AssociationProperty": "List[Parameter]",
                                "Type": "Json",
                                "Description": {
                                  "en": "At most one Object tag to which this exclusion rule applies."
                                },
                                "Required": false,
                                "MaxLength": 1
                              }
                            }
                          },
                          "Type": "Json",
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "This exclusion rule has at most one conditional argument container."
                    },
                    "Required": false
                  },
                  "Expiration": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ExpiredObjectDeleteMarker": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "Specifies whether expired delete tags should be removed automatically. The values are as follows:\n- true: This means that the expiration delete flag is automatically removed. When set to true, specifying Days or CreatedBeforeDate is not supported.\n- false: This indicates that the expiration delete marker will not be automatically removed. When false, either Days or CreatedBeforeDate must be specified."
                          },
                          "Required": false
                        },
                        "CreatedBeforeDate": {
                          "Type": "String",
                          "Required": false,
                          "Label": {
                            "zh-cn": "最后更新日期早于该日期的数据执行规则"
                          }
                        },
                        "Days": {
                          "Type": "Number",
                          "Required": false,
                          "Label": {
                            "zh-cn": "对象修改后规则生效时间"
                          }
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "对象规则的过期属性"
                    }
                  },
                  "Prefix": {
                    "Type": "String",
                    "Required": true,
                    "Label": {
                      "zh-cn": "规则所适用的前缀"
                    }
                  },
                  "ID": {
                    "Type": "String",
                    "Required": false,
                    "Label": {
                      "zh-cn": "规则的唯一ID"
                    }
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Describes lifecycle rules for the oss bucket Lifecycle Configuration property."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Rules that define how oss bucket manages objects during their lifetime."
    },
    "Label": {
      "en": "LifecycleConfiguration",
      "zh-cn": "文件生命周期配置"
    }
  }
  EOT
}

variable "server_side_encryption_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SSEAlgorithm": {
          "Type": "String",
          "Description": {
            "en": "Specifies the default server-side encryption method."
          },
          "AllowedValues": [
            "KMS",
            "AES256",
            "SM4"
          ],
          "Required": true
        },
        "KMSMasterKeyID": {
          "Type": "String",
          "Description": {
            "en": "Specifies the CMK ID when the value of SSEAlgorithm is KMS and a specified CMK is used for encryption. If the value of SSEAlgorithm is not KMS, this element must be null."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Specifies the bucket used to store the server-side encryption rule."
    },
    "Label": {
      "en": "ServerSideEncryptionConfiguration",
      "zh-cn": "服务端加密规则配置"
    }
  }
  EOT
}

variable "versioning_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Status": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "String",
          "Description": {
            "en": "Specifies the versioning state of a bucket. Valid values: Enabled and Suspended."
          },
          "AllowedValues": [
            "Enabled",
            "Suspended"
          ],
          "Required": true
        }
      }
    },
    "Description": {
      "en": "A state of versioning"
    },
    "Label": {
      "en": "VersioningConfiguration",
      "zh-cn": "保存版本控制状态的容器"
    }
  }
  EOT
}

variable "access_control" {
  type        = string
  default     = "private"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "OSSAccessControl"
    },
    "Description": {
      "en": "The access control list."
    },
    "AllowedValues": [
      "private",
      "public-read",
      "public-read-write"
    ],
    "Label": {
      "en": "AccessControl",
      "zh-cn": "访问权限"
    }
  }
  EOT
}

variable "corsconfiguration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResponseVary": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to return the Vary: Origin header. The range is as follows:\n- true: The Vary: Origin header is returned regardless of whether a cross-origin request was sent or whether the cross-origin request was successful.\n- false (default) : Do not return the Vary: Origin header under any circumstances\nNote: This field cannot be configured separately; at least one cross-domain rule must be configured to take effect."
          },
          "Required": false
        },
        "CORSRule": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "AllowedMethod": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "允许的跨域请求方法"
                    }
                  },
                  "MaxAgeSeconds": {
                    "Type": "Number",
                    "Required": false,
                    "Label": {
                      "zh-cn": "浏览器对特定资源的OPTIONS请求返回结果的缓存时间"
                    }
                  },
                  "ExposeHeader": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "允许用户从应用程序中访问的响应头"
                    }
                  },
                  "AllowedOrigin": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "允许的跨域请求的来源"
                    }
                  },
                  "AllowedHeader": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Required": false,
                    "Label": {
                      "zh-cn": "允许的跨域请求Header"
                    }
                  }
                }
              },
              "Type": "Json",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "A set of origins and methods that you allow."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Rules that define cross-origin resource sharing of objects in this bucket."
    },
    "Label": {
      "en": "CORSConfiguration",
      "zh-cn": "跨域访问配置"
    }
  }
  EOT
}

variable "bucket_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "bucket name."
    },
    "Label": {
      "zh-cn": "Bucket名称"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete the relative objects in the bucket. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除OSS中的文件"
    }
  }
  EOT
}

variable "logging_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TargetPrefix": {
          "Type": "String",
          "Description": {
            "en": "This element lets you specify a prefix for the objects that the log files will be stored."
          },
          "Required": false
        },
        "TargetBucket": {
          "Type": "String",
          "Description": {
            "en": "Specifies the bucket where you want Aliyun OSS to store server access logs."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Settings that defines where logs are stored."
    },
    "Label": {
      "en": "LoggingConfiguration",
      "zh-cn": "日志存储配置"
    }
  }
  EOT
}

variable "website_configuration_v2" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IndexDocument": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Type": {
                "Type": "String",
                "Description": {
                  "en": "Behavior when an Object that ends with a non-forward slash (/) and does not exist is accessed after setting the default home page. It only takes effect when SupportSubDir is set to true, and it takes effect after RoutingRule and before ErrorFile.\nAssume that the default home page for the index. The HTML, to access the file path for bucket.oss-cn-hangzhou.aliyuncs.com/abc, and ABC this Object does not exist, at this moment, in different values corresponding to the Type of behavior is as follows:\n- 0 (default) : Check if abc/index.html exists (Object + forward slash (/) + home page) and return 302 with the URL code of /abc/ as Location header (forward slash (/) + Object + forward slash (/)). If it doesn't, it will return 404 and keep checking ErrorFile.\n- 1: Directly return 404, error NoSuchKey, continue to check ErrorFile.\n- 2: Check if abc/index.html exists and return the contents of the Object if it does. If it doesn't, it will return 404 and keep checking ErrorFile."
                },
                "AllowedValues": [
                  "0",
                  "1",
                  "2"
                ],
                "Required": false
              },
              "Suffix": {
                "Type": "String",
                "Description": {
                  "en": "Default home page.\nAfter setting the default home page, if you visit an Object ending with a forward slash (/), OSS will return to this default home page."
                },
                "Required": true
              },
              "SupportSubDir": {
                "Type": "String",
                "Description": {
                  "en": "Whether to jump to the default home page of a subdirectory when accessing it. The range is as follows:\n- true: Go to the default home page in a subdirectory.\n- false (default) : Instead of going to the default home page in a subdirectory, go to the default home page in the root directory.\nAssume that the default home page for the index. The HTML, to access bucket.oss-cn-hangzhou.aliyuncs.com/subdir/, if set SupportSubDir to false, Then go to bucket.oss-cn-hangzhou.aliyuncs.com/index.html; If set SupportSubDir is true, then transferred to the bucket.oss-cn-hangzhou.aliyuncs.com/subdir/index.html."
                },
                "AllowedValues": [
                  "true",
                  "false"
                ],
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The properties of default home page."
          },
          "Required": false
        },
        "RoutingRules": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Condition": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "IncludeHeaders": {
                          "AssociationPropertyMetadata": {
                            "Parameters": {
                              "Equals": {
                                "Type": "String",
                                "Description": {
                                  "en": "The value of the header."
                                },
                                "Required": false
                              },
                              "Key": {
                                "Type": "String",
                                "Description": {
                                  "en": "The name of the header."
                                },
                                "Required": true
                              }
                            }
                          },
                          "AssociationProperty": "List[Parameters]",
                          "Type": "Json",
                          "Description": {
                            "en": "This rule will only match if the request contains the specified Header and the value is the specified value. Up to 10."
                          },
                          "Required": false,
                          "MaxLength": 10
                        },
                        "KeyPrefixEquals": {
                          "Type": "String",
                          "Description": {
                            "en": "The prefix of the Object name to be matched."
                          },
                          "Required": false
                        },
                        "HttpErrorCodeReturnedEquals": {
                          "Type": "String",
                          "Description": {
                            "en": "When accessing the specified Object, this status must be returned to match this rule. This field must be 404 when the jump rule is mirror-back to the source type."
                          },
                          "Required": false
                        },
                        "KeySuffixEquals": {
                          "Type": "String",
                          "Description": {
                            "en": "The suffix of the Object name to be matched."
                          },
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "Conditions for matching.\nThis rule is executed if the specified items are all satisfied. A match is only considered if all conditions for each node under this container are met."
                    },
                    "Required": true
                  },
                  "RuleNumber": {
                    "Type": "Number",
                    "Description": {
                      "en": "Match and execute the sequence number of the RoutingRule, OSS will match the rules in turn according to this sequence number. If the match is successful, this rule is executed and no subsequent rules are executed."
                    },
                    "Required": true,
                    "MinValue": 1,
                    "MaxValue": 20
                  },
                  "Redirect": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "MirrorURL": {
                          "Type": "String",
                          "Description": {
                            "en": "Mirror back to the source station address of the source. This only works if RedirectType is set to Mirror.\nThe origin URL must begin with http:// or https:// and end with a forward slash (/), which OSS will follow with the Object name to form the return URL.\nName to access the Object myobject, for example, if you specify this to http://example.com/, then back to the source URL for http://example.com/myobject, if you specify this to http://example.com/dir1/, Back to the source URL as http://example.com/dir1/myobject."
                          },
                          "Required": false
                        },
                        "ReplaceKeyWith": {
                          "Type": "String",
                          "Description": {
                            "en": "With Redirect, the Object name is replaced with the value specified by ReplaceKeyWith, which allows you to set variables. The currently supported variable is $${key}, which represents the name of the Object in the request.\nSuppose to access the Object for the test, if set ReplaceKeyWith to prefix/$${key}. The suffix, is the Location head to http://example.com/prefix/test.suffix."
                          },
                          "Required": false
                        },
                        "MirrorHeaders": {
                          "AssociationPropertyMetadata": {
                            "Parameters": {
                              "PassAll": {
                                "Type": "Boolean",
                                "Description": {
                                  "en": "Whether to pass through other headers to the source except the following headers. This only works if RedirectType is set to Mirror.\n- content-length, authorization2, authorization, range, date and other headers\n- Headers starting with oss-/x-oss-/x-drs-\nDefault value: false"
                                },
                                "Required": false
                              },
                              "Pass": {
                                "AssociationPropertyMetadata": {
                                  "Parameter": {
                                    "Type": "String",
                                    "Description": {
                                      "en": "Specifies the Header that is mirrored back to the source. This only works if RedirectType is set to Mirror.\nEach Header is at most 1,024 bytes long and has the character sets 0-9, a-z, A-Z, and dash (-)."
                                    },
                                    "AllowedPattern": "^[-a-zA-Z0-9]{1,1024}$",
                                    "Required": false
                                  }
                                },
                                "AssociationProperty": "List[Parameter]",
                                "Type": "Json",
                                "Description": {
                                  "en": "Pass through the specified Header to the source. This only works if RedirectType is set to Mirror.\nEach Header is at most 1,024 bytes long and has the character sets 0-9, a-z, A-Z, and dash (-).\nA maximum of 10 can be specified for this field."
                                },
                                "Required": false,
                                "MaxLength": 10
                              },
                              "Sets": {
                                "AssociationPropertyMetadata": {
                                  "Parameters": {
                                    "Value": {
                                      "Type": "String",
                                      "Description": {
                                        "en": "Set the value of the Header to a maximum of 1024 bytes without \\r\\n. This only works if RedirectType is set to Mirror."
                                      },
                                      "Required": true,
                                      "MaxLength": 1024
                                    },
                                    "Key": {
                                      "Type": "String",
                                      "Description": {
                                        "en": "Sets the Header key to a maximum of 1024 bytes in the same character set as Pass. This only works if RedirectType is set to Mirror."
                                      },
                                      "AllowedPattern": "^[-a-zA-Z0-9]{1,1024}$",
                                      "Required": true
                                    }
                                  }
                                },
                                "AssociationProperty": "List[Parameters]",
                                "Type": "Json",
                                "Description": {
                                  "en": "Set a Header to the origin, and it will be set when the request is sent back to the origin, regardless of whether the specified headers are included in the request. This only works if RedirectType is set to Mirror.\nUp to 10 groups can be specified for this container."
                                },
                                "Required": false,
                                "MaxLength": 10
                              },
                              "Remove": {
                                "AssociationPropertyMetadata": {
                                  "Parameter": {
                                    "Type": "String",
                                    "Description": {
                                      "en": "Disables pass-through of the specified Header to the source. This only works if RedirectType is set to Mirror.\nEach Header is at most 1,024 bytes long and has the character sets 0-9, a-z, A-Z, and dash (-)."
                                    },
                                    "AllowedPattern": "^[-a-zA-Z0-9]{1,1024}$",
                                    "Required": false
                                  }
                                },
                                "AssociationProperty": "List[Parameter]",
                                "Type": "Json",
                                "Description": {
                                  "en": "Disables pass-through of the specified Header to the source. This only works if RedirectType is set to Mirror.\nEach Header is at most 1,024 bytes long and has the character sets 0-9, a-z, A-Z, and dash (-).\nA maximum of 10 can be specified for this field."
                                },
                                "Required": false,
                                "MaxLength": 10
                              }
                            }
                          },
                          "Type": "Json",
                          "Description": {
                            "en": "Specifies the Header that is mirrored back to the source. This only works if RedirectType is set to Mirror."
                          },
                          "Required": false
                        },
                        "HttpRedirectCode": {
                          "Type": "String",
                          "Description": {
                            "en": "Status code returned when jumping. Only if RedirectType is set to External or AliCDN.The default value is 302.\nValue: 301, 302, 307"
                          },
                          "AllowedValues": [
                            "301",
                            "302",
                            "307"
                          ],
                          "Required": false
                        },
                        "EnableReplacePrefix": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "If you set this field to true, the prefix of Object is replaced with the value specified by ReplaceKeyPrefixWith. If this field is not specified or is empty, it means that the Object prefix is truncated.\nNotes: This field cannot be set to true when the ReplaceKeyWith field is not null.\nDefault value: false"
                          },
                          "Required": false
                        },
                        "PassQueryString": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "Whether to carry request parameters when performing a jump or mirroring back to the source rule.\nDoes the user request OSS with the request parameters? a=b&c=d, and set PassQueryString to true, if the rule is a 302 jump, then this request parameter is added in the Location header of the jump. For example, Location:example.com?a=b&c=d, the jump type is mirror back to the source, then this request parameter will also be carried in the initiated back to the source request.\nValid values: true, false (default)"
                          },
                          "Required": false
                        },
                        "MirrorFollowRedirect": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "If the result obtained by mirriling back to the source is 3xx, whether to continue to jump to the specified Location to obtain data. This only works if RedirectType is set to Mirror.\nFor example, when we mirror back to the source, the source returns a 302 with Location specified.\n- If set to true, OSS will continue to request the Location.\nIt can jump up to 10 times, and if it jumps more than 10 times, it fails to return the mirror back to the source.\n- If set to false, OSS will return 302 and pass through the Location.\nDefault value: true"
                          },
                          "Required": false
                        },
                        "ReplaceKeyPrefixWith": {
                          "Type": "String",
                          "Description": {
                            "en": "This value will be substituted for the prefix of the Object name in Redirect. If the prefix is empty, the string is inserted before the Object name.\nNotes: Only ReplaceKeyWith or ReplaceKeyPrefixWith nodes are allowed.\nHypothesis to access the Object for ABC/test. TXT, if set KeyPrefixEquals for ABC /, ReplaceKeyPrefixWith for def /, then the Location head to http://example.com/def/test.txt."
                          },
                          "Required": false
                        },
                        "RedirectType": {
                          "Type": "String",
                          "Description": {
                            "en": "Specifies the type of jump. The range is as follows:\n- Mirror: Mirror back to the source.\n- External: External branch, i.e. OSS will return a 3xx request specifying the branch to another address.\n- AliCDN: Aliyun CDN jump, mainly used for the CDN of Aliyun. Unlike External, OSS adds an additional Header. After identifying this Header, Aliyun CDN will actively jump to the specified address and return the obtained data to the user instead of returning the 3xx jump request to the user."
                          },
                          "AllowedValues": [
                            "Mirror",
                            "External",
                            "AliCDN"
                          ],
                          "Required": true
                        },
                        "MirrorPassQueryString": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "Same as PassQueryString, but takes precedence over PassQueryString. This only works if RedirectType is set to Mirror.\nDefault value: false"
                          },
                          "Required": false
                        },
                        "MirrorCheckMd5": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "Whether to check MD5 back to the source body. This only works if RedirectType is set to Mirror.\nWhen MirrorCheckMd5 is set to true, and the response returned by the source contains the Content-Md5 Header, OSS checks whether the pulled data MD5 matches this header, if not, it is not saved on OSS.\nDefault value: false"
                          },
                          "Required": false
                        },
                        "Protocol": {
                          "Type": "String",
                          "Description": {
                            "en": "Protocol when jumping. Only if RedirectType is set to External or AliCDN.\nIf the file you want to access is test, set to go to example.com, and set Protocol to https, the Location header is https://example.com/test.\nValue: http, https"
                          },
                          "AllowedValues": [
                            "http",
                            "https"
                          ],
                          "Required": false
                        },
                        "HostName": {
                          "Type": "String",
                          "Description": {
                            "en": "The domain name of the jump, the domain name should conform to the domain name specification.\nIf the file you want to access is test, the Protocol is set to https, and the Hostname is set to example.com, the Location header is https://example.com/test."
                          },
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "Specifies the action to be performed when this rule is matched."
                    },
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The properties of routing rule."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The list of routing rules, up to 20."
          },
          "Required": false,
          "MaxLength": 20
        },
        "ErrorDocument": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "HttpStatus": {
                "Type": "String",
                "Description": {
                  "en": "The HTTP status code of the error page. Valid values: 200, 404 (default)."
                },
                "AllowedValues": [
                  "200",
                  "404"
                ],
                "Required": false
              },
              "Key": {
                "Type": "String",
                "Description": {
                  "en": "The default error page.\nWhen an error page is specified, if the accessed Object does not exist, this error page is returned."
                },
                "Required": true
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The properties of default error page."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Website configuration."
    },
    "Label": {
      "en": "WebsiteConfigurationV2",
      "zh-cn": "网站配置"
    }
  }
  EOT
}

variable "referer_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RefererList": {
          "Type": "Json",
          "Required": false
        },
        "AllowEmptyReferer": {
          "Type": "Boolean",
          "Required": false
        }
      }
    },
    "Label": {
      "en": "RefererConfiguration",
      "zh-cn": "防盗链配置"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Bucket tags in k-v pairs format.",
      "zh-cn": "存储空间标签。Key-Value形式的键值对。"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "存储空间标签"
    }
  }
  EOT
}

resource "alicloud_oss_bucket" "bucket" {
  policy                      = var.policy
  resource_group_id           = var.resource_group_id
  storage_class               = var.storage_class
  redundancy_type             = var.redundancy_type
  server_side_encryption_rule = var.server_side_encryption_configuration
  acl                         = var.access_control
  bucket                      = var.bucket_name
  force_destroy               = var.deletion_force
  logging                     = var.logging_configuration
  referer_config              = var.referer_configuration
  tags                        = var.tags
}

output "domain_name" {
  // Could not transform ROS Attribute DomainName to Terraform attribute.
  value       = null
  description = "The public DNS name of the specified bucket."
}

output "internal_domain_name" {
  // Could not transform ROS Attribute InternalDomainName to Terraform attribute.
  value       = null
  description = "The internal DNS name of the specified bucket."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "name" {
  value       = alicloud_oss_bucket.bucket.id
  description = "The name of Bucket"
}

