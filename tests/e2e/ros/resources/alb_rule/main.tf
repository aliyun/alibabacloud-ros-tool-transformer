variable "rule_actions" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Order": {
              "Type": "Number",
              "Description": {
                "en": "The priority of the action. Valid values: 1 to 50000. A lower value specifies a higher priority. The actions specified in a forwarding\nrule are applied in descending order of priority. This parameter is required. The\npriority of each action within a forwarding rule is unique."
              },
              "Required": true,
              "MinValue": 1,
              "MaxValue": 50000
            },
            "FixedResponseConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "HttpCode": {
                    "Type": "String",
                    "Description": {
                      "en": "The HTTP status code of the response. Valid values: HTTP_2xx, HTTP_4xx, and HTTP_5xx. x is a digit."
                    },
                    "Required": false
                  },
                  "ContentType": {
                    "Type": "String",
                    "Description": {
                      "en": "The format of the content.\nValid values: text/plain, text/css, text/html, application/javascript, and application/json."
                    },
                    "AllowedValues": [
                      "text/plain",
                      "text/css",
                      "text/html",
                      "application/javascript",
                      "application/json"
                    ],
                    "Required": false
                  },
                  "Content": {
                    "Type": "String",
                    "Description": {
                      "en": "The content of the fixed response. The content cannot exceed 1 KB in size, and can\ncontain only ASCII characters."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the fixed response."
              },
              "Required": false
            },
            "Type": {
              "Type": "String",
              "Description": {
                "en": "The action. Valid values:\nForwardGroup: forwards a request to multiple vServer groups.\nRedirect: redirects a request.\nFixedResponse: returns a fixed response.\nRewrite: rewrites a request.\nInsertHeader: adds a header to a request.\nCors: adds a cors info to a request.\nThe type of the action. You can specify the last action and the actions \nthat you want to perform before the last action: \nFinalType: the last action that you want to perform in a forwarding rule. Each forwarding rule can contain only one FinalType action. \nYou can specify a ForwardGroup, Redirect, or FixedResponse action as the FinalType action.\nExtType: the action or the actions to be performed before the FinalType action. A forwarding rule can contain one or more ExtType actions. \nTo specify this parameter, you must also specify FinalType. You can specify multiple InsertHeader actions or one Rewrite action."
              },
              "AllowedValues": [
                "ForwardGroup",
                "Redirect",
                "FixedResponse",
                "Rewrite",
                "InsertHeader",
                "RemoveHeader",
                "TrafficLimit",
                "TrafficMirror",
                "Cors"
              ],
              "Required": true
            },
            "RedirectConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The path of the URL to which requests are redirected. Valid values:\nDefault value: $${path}. $${host}, $${protocol}, and $${port} are also supported. Each variable can be specified only once. You can specify one\nor more of the preceding variables in each request. You can also combine them with\nthe following characters.\nTo customize the path, make sure that the following requirements are met:\nThe path must be 1 to 128 characters in length.\nIt must start with a forward slash (/). The path can contain letters, digits, and\nthe following special characters: $ - _ .+ / & ~ @ :. It cannot contain the following special characters: \" % # ; ! ( ) [ ]^ , \". It can also contain asterisks (*) and question marks (?) as wildcard characters.\nThe value is case-sensitive."
                    },
                    "Required": false
                  },
                  "HttpCode": {
                    "Type": "Number",
                    "Description": {
                      "en": "The redirect type. Valid values: 301, 302, 303, 307, and 308."
                    },
                    "AllowedValues": [
                      301,
                      302,
                      303,
                      307,
                      308
                    ],
                    "Required": false
                  },
                  "Query": {
                    "Type": "String",
                    "Description": {
                      "en": "The query string of the URL to which requests are redirected.\nDefault value: $${query}. $${host}, $${protocol}, and $${port} are also supported. Each variable can be specified only once. You can specify one\nor more of the preceding variables in each request. You can also combine them with\nthe following characters.\nTo customize the query string, make sure that the following requirements are met:\nThe value must be 1 to 128 characters in length.\nIt can contain printable characters. It cannot contain space characters or the following\nspecial characters: # [ ] { } \\ | < > &. It cannot contain uppercase letters."
                    },
                    "Required": false
                  },
                  "Port": {
                    "Type": "String",
                    "Description": {
                      "en": "The port to which requests are redirected.\n$${port} (default): If you set the value to $${port}, you cannot add other characters to the\nvalue.\nYou can also enter a port number. Valid values: 1 to 63335."
                    },
                    "Required": false
                  },
                  "Host": {
                    "Type": "String",
                    "Description": {
                      "en": "The host name to which requests are redirected. Valid values:\n$${host} (default): If you set the value to $${host}, you cannot add other characters to the\nvalue.\nTo customize the host name, make sure that the following requirements are met:\nThe host name must be 3 to 128 characters in length, and can contain lowercase letters,\ndigits, hyphens (-), periods (.), asterisks (*), and question marks (?).\nThe host name must contain at least one period (.). It cannot start or end with a\nperiod (.).\nThe rightmost field can contain only letters and wildcard characters. It cannot contain\ndigits or hyphens (-).\nThe domain labels cannot start or end with hyphens (-). You can include an asterisk\n(*) and question mark (?) anywhere in a domain label."
                    },
                    "Required": false
                  },
                  "Protocol": {
                    "Type": "String",
                    "Description": {
                      "en": "The redirect protocol.\n$${protocol} (default): If you set the value to $${protocol}, you cannot add other characters to\nthe value.\nYou can also set the value to HTTP or HTTPS.\nNote HTTPS listeners do not support HTTPS to HTTP redirection."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the external redirect action."
              },
              "Required": false
            },
            "CorsConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "AllowCredentials": {
                    "Type": "String",
                    "Description": {
                      "en": "Whether to allow credentials."
                    },
                    "AllowedValues": [
                      "on",
                      "off"
                    ],
                    "Required": false
                  },
                  "ExposeHeaders": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The headers that are exposed."
                        },
                        "Required": true
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The headers that are exposed."
                    },
                    "Required": false
                  },
                  "AllowOrigin": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The origin of the request."
                        },
                        "Required": true
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The origin of the request."
                    },
                    "Required": false
                  },
                  "AllowHeaders": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The headers that are allowed to be forwarded."
                        },
                        "Required": true
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The headers that are allowed to be forwarded."
                    },
                    "Required": false
                  },
                  "MaxAge": {
                    "Type": "Number",
                    "Description": {
                      "en": "The maximum cache time of the preflight request in the browser. Unit: Second"
                    },
                    "Required": false
                  },
                  "AllowMethods": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The HTTP methods that are allowed to be forwarded."
                        },
                        "Required": true
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The HTTP methods that are allowed to be forwarded."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the CORS."
              },
              "Required": false
            },
            "ForwardGroupConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ServerGroupStickySession": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Timeout": {
                          "Type": "Number",
                          "Description": {
                            "en": "The timeout period. Unit: seconds. Default value: 1000."
                          },
                          "Required": false,
                          "MinValue": 1,
                          "MaxValue": 86400,
                          "Default": 1000
                        },
                        "Enabled": {
                          "Type": "Boolean",
                          "Description": {
                            "en": "Specifies whether to enable session persistence. Valid values:\ntrue: enables session persistence.\nfalse (default): disables session persistence."
                          },
                          "Required": false,
                          "Default": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "The list of session persistence of server group."
                    },
                    "Required": false
                  },
                  "ServerGroupTuples": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ServerGroupId": {
                          "Type": "String",
                          "Description": {
                            "en": "The server group to which requests are forwarded."
                          },
                          "Required": false
                        },
                        "Weight": {
                          "Type": "Number",
                          "Description": {
                            "en": "The weight of the server group. A larger value specifies a higher weight. A server group with a higher weight receives more requests. Default value: 100."
                          },
                          "Required": false,
                          "MinValue": 1,
                          "MaxValue": 100
                        }
                      }
                    },
                    "AssociationProperty": "List[Parameters]",
                    "Type": "Json",
                    "Description": {
                      "en": "The list of server groups to which requests are forwarded."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the server group."
              },
              "Required": false
            },
            "RemoveHeaderConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The key of the response header.\nThe key must be 1 to 40 characters in length.\nIt can contain letters, digits, underscores (_), and hyphens (-).\n"
                    },
                    "AllowedPattern": "[-a-zA-Z0-9_]{1,40}",
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the header to be removed."
              },
              "Required": false
            },
            "InsertHeaderConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ValueType": {
                    "Type": "String",
                    "Description": {
                      "en": "The type of the content. Valid values:\nUserDefined: user-defined.\nReferenceHeader: references one of the request headers.\nSystemDefined: system-defined."
                    },
                    "AllowedValues": [
                      "ReferenceHeader",
                      "SystemDefined",
                      "UserDefined"
                    ],
                    "Required": false
                  },
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The content of the header to be inserted.\nIf ValueType is set to SystemDefined, you can set the value to:\nClientSrcPort: the port of the client.\nClientSrcIp: the IP address of the client.\nProtocol: the request protocol (HTTP or HTTPS)\nSLBId: the ID of the ALB instance.\nSLBPort: the listening port of the ALB instance.\nIf ValueType is set to UserDefined, you can customize the content of the header. The content must be 1 to 128 characters in length, and can contain asterisks (*) and question marks (?). \nIt can also contain printable characters from ASCII code 32 to 127 (ch >= 32 && ch < 127). The header content cannot start or end with a space character.\nIf ValueType is set to ReferenceHeader, you can reference one of the request headers. The header content must be 1 to 128 characters \nin length, and can contain lowercase letters, digits, underscores (_), and hyphens (-)."
                    },
                    "Required": false
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The key of the response header.\nThe key must be 1 to 40 characters in length.\nIt can contain letters, digits, underscores (_), and hyphens (-).\nThe header names specified by InsertHeaderConfig must be unique.\nNote You cannot set the name of the header to one of the following values (case-insensitive): \nslb-id, slb-ip, x-forwarded-for, x-forwarded-proto, x-forwarded-eip, x-forwarded-port, x-forwarded-client-srcport, connection, upgrade, content-length, transfer-encoding, keep-alive, te, host, cookie, remoteip, and authority."
                    },
                    "AllowedPattern": "[-a-z0-9_]{1,40}",
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the header to be inserted."
              },
              "Required": false
            },
            "RewriteConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Path": {
                    "Type": "String",
                    "Description": {
                      "en": "The path to jump. Valid values:\nDefault value: $${path}. $${host}, $${protocol}, and $${port} are also supported. Each variable can be specified only once. You can specify one\nor more of the preceding variables in each request. You can also combine them with\nthe following characters.\nTo customize the path, make sure that the following requirements are met:\nThe path must be 1 to 128 characters in length.\nIt must start with a forward slash (/). The path can contain letters, digits, and\nthe following special characters: $ - _ .+ / & ~ @ :. It cannot contain the following special characters: \" % # ; ! ( ) [ ]^ , \". It can also contain asterisks (*) and question marks (?) as wildcard characters.\nThe value is case-sensitive."
                    },
                    "Required": false
                  },
                  "Query": {
                    "Type": "String",
                    "Description": {
                      "en": "Query string for internal jump.\nDefault value: $${query}. $${host}, $${protocol}, and $${port} are also supported. Each variable can be specified only once. You can specify one\nor more of the preceding variables in each request. You can also combine them with\nthe following characters.\nTo customize the query string, make sure that the following requirements are met:\nThe value must be 1 to 128 characters in length.\nIt can contain printable characters. It cannot contain space characters or the following\nspecial characters: # [ ] { } \\ | < > &. It cannot contain uppercase letters."
                    },
                    "Required": false
                  },
                  "Host": {
                    "Type": "String",
                    "Description": {
                      "en": "Destination host address of internal jump. Valid values:\n$${host} (default): If you set the value to $${host}, you cannot add other characters to the\nvalue.\nTo customize the host name, make sure that the following requirements are met:\nThe host name must be 3 to 128 characters in length, and can contain lowercase letters,\ndigits, hyphens (-), periods (.), asterisks (*), and question marks (?).\nThe host name must contain at least one period (.). It cannot start or end with a\nperiod (.).\nThe rightmost field can contain only letters and wildcard characters. It cannot contain\ndigits or hyphens (-).\nThe domain labels cannot start or end with hyphens (-). You can include an asterisk\n(*) and question mark (?) anywhere in a domain label."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the internal redirect action."
              },
              "Required": false
            },
            "TrafficLimitConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "PerIpQps": {
                    "Type": "Number",
                    "Description": {
                      "en": "QPS per IP address. \nNote If both QPS and PerIpQps are set, make sure that the PerIpQps is smaller than the QPS."
                    },
                    "Required": false,
                    "MinValue": 1,
                    "MaxValue": 100000
                  },
                  "QPS": {
                    "Type": "Number",
                    "Description": {
                      "en": "Queries per second (QPS)."
                    },
                    "Required": true,
                    "MinValue": 1,
                    "MaxValue": 100000
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the traffic limit."
              },
              "Required": false
            },
            "TrafficMirrorConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "MirrorGroupConfig": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ServerGroupTuples": {
                          "AssociationPropertyMetadata": {
                            "Parameters": {
                              "ServerGroupId": {
                                "Type": "String",
                                "Description": {
                                  "en": "The ID of server group."
                                },
                                "Required": true
                              }
                            }
                          },
                          "AssociationProperty": "List[Parameters]",
                          "Type": "Json",
                          "Required": true
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "Traffic mirroring to server groups."
                    },
                    "Required": true
                  },
                  "TargetType": {
                    "Type": "String",
                    "Description": {
                      "en": "The type of destination to which network traffic is mirrored. Valid values:\nForwardGroupMirror: a server group\nSlsMirror: Log Service"
                    },
                    "Required": true
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the traffic mirror."
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "The action of the forwarding rule"
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The actions of the forwarding rule."
    },
    "Label": {
      "en": "RuleActions",
      "zh-cn": "转发规则的动作列表"
    },
    "MaxLength": 5
  }
  EOT
}

