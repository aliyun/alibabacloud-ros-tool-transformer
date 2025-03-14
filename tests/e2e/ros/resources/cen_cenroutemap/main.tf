variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the route map."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "路由策略的描述"
    }
  }
  EOT
}

variable "source_instance_ids_reverse_match" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The IDs of source instances to be advertised do not support match statements. Valid values: \n false (default value): If the source instance ID is in the SourceInstanceIds field, the match is successful. \n true: If the source instance ID is not in the SourceInstanceIds field, the match is successful.",
      "zh-cn": "路由传递源实例ID列表不在SourceInstanceIds中时，是否匹配通过。"
    },
    "Label": {
      "en": "SourceInstanceIdsReverseMatch",
      "zh-cn": "路由传递源实例ID列表不在SourceInstanceIds中时"
    }
  }
  EOT
}

variable "transmit_direction" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The direction in which the route map is applied. Valid values: \n RegionIn: Routes are advertised to CEN gateways. \n For example, routes are advertised from network instances deployed in the current region or other regions to the gateways deployed in the current region. \n RegionOut: Routes are advertised from CEN gateways. \n For example, routes are advertised from gateways deployed in the current region to network instances or gateways deployed in other regions."
    },
    "Label": {
      "en": "TransmitDirection",
      "zh-cn": "路由策略应用的方向"
    }
  }
  EOT
}

variable "match_community_set" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the Communities. Enter each Community in the format of nn:nn. Valid values of nn: 1 to 65535. You can enter at most 32 Communities. Each Community must comply with RFC 1997. RFC 8092 is not supported. \n Note If the configurations of the Communities are incorrect, routes may not be advertised to the on-premises data center."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the Communities. Enter each Community in the format of nn:nn. Valid values of nn: 1 to 65535. You can enter at most 32 Communities. Each Community must comply with RFC 1997. RFC 8092 is not supported. \n Note If the configurations of the Communities are incorrect, routes may not be advertised to the on-premises data center."
    },
    "Label": {
      "en": "MatchCommunitySet",
      "zh-cn": "匹配Community集合"
    }
  }
  EOT
}

variable "cen_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The region where the CEN instance is deployed. You can call the DescribeRegions operation to query region IDs."
    },
    "Label": {
      "en": "CenRegionId",
      "zh-cn": "云企业网所在的地域"
    }
  }
  EOT
}

variable "source_route_table_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match source route table IDs of the routes. You can enter at most 32 route table IDs."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match source route table IDs of the routes. You can enter at most 32 route table IDs."
    },
    "Label": {
      "en": "SourceRouteTableIds",
      "zh-cn": "匹配路由的源路由表ID列表"
    }
  }
  EOT
}

variable "destination_instance_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the destination instance IDs. \n You can enter instance IDs of the following types: VPC, VBR, CCN in mainland China, and SAG. You can enter at most 32 instance IDs. \n Note The destination instance IDs are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to instances in the current region."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the destination instance IDs. \n You can enter instance IDs of the following types: VPC, VBR, CCN in mainland China, and SAG. You can enter at most 32 instance IDs. \n Note The destination instance IDs are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to instances in the current region."
    },
    "Label": {
      "en": "DestinationInstanceIds",
      "zh-cn": "匹配路由的目的实例ID列表"
    }
  }
  EOT
}

variable "destination_instance_ids_reverse_match" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The IDs of destination instances to be advertised do not support match statements. Valid values: \n false(default value): If the ID of the destination instance to be advertised is in the DestinationInstanceIds field, the match is successful. \n true: If the ID of the destination instance to be advertised is not in the DestinationInstanceIds filed, the match is successful.",
      "zh-cn": "路由传递目的实例ID列表不在DestinationInstanceIds中时，是否匹配通过。"
    },
    "Label": {
      "en": "DestinationInstanceIdsReverseMatch",
      "zh-cn": "路由传递目的实例ID列表不在DestinationInstanceIds中时"
    }
  }
  EOT
}

variable "source_instance_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match source instance IDs of the routes. \n You can enter instance IDs of the following types: virtual private cloud (VPC), virtual border router (VBR), Cloud Connect Network (CCN) in mainland China, Smart Access Gateway (SAG). You can enter at most 32 instance IDs."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match source instance IDs of the routes. \n You can enter instance IDs of the following types: virtual private cloud (VPC), virtual border router (VBR), Cloud Connect Network (CCN) in mainland China, Smart Access Gateway (SAG). You can enter at most 32 instance IDs."
    },
    "Label": {
      "en": "SourceInstanceIds",
      "zh-cn": "匹配路由的源实例ID列表"
    }
  }
  EOT
}

variable "destination_route_table_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the IDs of the destination route tables. You can enter at most 32 route table IDs. \n Note The destination route table IDs are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to route tables in the current region."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the IDs of the destination route tables. You can enter at most 32 route table IDs. \n Note The destination route table IDs are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to route tables in the current region."
    },
    "Label": {
      "en": "DestinationRouteTableIds",
      "zh-cn": "匹配路由的目的路由表ID列表"
    }
  }
  EOT
}

