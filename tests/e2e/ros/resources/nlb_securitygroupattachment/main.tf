variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NLB::LoadBalancer::LoadBalancerId",
    "Description": {
      "en": "The ID of the network-based server load balancer instance to be bound to the security group."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "待绑定安全组的网络型负载均衡实例ID"
    }
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true
    },
    "Description": {
      "en": "List of security group id."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "安全组ID"
    },
    "MaxLength": 10
  }
  EOT
}

resource "alicloud_nlb_load_balancer_security_group_attachment" "security_group_attachment" {
  load_balancer_id = var.load_balancer_id
}

