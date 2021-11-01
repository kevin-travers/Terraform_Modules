# Configure the AWS Provider
 provider "aws" {
    region  = var.region
     default_tags {
   tags = {
    "Name"                  = var.requried_tags.Name
    "Business Unit"         = var.requried_tags.Business_Unit
    "Business Unit Division"= var.requried_tags.Business_Unit_Division
    "Sub-BU Division"       = var.requried_tags.Sub-BU_Division
    "Application"           = var.requried_tags.Application
    "Financial Owner Name"  = var.requried_tags.Financial_Owner_Name
    "Financial Owner E-mail"= var.requried_tags.Financial_Owner_E-mail
    "Technical Team Owner"  = var.requried_tags.Technical_Team_Owner
    "Technical Owner Name"  = var.requried_tags.Technical_Owner_Name
    "Technical Owner E-mail"= var.requried_tags.Technical_Owner_E-mail
    "Service"               = var.requried_tags.Service
    "Category"              = var.requried_tags.Category
    "Stack"                 = var.requried_tags.Stack
   }
 }
}

resource "aws_alb" "alb"{
    name                                = var.alb_name
    internal                            = var.internal
    load_balancer_type                  = var.load_balancer_type
    security_groups                     = var.security_groups
    drop_invalid_header_fields          = var.drop_invalid_header_fields                   
    subnets                             = var.subnets
    idle_timeout                        = var.idle_timeout
    enable_deletion_protection          = var.enable_deletion_protection
    enable_cross_zone_load_balancing    = var.enable_cross_zone_load_balancing
    enable_http2                        = var.enable_http2
    customer_owned_ipv4_pool            = var.customer_owned_ipv4_pool
    ip_address_type                     = var.ip_address_type
    tags                                = var.alb_tags

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }

}
