variable "description"{
    description = "(Optional, Forces new resource) Security group description. Defaults to Managed by Terraform. Cannot be \"\". NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags."
    default = ""
    type = string
}
variable "egress"{
    description = "Optional, VPC only) Configuration block for egress rules. Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
    type = list(object({
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
            description = string
            ipv6_cidr_blocks = list(string)
            prefix_list_ids = list(string)
            security_groups = list(string)
            self = bool
    }))
    default     = []
}
variable "ingress"{
    description = "(Optional) Configuration block for ingress rules. Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
    type = list(object({
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
            description = string
            ipv6_cidr_blocks = list(string)
            prefix_list_ids = list(string)
            security_groups = list(string)
            self = bool
    }))
    default     = []
}

variable "security_group_name"{
    description = "Optional, Forces new resource) Name of the security group. If omitted, Terraform will assign a random, unique name."
    type =  string
    default = ""
}
variable "revoke_rules_on_delete"{
    description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false."
    type = bool
    default = false
}
variable "security_group_tags"{
    description = "(Optional) Map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
    type        = map(string)
    default     = {}
}
variable "vpc_id"{
    description = "(Optional, Forces new resource) VPC ID."
    type        = string
}

variable "region" {
    description = "region resouce deployed in"
    default = "us-east-1"
}

#maybe use object?
variable "requried_tags" {
    type    = map(string)
    description = "Required tags"
  
}

variable "create_before_destroy" {
    type = bool
    default = false
    description = "if being replaced by terraform cretae replace first before deleteing if set to true"
}