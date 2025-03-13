variable "instances" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "InstanceName": {
          "Type": "String",
          "Description": {
            "en": "The name of the instance."
          },
          "Required": true
        },
        "Category": {
          "Type": "String",
          "Description": {
            "en": "The abbreviation of the service name. Valid values:\nECS (including Alibaba Cloud and non-Alibaba Cloud hosts)\nRDS (ApsaraDB for RDS)\nADS (AnalyticDB)\nSLB (Server Load Balancer)\nVPC (Virtual Private Cloud)\nAPIGATEWAY (API Gateway)\nCDN\nCS (Container Service for Swarm)\nDCDN (Dynamic Route for CDN )\nDDoS (distributed denial of service)\nEIP (Elastic IP)\nELASTICSEARCH (Elasticsearch)\nEMR (E-MapReduce)\nESS (Auto Scaling)\nHBASE (ApsaraDB for HBase)\nIOT_EDGE (IoT Edge)\nK8S_POD (k8s pod )\nKVSTORE_SHARDING (ApsaraDB for Redis cluster version)\nKVSTORE_SPLITRW (ApsaraDB for Redis read/write splitting version)\nKVSTORE_STANDARD (ApsaraDB for Redis standard version)\nMEMCACHE (ApsaraDB for Memcache)\nMNS (Message Service)\nMONGODB (ApsaraDB for MongoDB replica set instances)\nMONGODB_CLUSTER (ApsaraDB for MongoDB cluster version)\nMONGODB_SHARDING (ApsaraDB for MongoDB sharded clusters)\nMQ_TOPIC (Message Service topic)\nOCS (old version ApsaraDB for Memcache)\nOPENSEARCH (Open Search)\nOSS (Object Storage Service)\nPOLARDB (ApsaraDB for POLARDB)\nPETADATA (HybridDB for MySQL)\nSCDN (Secure Content Delivery Network)\nSHAREBANDWIDTHPACKAGES (shared bandwidth package)\nSLS (Log Service)\nVPN (VPN Gateway )"
          },
          "Required": true
        },
        "InstanceId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the resource instance."
          },
          "Required": true
        },
        "RegionId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the region where the instance is deployed, such as cn-hangzhou."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Instances",
      "zh-cn": "资源实例"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the application group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "应用分组ID"
    }
  }
  EOT
}

resource "alicloud_cms_monitor_group_instances" "monitor_group_instances" {
  instances = var.instances
  group_id  = var.group_id
}

output "group_id" {
  value       = alicloud_cms_monitor_group_instances.monitor_group_instances.id
  description = "The ID of the application group."
}

