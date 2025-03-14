variable "preference_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ParameterValue": {
          "Type": "String",
          "Required": true
        },
        "ParameterKey": {
          "Type": "String",
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]"
  }
  EOT
}

variable "description" {
  type = string
}

variable "source_resource_group" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceTypeFilter": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "ResourceGroupId": {
          "Type": "String",
          "Required": false
        }
      }
    }
  }
  EOT
}

variable "source_tag" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceTypeFilter": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "ResourceTags": {
          "Type": "Json",
          "Required": true
        }
      }
    }
  }
  EOT
}

variable "template_scratch_type" {
  type     = string
  nullable = false
}

variable "logical_id_strategy" {
  type = string
}

variable "source_resources" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceId": {
          "Type": "String",
          "Required": true
        },
        "ResourceType": {
          "Type": "String",
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]"
  }
  EOT
}

resource "alicloud_ros_template_scratch" "extension_resource" {
  preference_parameters = var.preference_parameters
  description           = var.description
  template_scratch_type = var.template_scratch_type
  logical_id_strategy   = var.logical_id_strategy
  source_resources      = var.source_resources
}

output "template_scratch_id" {
  value = alicloud_ros_template_scratch.extension_resource.id
}

