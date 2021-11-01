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
  name               = var.alb_name
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
  tags               = var.tags
  access_logs {
    bucket  = var.bucket
    prefix  = var.prefix
    enabled = var.access_logs_enabled
  }