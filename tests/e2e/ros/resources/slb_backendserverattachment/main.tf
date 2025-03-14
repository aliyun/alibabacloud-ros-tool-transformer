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
      "zh-cn": "负载均衡实例的唯一标识ID"
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
          "AssociationPropertyMetadata": {
            "AutoChangeType": false
          },
          "Type": "String",
          "Description": {
            "en": "The backend server type. Valid values:ecs: ECS instance (default)eni: Elastic Network Interface (ENI)"
          },
          "AllowedValues": [
            "ecs",
            "eni",
            "eci"
          ],
          "Required": false,
          "Default": "ecs"
        },
        "ServerId": {
          "Type": "String",
          "Description": {
            "en": "Need one valid instance id. The instance status should running."
          },
          "Required": true,
          "Label": {
            "zh-cn": "后端服务器实例ID"
          }
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "A description of the backend server."
          },
          "Required": false
        },
        "ServerIp": {
          "Type": "String",
          "Description": {
            "en": "The IP of the instance."
          },
          "Required": false
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of backend server of load balancer. From 0 to 100, 0 means offline. Default is 100."
          },
          "Required": true,
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
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of ECS instance, which will attached to load balancer.",
      "zh-cn": "后端服务器（ECS实例）必须在运行中才可以加入负载均衡实例，每次调用最多可添加20个后端服务器。只有性能保障型实例支持添加eni类型的后端服务器。"
    },
    "Label": {
      "en": "BackendServers",
      "zh-cn": "需要添加的后端服务器列表"
    }
  }
  EOT
}

resource "alicloud_slb_attachment" "backend_server" {
  load_balancer_id = var.load_balancer_id
}

output "load_balancer_id" {
  value       = alicloud_slb_attachment.backend_server.id
  description = "The id of load balancer."
}

output "backend_servers" {
  value       = alicloud_slb_attachment.backend_server.backend_servers
  description = "The collection of attached backend server."
}

