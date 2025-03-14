variable "variable_map" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PolardbPerfPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "POLARDB perf policy setting."
          },
          "Required": false
        },
        "WafEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Waf log switch. Default true."
          },
          "Required": false
        },
        "VpcFlowEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Flow log of VPC. Default false."
          },
          "Required": false
        },
        "RdsPerfEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "RDS perf log switch. Default false."
          },
          "Required": false
        },
        "CpsCallbackCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Mobile push collection policy"
          },
          "Required": false
        },
        "RedisAuditTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Redis audit."
          },
          "Required": false
        },
        "RdsPerfTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of rds perf log."
          },
          "Required": false
        },
        "RdsSlowPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Rds slow policy setting."
          },
          "Required": false
        },
        "K8sIngressTtl": {
          "Type": "Number",
          "Description": {
            "en": "K8s Ingress log centralization ttl. Default 180."
          },
          "Required": false
        },
        "OssSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "OSS synchronization to central configuration switch. Default true."
          },
          "Required": false
        },
        "RdsAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Rds audit collection policy"
          },
          "Required": false
        },
        "BastionAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Bastion audit collection policy"
          },
          "Required": false
        },
        "BastionEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Fortress machine operation log switch.Default true."
          },
          "Required": false
        },
        "RedisSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "Redis sync to center switch. Default 180."
          },
          "Required": false
        },
        "RdsEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "RDS audit log switch. Default true."
          },
          "Required": false
        },
        "SasSessionEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud security center network session log switch.Default false."
          },
          "Required": false
        },
        "RdsAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Rds audit policy setting."
          },
          "Required": false
        },
        "DdosCooAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "Ddos log centralization ttl. Default 180."
          },
          "Required": false
        },
        "AlbAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect ALB access log. Default false."
          },
          "Required": false
        },
        "AlbSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "ALB synchronization to central configuration switch. Default true."
          },
          "Required": false
        },
        "BastionTtl": {
          "Type": "Number",
          "Description": {
            "en": "Fort machine centralized ttl. Default 180."
          },
          "Required": false
        },
        "RdsSlowEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "RDS slow log switch. Default false."
          },
          "Required": false
        },
        "SasDnsQueryEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect DNS query logs. Default false."
          },
          "Required": false
        },
        "PolardbErrorTtl": {
          "Type": "Number",
          "Description": {
            "en": "PolarDB error log TTL. Default 180."
          },
          "Required": false
        },
        "WafAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Waf audit collection policy"
          },
          "Required": false
        },
        "K8sAuditTtl": {
          "Type": "Number",
          "Description": {
            "en": "K8s log centralization ttl. Default 180."
          },
          "Required": false
        },
        "PolardbTtl": {
          "Type": "Number",
          "Description": {
            "en": "POLARDB log centralization ttl. Default 180."
          },
          "Required": false
        },
        "DrdsAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "DRDS audit collection policy"
          },
          "Required": false
        },
        "SlbAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "SLB audit collection policy"
          },
          "Required": false
        },
        "AlbAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "ALB access log TTL. Default 180."
          },
          "Required": false
        },
        "SasSnapshotPortEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center Port Snapshot Switch. Default false."
          },
          "Required": false
        },
        "CloudconfigChangeEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "CloudConfig change log switch. Default false."
          },
          "Required": false
        },
        "RdsSlowTtl": {
          "Type": "Number",
          "Description": {
            "en": "Rds slow log centralization ttl. Default 180."
          },
          "Required": false
        },
        "PolardbEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "POLARDB audit log switch. Default true."
          },
          "Required": false
        },
        "SasSnapshotProcessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center process snapshot switch. Default false."
          },
          "Required": false
        },
        "ActiontrailTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of actiontrail."
          },
          "Required": false
        },
        "NasTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Nas."
          },
          "Required": false
        },
        "AppconnectTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Appconnect."
          },
          "Required": false
        },
        "VpcFlowCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "VPC flow log collection policy script. Default empty."
          },
          "Required": false
        },
        "CpsTtl": {
          "Type": "Number",
          "Description": {
            "en": "Mobile push ttl. Default 180."
          },
          "Required": false
        },
        "SlbSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "Slb sync to center switch. Default 180."
          },
          "Required": false
        },
        "CloudfirewallAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Cloud firewall audit collection policy"
          },
          "Required": false
        },
        "DdosCooAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Ddos access log switch. Default false."
          },
          "Required": false
        },
        "K8sIngressTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of k8s Ingress."
          },
          "Required": false
        },
        "DrdsAuditTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of DRDS."
          },
          "Required": false
        },
        "SasSecurityVulEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center Vulnerability Log Switch.Default false."
          },
          "Required": false
        },
        "PolardbSlowPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "POLARDB slow policy setting."
          },
          "Required": false
        },
        "K8sIngressCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "K8s Ingress collection policy"
          },
          "Required": false
        },
        "ApigatewayTtl": {
          "Type": "Number",
          "Description": {
            "en": "API Gateway ttl. Default 180."
          },
          "Required": false
        },
        "CpsEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Mobile push log switch. Default true."
          },
          "Required": false
        },
        "DdosBgpAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Anti-DDoS (Origin) access log switch. Default false."
          },
          "Required": false
        },
        "RdsSlowCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Rds slow collection policy."
          },
          "Required": false
        },
        "ActiontrailOpenapiCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Actiontrail openapi collection policy"
          },
          "Required": false
        },
        "VpcSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "VPC synchronization to central TTL. Default 180."
          },
          "Required": false
        },
        "RdsPerfPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Rds perf policy setting."
          },
          "Required": false
        },
        "CloudfirewallAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Cloud firewall audit policy setting."
          },
          "Required": false
        },
        "IdaasMngTtl": {
          "Type": "Number",
          "Description": {
            "en": "IDaaS management log TTL. Default 180."
          },
          "Required": false
        },
        "OssAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Access log switch of OSS. Default true."
          },
          "Required": false
        },
        "CpsCallbackPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Mobile push policy setting."
          },
          "Required": false
        },
        "SlbAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "Slb centralized ttl. Default 7."
          },
          "Required": false
        },
        "WafAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Waf audit policy setting."
          },
          "Required": false
        },
        "PolardbPerfTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of POLARDB perf log."
          },
          "Required": false
        },
        "SasLocalDnsEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud security center local DNS log switch. Default false."
          },
          "Required": false
        },
        "OssAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "Access log TTL of OSS. Default 180."
          },
          "Required": false
        },
        "SasHttpEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center WEB access log switch. Default false."
          },
          "Required": false
        },
        "OssMeteringPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Oss metering policy setting."
          },
          "Required": false
        },
        "OssMeteringEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "OSS metering log switch.Default true."
          },
          "Required": false
        },
        "DnsIntranetEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect intranet Alibaba Cloud DNS (DNS) logs. Default false."
          },
          "Required": false
        },
        "CloudfirewallEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud firewall log switch. Default true."
          },
          "Required": false
        },
        "CloudfirewallVpcTtl": {
          "Type": "Number",
          "Description": {
            "en": "The retention period of Cloud Firewall VPC firewall traffic logs in the central Logstore. Default 180."
          },
          "Required": false
        },
        "AlbAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "ALB access log collection policy script. Default empty."
          },
          "Required": false
        },
        "DnsSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "The retention period of intranet DNS logs in the central Logstore. Default 180."
          },
          "Required": false
        },
        "SlbAccessTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of SLB."
          },
          "Required": false
        },
        "DdosDipAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Anti-DDoS Premium access log switch. Default false."
          },
          "Required": false
        },
        "DrdsSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "DRDS sync to center ttl. Default 180."
          },
          "Required": false
        },
        "K8sEventPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "K8s event policy setting."
          },
          "Required": false
        },
        "NasTtl": {
          "Type": "Number",
          "Description": {
            "en": "Nas centralized ttl. Default 180."
          },
          "Required": false
        },
        "SasLoginEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud security center login flow log switch. Default false."
          },
          "Required": false
        },
        "WafTtl": {
          "Type": "Number",
          "Description": {
            "en": "Waf centralized ttl. Default true."
          },
          "Required": false
        },
        "NasAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Nas audit policy setting."
          },
          "Required": false
        },
        "RdsTtl": {
          "Type": "Number",
          "Description": {
            "en": "Rds log centralization ttl. Default 180."
          },
          "Required": false
        },
        "K8sIngressEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "K8s Ingress log switch. Default false."
          },
          "Required": false
        },
        "RdsErrorEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect RDS error log. Default false."
          },
          "Required": false
        },
        "CloudfirewallTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Cloud firewall."
          },
          "Required": false
        },
        "K8sEventCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "K8s event collection policy"
          },
          "Required": false
        },
        "ActiontrailEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Notification type. Support Email, SMS, DingTalk. Default true."
          },
          "Required": false
        },
        "DrdsSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "DRDS sync to center switch. Default true."
          },
          "Required": false
        },
        "ApigatewayEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "API Gateway Log Switch. Default true."
          },
          "Required": false
        },
        "SasCrackEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center Brute Force Log Switch. Default false."
          },
          "Required": false
        },
        "CpsTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of mobile push."
          },
          "Required": false
        },
        "RdsErrorTtl": {
          "Type": "Number",
          "Description": {
            "en": "RDS error log TTL. Default 180."
          },
          "Required": false
        },
        "K8sEventEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "K8s event log switch. Default false."
          },
          "Required": false
        },
        "OssSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "OSS synchronization to central TTL. Default 180."
          },
          "Required": false
        },
        "RdsPerfTtl": {
          "Type": "Number",
          "Description": {
            "en": "Rds perf log centralization ttl. Default 180."
          },
          "Required": false
        },
        "SasSnapshotAccountEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center account snapshot switch. Default false."
          },
          "Required": false
        },
        "SlbSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Slb sync to center switch. Default true."
          },
          "Required": false
        },
        "BastionTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Bastion."
          },
          "Required": false
        },
        "OssAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Oss access policy setting."
          },
          "Required": false
        },
        "SasTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Cloud Security Center."
          },
          "Required": false
        },
        "VpcFlowTtl": {
          "Type": "Number",
          "Description": {
            "en": "Regional flow log TTL of VPC. Default 7."
          },
          "Required": false
        },
        "DrdsAuditTtl": {
          "Type": "Number",
          "Description": {
            "en": "DRDS log centralization ttl. Default 7."
          },
          "Required": false
        },
        "IdaasUserTtl": {
          "Type": "Number",
          "Description": {
            "en": "IDaaS user behavior log. Default 180."
          },
          "Required": false
        },
        "PolardbPerfEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "POLARDB perf log switch. Default false."
          },
          "Required": false
        },
        "RedisAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Redis audit collection policy"
          },
          "Required": false
        },
        "IdaasMngEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect IDaaS management log. Default false."
          },
          "Required": false
        },
        "DdosCooAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Ddos audit collection policy"
          },
          "Required": false
        },
        "K8sAuditEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "K8s access log switch. Default false."
          },
          "Required": false
        },
        "OssMeteringTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of oss metering."
          },
          "Required": false
        },
        "CloudconfigChangeTtl ": {
          "Type": "Number",
          "Description": {
            "en": "CloudConfig change log ttl. Default 180."
          },
          "Required": false
        },
        "PolardbPerfTtl": {
          "Type": "Number",
          "Description": {
            "en": "POLARDB perf log centralization ttl. Default 180."
          },
          "Required": false
        },
        "ApigatewayAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Apigateway audit policy setting."
          },
          "Required": false
        },
        "NasEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Nas log switch. Default true."
          },
          "Required": false
        },
        "SasDnsEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center DNS resolution log switch. Default false."
          },
          "Required": false
        },
        "NasAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Nas audit collection policy"
          },
          "Required": false
        },
        "PolardbSlowCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "POLARDB slow collection policy."
          },
          "Required": false
        },
        "AppconnectTtl": {
          "Type": "Number",
          "Description": {
            "en": "Appconnect log centralization ttl. Default 180."
          },
          "Required": false
        },
        "OssMeteringTtl": {
          "Type": "Number",
          "Description": {
            "en": "OSS measurement log TTL. Default 180."
          },
          "Required": false
        },
        "SasSecurityHcEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center Baseline Log Switch. Default false."
          },
          "Required": false
        },
        "K8sAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "K8s audit collection policy"
          },
          "Required": false
        },
        "DnsIntranetCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "DNS intranet log collection policy script. Default empty."
          },
          "Required": false
        },
        "VpcSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "VPC synchronization to central configuration switch. Default true."
          },
          "Required": false
        },
        "DdosCooAccessTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Ddos."
          },
          "Required": false
        },
        "AppconnectOpCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Appconnect audit collection policy"
          },
          "Required": false
        },
        "DdosDipAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "Anti-DDoS Premium access log ttl. Default 180."
          },
          "Required": false
        },
        "CloudfirewallVpcEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect VPC firewall traffic logs from Cloud Firewall. Default false."
          },
          "Required": false
        },
        "AppconnectOpPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Appconnect audit policy setting."
          },
          "Required": false
        },
        "IdaasUserCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "IDaaS user behavior log collection policy script. Default empty."
          },
          "Required": false
        },
        "PolardbErrorEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect PolarDB error log. Default false."
          },
          "Required": false
        },
        "PolardbTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of POLARDB."
          },
          "Required": false
        },
        "RedisAuditTtl": {
          "Type": "Number",
          "Description": {
            "en": "Redis audit log centralization ttl. Default 7."
          },
          "Required": false
        },
        "RdsSlowTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of rds slow log."
          },
          "Required": false
        },
        "AlbSyncTtl": {
          "Type": "Number",
          "Description": {
            "en": "ALB synchronization to central TTL. Default 180."
          },
          "Required": false
        },
        "SasTtl": {
          "Type": "Number",
          "Description": {
            "en": "Cloud Security Center centralized ttl. Default 180."
          },
          "Required": false
        },
        "IdaasMngCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "IDaaS management log collection policy script. Default empty."
          },
          "Required": false
        },
        "ActiontrailTtl": {
          "Type": "Number",
          "Description": {
            "en": "Actiontrail action log TTL."
          },
          "Required": false
        },
        "RdsPerfCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Rds perf collection policy."
          },
          "Required": false
        },
        "DdosBgpAccessTtl": {
          "Type": "Number",
          "Description": {
            "en": "Anti-DDoS (Origin) access log ttl. Default 180."
          },
          "Required": false
        },
        "OssAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Oss access collection policy."
          },
          "Required": false
        },
        "RedisAuditEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Redis audit log switch. Default true."
          },
          "Required": false
        },
        "WafTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Waf."
          },
          "Required": false
        },
        "CloudconfigNoncomTtl ": {
          "Type": "Number",
          "Description": {
            "en": "CloudConfig non-compliance log ttl. Default 180."
          },
          "Required": false
        },
        "RedisSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Redis sync to center switch. Default true."
          },
          "Required": false
        },
        "K8sAuditTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of K8s."
          },
          "Required": false
        },
        "SasProcessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center process startup log switch. Default false."
          },
          "Required": false
        },
        "RedisAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Redis audit policy setting."
          },
          "Required": false
        },
        "AppconnectEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Appconnect access log switch. Default false."
          },
          "Required": false
        },
        "RdsErrorCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "RDS error log collection policy script. Default empty."
          },
          "Required": false
        },
        "DrdsAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "DRDS audit policy setting."
          },
          "Required": false
        },
        "IdaasUserEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to collect IDaaS user behavior log. Default false."
          },
          "Required": false
        },
        "K8sEventTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of k8s event."
          },
          "Required": false
        },
        "PolardbAuditCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "POLARDB audit collection policy"
          },
          "Required": false
        },
        "DdosCooAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Ddos audit policy setting."
          },
          "Required": false
        },
        "K8sEventTtl": {
          "Type": "Number",
          "Description": {
            "en": "K8s event log centralization ttl. Default 180."
          },
          "Required": false
        },
        "PolardbSlowEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "POLARDB slow log switch. Default false."
          },
          "Required": false
        },
        "SasSecurityAlertEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud Security Center Security Alarm Log Switch .Default false."
          },
          "Required": false
        },
        "SlbAccessEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Slb log switch. Default true."
          },
          "Required": false
        },
        "DrdsAuditEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "DRDS audit log switch. Default true."
          },
          "Required": false
        },
        "CloudconfigNoncomEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "CloudConfig non-compliance log switch. Default false."
          },
          "Required": false
        },
        "SasNetworkEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Cloud security center network connection log switch. Default false."
          },
          "Required": false
        },
        "DnsIntranetTtl": {
          "Type": "Number",
          "Description": {
            "en": "The retention period of intranet DNS logs in the regional Logstore. Default 7."
          },
          "Required": false
        },
        "K8sIngressPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "K8s Ingress policy setting."
          },
          "Required": false
        },
        "OssMeteringCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Oss metering collection policy."
          },
          "Required": false
        },
        "PolardbErrorCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "PolarDB error log collection policy script. Default empty."
          },
          "Required": false
        },
        "PolardbSlowTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of POLARDB slow log."
          },
          "Required": false
        },
        "PolardbSlowTtl": {
          "Type": "Number",
          "Description": {
            "en": "POLARDB slow log centralization ttl. Default 180."
          },
          "Required": false
        },
        "OssAccessTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of oss."
          },
          "Required": false
        },
        "PolardbPerfCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "POLARDB perf collection policy."
          },
          "Required": false
        },
        "ActiontrailOpenapiPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Actiontrail openapi policy setting."
          },
          "Required": false
        },
        "ApigatewayTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of Apigateway."
          },
          "Required": false
        },
        "BastionAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "Bastion audit policy setting."
          },
          "Required": false
        },
        "SlbAccessPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "SLB audit policy setting."
          },
          "Required": false
        },
        "RdsTiEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Threat Intelligence of rds."
          },
          "Required": false
        },
        "DnsSyncEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to synchronize DNS intranet logs to the central project. Default true."
          },
          "Required": false
        },
        "ApigatewayAccessCollectionPolicy": {
          "Type": "String",
          "Description": {
            "en": "Apigateway audit collection policy"
          },
          "Required": false
        },
        "CloudfirewallTtl": {
          "Type": "Number",
          "Description": {
            "en": "Cloud firewall log centralized ttl. Default 180."
          },
          "Required": false
        },
        "PolardbAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "POLARDB audit policy setting."
          },
          "Required": false
        },
        "K8sAuditPolicySetting": {
          "Type": "Json",
          "Description": {
            "en": "K8s audit policy setting."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Log audit detailed configuration."
    },
    "Label": {
      "en": "VariableMap",
      "zh-cn": "日志审计服务的详细配置"
    }
  }
  EOT
}

variable "display_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Name of SLS log audit."
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "日志审计服务的名称"
    },
    "MaxLength": 128
  }
  EOT
}

variable "multi_account" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Multi-account configuration, please fill in multiple aliuid."
    },
    "Label": {
      "en": "MultiAccount",
      "zh-cn": "日志审计服务的多账号配置"
    },
    "MinLength": 0,
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_log_audit" "audit" {
  variable_map  = var.variable_map
  display_name  = var.display_name
  multi_account = var.multi_account
}

output "display_name" {
  value       = alicloud_log_audit.audit.id
  description = "Name of SLS log audit."
}

