provider "aws" {
    region  = var.region
    profile = "personal"
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

resource "aws_security_group" "security_group" {
    description = var.description
    name = var.security_group_name
    revoke_rules_on_delete = var.revoke_rules_on_delete
    tags = var.security_group_tags
    vpc_id = var.vpc_id
  
    dynamic egress {
        for_each = var.egress_rules
        content{
            from_port = egress.value.from_port
            to_port = egress.value.to_port
            protocol = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
            description = egress.value.description
            ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
            prefix_list_ids = egress.value.prefix_list_ids
            security_groups = egress.value.security_groups
            self = egress.value.self
        }
    } 
    dynamic ingress{
        for_each = var.ingress_rules
        content{
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
            description = ingress.value.description
            ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
            prefix_list_ids = ingress.value.prefix_list_ids
            security_groups = ingress.value.security_groups
            self = ingress.value.self
        }
    } 
}
