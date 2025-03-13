variable "vserver_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the VServerGroup."
    },
    "Label": {
      "en": "VServerGroupName",
      "zh-cn": "服务器组名称"
    }
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::SLB::LoadBalancer::LoadBalancerId",
    "Description": {
      "en": "The id of load balancer."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "负载均衡实例ID"
    }
  }
  EOT
}

variable "backend_servers" {
  type        = any
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
      },
      "ListMetadata": {
        "Order": [
          "Type",
          "ServerId",
          "Weight",
          "ServerIp",
          "Port",
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of a combination of ECS Instance-Port-Weight.Same ecs instance with different port is allowed, but same ecs instance with same port isn't."
    },
    "Label": {
      "en": "BackendServers",
      "zh-cn": "后端服务器列表"
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
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_slb_server_group" "vserver_group" {
  name             = var.vserver_group_name
  load_balancer_id = var.load_balancer_id
  servers          = var.backend_servers
  tags             = var.tags
}

output "vserver_group_id" {
  value       = alicloud_slb_server_group.vserver_group.id
  description = "The id of VServerGroup created."
}

output "load_balancer_id" {
  value       = alicloud_slb_server_group.vserver_group.load_balancer_id
  description = "The id of load balancer."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "backend_servers" {
  // Could not transform ROS Attribute BackendServers to Terraform attribute.
  value       = null
  description = "Backend server list in this VServerGroup."
}

