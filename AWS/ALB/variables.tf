variable "region" {
  default = "us-east-1"
}

#maybe use object?
variable "requried_tags" {
  type    = map(string)
  description = "Required tags"
  
}

variable "alb_name"{
    description = "(Optional) The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb."
    default = null
    type = string
}
variable "internal"{
    description = " (Optional) If true, the LB will be internal, defaults to internal."
    default = true
    type = bool
}
variable "load_balancer_type"{
    description = "(Optional) The type of load balancer to create. Possible values are application, gateway, or network. The default value is application."
    default = "application"
    type = string
}
variable "security_groups"{
    description = "(required) A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application."
    default = null
    type = list(string)
}
variable "drop_invalid_header_fields"{
    description = " (Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. Only valid for Load Balancers of type application."
    default = false
    type = bool
}                 
variable "subnets"{
    description = "(Optional) A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource."
    default = null
    type = list(string)
}
variable "idle_timeout"{
    description = "(Optional) The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60."
    default = 60
    type = number
}
variable "enable_deletion_protection"{
    description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
    default = false
    type = bool
}
variable "enable_cross_zone_load_balancing"{
    description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."
    default = false
    type = bool
}
variable "enable_http2"{
    description = "(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true."
    default = true
    type = bool
}
variable "customer_owned_ipv4_pool"{
    description = " (Optional) The ID of the customer owned ipv4 pool to use for this load balancer."
    default = null
    type = string
}
variable "ip_address_type"{
    description = "(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
    default = "ipv4"
    type = string
}
variable "alb_tags"{
    description = "Custom tags"
    type        = map(string)
    default     = {}
}

variable "access_logs_bucket"{
    description = "(Required) The S3 bucket name to store the logs in."
    type = string
}
variable "access_logs_prefix"{
    description = "(Optional) The S3 bucket prefix. Logs are stored in the root if not configured."
    default = null
    type = string
}
variable "access_logs_enabled"{
    description = " (Optional) Boolean to enable / disable access_logs. Defaults to true"
    default = true
    type = bool
}