variable "priority" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the forwarding rule. Valid values: 1 to 10000. A lower value specifies a higher priority.\nNote The priority of each forwarding rule within a listener must be unique."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "转发规则的优先级"
    },
    "MaxValue": 10000
  }
  EOT
}

variable "rule_conditions" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "MethodConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The request method. Valid values: HEAD, GET, POST, OPTIONS, PUT, PATCH, and DELETE."
                        },
                        "AllowedValues": [
                          "HEAD",
                          "GET",
                          "POST",
                          "OPTIONS",
                          "PUT",
                          "PATCH",
                          "DELETE"
                        ],
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The request method. "
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the request method."
              },
              "Required": false
            },
            "PathConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The path of the URL.The path must be 1 to 128 characters in length.\nIt must start with a forward slash (/). The path can contain letters, digits, and the following special characters: $ - _ .+ / & ~ @ :. It cannot contain the following special characters: \" % # ; ! ( ) [ ]^ , \". It can also contain asterisks (*) and question marks (?).\nThe value is case-sensitive."
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The path of the URL."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the URL."
              },
              "Required": false
            },
            "Type": {
              "Type": "String",
              "Description": {
                "en": "The type of the forwarding rule. Valid values:\nHost: Requests are forwarded based on hosts.\nPath: Requests are forwarded based on paths.\nHeader: Requests are forwarded based on HTTP headers.\nQueryString: Requests are forwarded based on query strings.\nMethod: Request are forwarded based on request methods.\nCookie: Request are forwarded based on cookies.\nResponseHeader: Request are forwarded based on response header.\nResponseStatusCode: Request are forwarded based on response status code."
              },
              "AllowedValues": [
                "Cookie",
                "Header",
                "Host",
                "Method",
                "Path",
                "QueryString",
                "SourceIp",
                "ResponseHeader",
                "ResponseStatusCode"
              ],
              "Required": true
            },
            "ResponseHeaderConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Response header value"
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The list of response headers."
                    },
                    "Required": false,
                    "MaxLength": 20
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The key of the response header."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the response header."
              },
              "Required": false
            },
            "QueryStringConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Value": {
                          "Type": "String",
                          "Description": {
                            "en": "The value of the cookie.\nThe key must be 1 to 128 characters in length.\nIt can contain lowercase letters, asterisks (*), question marks (?), and other printable characters. It cannot contain uppercase letters, space characters, or the following special characters: # [ ] { } \\ | < > &."
                          },
                          "Required": false
                        },
                        "Key": {
                          "Type": "String",
                          "Description": {
                            "en": "They key of the query string.\nThe key must be 1 to 100 characters in length\nIt can contain asterisks (*), question marks (?), and other printable characters. It cannot contain uppercase letters.\nThe key cannot contain space characters or the following special characters: ; # [ ] { } \\ | < > &."
                          },
                          "Required": false
                        }
                      }
                    },
                    "AssociationProperty": "List[Parameters]",
                    "Type": "Json",
                    "Description": {
                      "en": "The list of query strings."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the query string."
              },
              "Required": false
            },
            "HostConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The host name"
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The host name. A forwarding rule can contain only one host name. The host names must be unique.\nThe host name must be 3 to 128 characters in length, and can contain lowercase letters, digits, hyphens (-), periods (.), asterisks (*), and question marks (?).\nThe host name must contain at least one period (.). It cannot start or end with a period (.).\nThe rightmost field can contain only letters and wildcard characters. It cannot contain digits or hyphens (-).\nThe domain labels cannot start or end with hyphens (-). You can include an asterisk (*) and question mark (?) anywhere in a domain label."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the host."
              },
              "Required": false
            },
            "CookieConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Value": {
                          "Type": "String",
                          "Description": {
                            "en": "The value of the cookie.\nThe key must be 1 to 100 characters in length.\nIt can contain asterisks (*), question marks (?), and other printable characters. It cannot contain uppercase letters.\nIt cannot contain space characters or the following special characters: ; # [ ] { } \\ | < > &."
                          },
                          "Required": false
                        },
                        "Key": {
                          "Type": "String",
                          "Description": {
                            "en": "The key of the cookie.\nThe key must be 1 to 100 characters in length\nIt can contain asterisks (*), question marks (?), and other printable characters. It cannot contain uppercase letters.\nIt cannot contain space characters or the following special characters: ; # [ ] { } \\ | < > &."
                          },
                          "Required": false
                        }
                      }
                    },
                    "AssociationProperty": "List[Parameters]",
                    "Type": "Json",
                    "Description": {
                      "en": "Cookie values"
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the cookie."
              },
              "Required": false
            },
            "ResponseStatusCodeConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Response status code value"
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The list of response status code."
                    },
                    "Required": false,
                    "MaxLength": 5
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the response status code."
              },
              "Required": false
            },
            "HeaderConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "The value of the header. The header values within a forwarding rule must be unique.\nThe value must be 1 to 128 characters in length.\nIt can contain asterisks (*), question marks (?), and other printable characters from ASCII code 32 to 127 (ch >= 32 && ch < 127).\nThe value cannot start or end with a space character."
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The values of the header. The header values within a forwarding rule must be unique.\nThe value must be 1 to 128 characters in length.\nIt can contain asterisks (*), question marks (?), and other printable characters from ASCII code 32 to 127 (ch >= 32 && ch < 127).\nThe value cannot start or end with a space character."
                    },
                    "Required": false
                  },
                  "Key": {
                    "Type": "String",
                    "Description": {
                      "en": "The key of the header.\nThe key must be 1 to 40 characters in length\nIt can contain letters, digits, hyphens (-), and underscores (_).\nCookie or Host is not supported."
                    },
                    "AllowedPattern": "[-a-z0-9_]{1,40}",
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configuration of the header."
              },
              "Required": false
            },
            "SourceIpConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Values": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "The IP addresses or CIDR blocks.\nYou can specify at most five values for SourceIp."
                    },
                    "Required": false,
                    "MaxLength": 5
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Service traffic matching based on source IP. Required and valid when Type is SourceIP."
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "The condition of the forwarding rule."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The conditions of the forwarding rule."
    },
    "Label": {
      "en": "RuleConditions",
      "zh-cn": "转发规则的条件列表"
    },
    "MaxLength": 10
  }
  EOT
}

variable "direction" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule direction. Valid values: Request or Response."
    },
    "AllowedValues": [
      "Request",
      "Response"
    ],
    "Label": {
      "en": "Direction",
      "zh-cn": "转发规则的方向"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the forwarding rule.\nThe name must be 2 to 128 characters in length.\nIt can contain letters, digits, periods (.), underscores (_), and hyphens (-). It\nmust start with a letter."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "转发规则的名称"
    }
  }
  EOT
}

variable "listener_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the listener that is configured for the Application Load Balancer (ALB)\ninstance."
    },
    "Label": {
      "en": "ListenerId",
      "zh-cn": "负载均衡实例监听ID"
    }
  }
  EOT
}

resource "alicloud_alb_rule" "rule" {
  rule_actions    = var.rule_actions
  priority        = var.priority
  rule_conditions = var.rule_conditions
  direction       = var.direction
  rule_name       = var.rule_name
  listener_id     = var.listener_id
}

output "rule_id" {
  value       = alicloud_alb_rule.rule.id
  description = "The ID of the forwarding rules."
}

output "listener_id" {
  // Could not transform ROS Attribute ListenerId to Terraform attribute.
  value       = null
  description = "The ID of the listener."
}

