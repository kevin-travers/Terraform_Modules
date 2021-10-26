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

resource "aws_security_group" "security_group" {
    description = var.description
    name = var.security_group
    revoke_rules_on_delete = var.revoke_rules_on_delete
    tags = var.security_group_tags
    vpc_id = var.vpc_id
    lifecycle {
        create_before_destroy = var.create_before_destroy
    }
    dynamic egress {
        for_each = var.egress_rule
        content{

        }
    }
    dynamic ingress{
        for_each = var.ingress_rule
        content{
            from_port = each.value.from_port
            to_port = each.value.to_port
            protocol = each.value.protocol
            cidr_blocks = each.value.cidr_blocks
            description = each.value.description
            ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
            prefix_list_ids = each.value.prefix_list_ids
            security_groups = each.value.security_groups
            self = each.value.self
        }
    } 
}
