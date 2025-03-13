variable "vserver_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of virtual server group."
    },
    "Label": {
      "en": "VServerGroupId",
      "zh-cn": "服务器组ID"
    }
  }
  EOT
}

variable "backend_servers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the backend server. This parameter must be set to a string. Valid values:\necs: ECS instance. This is the default value.\neni: ENI.\neci: ECI."
          },
          "AllowedValues": [
            "ecs",
            "eni"
          ],
          "Required": false,
          "Default": "ecs"
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the backend server. The description must be 1 to 80 characters in length, and can contain letters, digits, hyphens (-), forward slashes (/), periods (.), and underscores (_)."
          },
          "Required": false
        },
        "ServerId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the backend server. You can specify the ID of an Elastic Compute Service (ECS) instance,an elastic network interface (ENI) or elastic container instance (ECI)."
          },
          "Required": true,
          "MinLength": 1
        },
        "ServerIp": {
          "Type": "String",
          "Description": {
            "en": "The IP address of an ECS instance, ENI or ECI"
          },
          "Required": false
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port of backend server. From 1 to 65535."
          },
          "Required": true
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of backend server of load balancer. From 0 to 100, 0 means offline. Default is 100."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 100,
          "Default": 100
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of a combination of ECS Instance-Port-Weight.Same ecs instance with different port is allowed, but same ecs instance with same port isn't."
    },
    "Label": {
      "en": "BackendServers",
      "zh-cn": "服务器列表"
    }
  }
  EOT
}

resource "alicloud_slb_server_group_server_attachment" "backend_server_tovserver_group_addition" {
  server_group_id = var.vserver_group_id
}

output "vserver_group_id" {
  value       = alicloud_slb_server_group_server_attachment.backend_server_tovserver_group_addition.server_group_id
  description = "The ID of virtual server group."
}