variable "destination_cidr_blocks" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the routing prefixes. The CIDR format is used. You can enter at most 32 CIDR blocks."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the routing prefixes. The CIDR format is used. You can enter at most 32 CIDR blocks."
    },
    "Label": {
      "en": "DestinationCidrBlocks",
      "zh-cn": "匹配路由的前缀列表"
    }
  }
  EOT
}

variable "operate_community_set" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Action statements are used to operate the Communities. Valid values: Enter each Community in the format of nn:nn. Valid values of nn: 1 to 65535. You can enter at most 32 Communities. Each Community must comply with RFC 1997. RFC 8092 is not supported. \n Note If the configurations of the Communities are incorrect, routes may not be advertised to the on-premises data center."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Action statements are used to operate the Communities. Valid values: Enter each Community in the format of nn:nn. Valid values of nn: 1 to 65535. You can enter at most 32 Communities. Each Community must comply with RFC 1997. RFC 8092 is not supported. \n Note If the configurations of the Communities are incorrect, routes may not be advertised to the on-premises data center."
    },
    "Label": {
      "en": "OperateCommunitySet",
      "zh-cn": "操作Community的集合"
    }
  }
  EOT
}

variable "destination_child_instance_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the destination instance types. Valid values: \n VPC: VPCs. \n VBR: VBRs. \n CCN: CCN instances in mainland China. \n Note The destination instance types are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to instances in the current region."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the destination instance types. Valid values: \n VPC: VPCs. \n VBR: VBRs. \n CCN: CCN instances in mainland China. \n Note The destination instance types are valid only when the route map is applied to scenarios where routes are advertised from gateways in the current region to instances in the current region."
    },
    "Label": {
      "en": "DestinationChildInstanceTypes",
      "zh-cn": "匹配路由的目的实例类型列表"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the route map. Valid values: 1 to 100 . A lower value indicates a higher priority. \n Note In the same region, for route maps that are applied in the same direction, the priority is unique. When a route map is implemented, the system matches conditions with a route map whose priority number is the smallest. Therefore, make sure that you set priorities for route maps to meet your requirements."
    },
    "Label": {
      "en": "Priority",
      "zh-cn": "路由策略的优先级"
    }
  }
  EOT
}

variable "source_child_instance_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match source instance types of the routes. Valid values: \n VPC: VPCs. \n VBR: VBRs. \n CCN: CCN instances in mainland China."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match source instance types of the routes. Valid values: \n VPC: VPCs. \n VBR: VBRs. \n CCN: CCN instances in mainland China."
    },
    "Label": {
      "en": "SourceChildInstanceTypes",
      "zh-cn": "匹配路由的源实例类型列表"
    }
  }
  EOT
}

variable "as_path_match_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Match statements are used to match the AS paths. Valid values:\n Include: uses fuzzy match. If the AS path in the condition overlaps with the AS path in the route, the match is successful.\n Complete: uses exact match. Only when the AS path in the condition is the same as the AS path in the route, the match is successful."
    },
    "Label": {
      "en": "AsPathMatchMode",
      "zh-cn": "匹配as-path模式"
    }
  }
  EOT
}

variable "cidr_match_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Match statements are used to match the prefixes. Valid values: \n Include: uses fuzzy match. If the routing prefix in the condition contains the routing prefix of the route, the match is successful. \n For example, the 1.1.0.0/16 policy can match the 1.1.1.0/24 route. \n Complete: uses exact match. Only when the routing prefix in the condition is the same as the routing prefix of the route, the match is successful. \n For example, the 1.1.0.0/16 policy can match the 1.1.0.0/16 route."
    },
    "Label": {
      "en": "CidrMatchMode",
      "zh-cn": "匹配前缀模式"
    }
  }
  EOT
}

variable "map_result" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The route map behavior after all conditions are matched. Valid values: \n Permit: allows the routes that are matched. \n Deny: rejects the routes that are matched."
    },
    "Label": {
      "en": "MapResult",
      "zh-cn": "所有匹配条件通过后的策略行为"
    }
  }
  EOT
}

variable "route_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match the route types. Valid values: \n System: system routes that are generated by the system. \n Custom: custom routes that are created by users. \n BGP: Border Gateway Protocol (BGP) routes that are advertised to BGP. \n You can enter multiple types."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match the route types. Valid values: \n System: system routes that are generated by the system. \n Custom: custom routes that are created by users. \n BGP: Border Gateway Protocol (BGP) routes that are advertised to BGP. \n You can enter multiple types."
    },
    "Label": {
      "en": "RouteTypes",
      "zh-cn": "匹配路由的类型列表"
    }
  }
  EOT
}

variable "preference" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Action statements are used to modify route priorities. Valid values: 1 to 100. Default value: 50. A smaller number indicates a higher priority."
    },
    "Label": {
      "en": "Preference",
      "zh-cn": "修改路由的优先级"
    }
  }
  EOT
}

