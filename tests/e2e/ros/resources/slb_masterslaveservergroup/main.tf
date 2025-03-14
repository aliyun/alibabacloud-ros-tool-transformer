variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Server Load Balancer instance."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "负载均衡实例ID"
    }
  }
  EOT
}

variable "master_slave_server_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the active/standby server group."
    },
    "Label": {
      "en": "MasterSlaveServerGroupName",
      "zh-cn": "主备服务器组名称"
    }
  }
  EOT
}

variable "master_slave_backend_servers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ServerType": {
          "Type": "String",
          "Description": {
            "en": "The identity of backend server. Could be \"Master\" (default) or \"Slave\""
          },
          "AllowedValues": [
            "Master",
            "Slave"
          ],
          "Required": false
        },
        "Type": {
          "Type": "String",
          "Description": {
            "en": "Specify the type of backend server. This parameter must be of the STRING type. Valid values:\necs: an ECS instance\neni: an elastic network interface (ENI)."
          },
          "Required": false
        },
        "ServerId": {
          "Type": "String",
          "Description": {
            "en": "ECS instance ID"
          },
          "Required": true
        },
        "ServerIp": {
          "Type": "String",
          "Description": {
            "en": "The IP of ECS or ENI."
          },
          "Required": false
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port used by backend server. From 1 to 65535"
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 65535
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of backend server of load balancer. From 0 to 100, 0 means offline. Default is 100."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 100
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "A list of active/standby server group.\nAn active/standby server group can only contain two backend servers."
    },
    "Label": {
      "en": "MasterSlaveBackendServers",
      "zh-cn": "主备服务器组列表"
    },
    "MinLength": 2,
    "MaxLength": 2
  }
  EOT
}

resource "alicloud_slb_master_slave_server_group" "master_slave_server_group" {
  load_balancer_id = var.load_balancer_id
  name             = var.master_slave_server_group_name
  servers          = var.master_slave_backend_servers
}

output "master_slave_server_group_id" {
  value       = alicloud_slb_master_slave_server_group.master_slave_server_group.id
  description = "Active/standby server group ID."
}

