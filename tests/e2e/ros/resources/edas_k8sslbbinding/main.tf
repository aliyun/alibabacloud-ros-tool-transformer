variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "internet",
      "intranet"
    ],
    "Description": {
      "en": "The type of the SLB instance. Valid values: internet and intranet."
    },
    "Label": {
      "en": "Type",
      "zh-cn": "SLB实例网络类型"
    }
  }
  EOT
}

variable "app_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the application."
    },
    "Label": {
      "en": "AppId",
      "zh-cn": "应用ID"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cluster."
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "scheduler" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The scheduling algorithm. Valid values: \nwrr: Backend servers that have higher weights receive more requests than those that have lower weights.\nrr: Requests are distributed to backend servers in sequence.\nDefault value: rr"
    },
    "Label": {
      "en": "Scheduler",
      "zh-cn": "调度算法"
    }
  }
  EOT
}

variable "specification" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the load balancer instance."
    },
    "Label": {
      "en": "Specification",
      "zh-cn": "SLB实例的规格"
    }
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the load balancer instance. If you leave this parameter empty, Enterprise Distributed Application Service (EDAS) automatically purchases an SLB instance."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "SLB实例ID"
    }
  }
  EOT
}

variable "service_port_infos" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TargetPort": {
          "Type": "Number",
          "Description": {
            "en": "The backend port. Valid values: 1 to 65535."
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 65535
        },
        "LoadBalancerProtocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol of load balancer. Valid values: TCP and HTTPS. If the HTTP protocol is used, set this parameter to TCP."
          },
          "AllowedValues": [
            "TCP",
            "HTTPS"
          ],
          "Required": true
        },
        "CertId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the certificate. This parameter is required if the HTTPS protocol is used."
          },
          "Required": false
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The frontend port. Valid values: 1 to 65535. Each port must be unique."
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 65535
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The information about the ports."
    },
    "Label": {
      "en": "ServicePortInfos",
      "zh-cn": "多个端口需求以及非TCP协议需填写的字段"
    },
    "MinLength": 1
  }
  EOT
}

resource "alicloud_edas_k8s_slb_attachment" "k8s_slb_binding" {
  app_id = var.app_id
}

output "load_balancer_name" {
  // Could not transform ROS Attribute LoadBalancerName to Terraform attribute.
  value       = null
  description = "The name of load balancer instance defined in EDAS."
}

output "address" {
  // Could not transform ROS Attribute Address to Terraform attribute.
  value       = null
  description = "The address of load balancer instance."
}

output "app_id" {
  value       = alicloud_edas_k8s_slb_attachment.k8s_slb_binding.app_id
  description = "The ID of the application."
}

output "change_order_id" {
  // Could not transform ROS Attribute ChangeOrderId to Terraform attribute.
  value       = null
  description = "The ID of the change process."
}

output "load_balancer_id" {
  // Could not transform ROS Attribute LoadBalancerId to Terraform attribute.
  value       = null
  description = "The ID of load balancer instance."
}