variable "community_operate_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Action statements are used to operate the Communities. Valid values: \n Additive: adds. \n Replace: replaces."
    },
    "Label": {
      "en": "CommunityOperateMode",
      "zh-cn": "操作Community的模式"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Cloud Enterprise Network (CEN) instance."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网的ID"
    }
  }
  EOT
}

variable "next_priority" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the next associated route map. Valid values: 1 to 100. \n If the priority is not set, no next route map is associated with the current route map. \n If the priority is set to 1, the next route map is associated with the current route map. \n If the priority is set and the value is not 1, the priority of the associated route map must be higher than that of the current route map. \n Only when the MapResult parameter is set to Permit, the matched routes continue to match the next associated route maps."
    },
    "Label": {
      "en": "NextPriority",
      "zh-cn": "关联的下一条路由策略的优先级"
    }
  }
  EOT
}

variable "prepend_as_path" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "AS paths are attached when regional gateways receive or advertise routes. \n For route maps that are applied in different directions, the requirements for AS paths to be attached are different: \n For the inbound direction: You must specify the list of source instance IDs and the source region in the condition to be matched. The source region must be the same as the region where the route map is applied. \n For the outbound direction: You must specify the list of destination instance IDs in the condition to be matched."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "AS paths are attached when regional gateways receive or advertise routes. \n For route maps that are applied in different directions, the requirements for AS paths to be attached are different: \n For the inbound direction: You must specify the list of source instance IDs and the source region in the condition to be matched. The source region must be the same as the region where the route map is applied. \n For the outbound direction: You must specify the list of destination instance IDs in the condition to be matched."
    },
    "Label": {
      "en": "PrependAsPath",
      "zh-cn": "地域网关接收或发布路由时追加AS Path"
    }
  }
  EOT
}

variable "community_match_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Match statements are used to match the Communities. Valid values: \n Include: uses fuzzy match. If the Community in the condition overlaps with the Community of the route, the match is successful. \n Complete: uses exact match. Only when the Community in the condition is the same as the Community of the route, the match is successful."
    },
    "Label": {
      "en": "CommunityMatchMode",
      "zh-cn": "匹配Community模式"
    }
  }
  EOT
}

variable "match_asns" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match AS paths of the routes. An AS path is a mandatory attribute, which describes the AS number through which a BGP route passes when the BGP route is advertised. \n Only the AS-SEQUENCE parameter is supported. The AS-SET, AS-CONFED-SEQUENCE, and AS-CONFED-SET parameters are not supported. Specifically, only the AS number list is supported. Sets and sub-lists are not supported."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match AS paths of the routes. An AS path is a mandatory attribute, which describes the AS number through which a BGP route passes when the BGP route is advertised. \n Only the AS-SEQUENCE parameter is supported. The AS-SET, AS-CONFED-SEQUENCE, and AS-CONFED-SET parameters are not supported. Specifically, only the AS number list is supported. Sets and sub-lists are not supported."
    },
    "Label": {
      "en": "MatchAsns",
      "zh-cn": "匹配路由的as-path列表"
    }
  }
  EOT
}

variable "source_region_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Match statements are used to match source region IDs of the routes. You can enter at most 32 region IDs."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Match statements are used to match source region IDs of the routes. You can enter at most 32 region IDs."
    },
    "Label": {
      "en": "SourceRegionIds",
      "zh-cn": "匹配路由的源地域ID列表"
    }
  }
  EOT
}

resource "alicloud_cen_route_map" "cencen_route_map" {
  description                            = var.description
  source_instance_ids_reverse_match      = var.source_instance_ids_reverse_match
  transmit_direction                     = var.transmit_direction
  match_community_set                    = var.match_community_set
  cen_region_id                          = var.cen_region_id
  source_route_table_ids                 = var.source_route_table_ids
  destination_instance_ids               = var.destination_instance_ids
  destination_instance_ids_reverse_match = var.destination_instance_ids_reverse_match
  source_instance_ids                    = var.source_instance_ids
  destination_route_table_ids            = var.destination_route_table_ids
  destination_cidr_blocks                = var.destination_cidr_blocks
  operate_community_set                  = var.operate_community_set
  destination_child_instance_types       = var.destination_child_instance_types
  priority                               = var.priority
  source_child_instance_types            = var.source_child_instance_types
  as_path_match_mode                     = var.as_path_match_mode
  cidr_match_mode                        = var.cidr_match_mode
  map_result                             = var.map_result
  route_types                            = var.route_types
  preference                             = var.preference
  community_operate_mode                 = var.community_operate_mode
  cen_id                                 = var.cen_id
  next_priority                          = var.next_priority
  prepend_as_path                        = var.prepend_as_path
  community_match_mode                   = var.community_match_mode
  match_asns                             = var.match_asns
  source_region_ids                      = var.source_region_ids
}

output "route_map_id" {
  value       = alicloud_cen_route_map.cencen_route_map.id
  description = "The ID of the route map."
}

