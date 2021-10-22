# Configure the AWS Provider
 provider "aws" {
    region  = var.region
     default_tags {
   tags = {
    "Name"                  = var.Name
    "Business Unit"         = var.Business_Unit
    "Business Unit Division"= var.Business_Unit_Division
    "Sub-BU Division"       = var.Sub-BU_Division
    "Application"           = var.Application
    "Financial Owner Name"  = var.Financial_Owner_Name
    "Financial Owner E-mail"= var.Financial_Owner_E-mail
    "Technical Team Owner"  = var.Technical_Team_Owner
    "Technical Owner Name"  = var.Technical_Owner_Name
    "Technical Owner E-mail"= var.Technical_Owner_E-mail
    "Service"               = var.Service
    "Category"              = var.Category
    "Stack"                 = var.Stack
   }
 }
}

//Create the bucket 
resource "aws_s3_bucket" "bucket" {
    bucket          = var.bucket_name
    acl             = var.acl
    tags            = var.tags
    force_destroy   = var.force_destroy
    acceleration_status = var.transfer_acceleration_enabled ? "Enabled" : null
    dynamic logging {
        for_each = var.logging_target_bucket == null ? [] : [1]
            content {
                target_bucket = var.logging_target_bucket
                target_prefix = var.logging_target_prefix
            }
    }
    versioning {
        enabled = var.versioning_enabled
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = var.kms_master_key_id
                sse_algorithm = var.sse_algorithm #"AES256"
            }
        }
    }
    dynamic lifecycle_rule {
        for_each = var.lifecycle_rules
        content {
        enabled                                = lifecycle_rule.value.enabled
        prefix                                 = lifecycle_rule.value.prefix
        tags                                   = lifecycle_rule.value.tags
        abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

        dynamic "noncurrent_version_expiration" {
            for_each = lifecycle_rule.value.noncurrent_version_expiration_enabled  ? [1] : []

            content {
            days = lifecycle_rule.value.noncurrent_version_expiration_days
            }
        }

        dynamic "noncurrent_version_transition" {
            for_each = lifecycle_rule.value.glacier_transition_enabled ? [1] : []

            content {
            days          = lifecycle_rule.value.noncurrent_version_glacier_transition_days
            storage_class = "GLACIER"
            }
        }

        dynamic "noncurrent_version_transition" {
            for_each = lifecycle_rule.value.deeparchive_transition_enabled  ? [1] : []

            content {
            days          = lifecycle_rule.value.noncurrent_version_deeparchive_transition_days
            storage_class = "DEEP_ARCHIVE"
            }
        }

        dynamic "transition" {
            for_each = lifecycle_rule.value.glacier_transition_enabled  ? [1] : []

            content {
            days          = lifecycle_rule.value.glacier_transition_days
            storage_class = "GLACIER"
            }
        }

        dynamic "transition" {
            for_each = lifecycle_rule.value.deeparchive_transition_enabled  ? [1] : []

            content {
            days          = lifecycle_rule.value.deeparchive_transition_days
            storage_class = "DEEP_ARCHIVE"
            }
        }



        dynamic "transition" {
            for_each = lifecycle_rule.value.standard_ia_transition_enabled  ? [1] : []

            content {
            days          = lifecycle_rule.value.standard_transition_days
            storage_class = "STANDARD_IA"
            }
        }

        dynamic "expiration" {
            for_each = lifecycle_rule.value.current_object_expiration_enabled  ? [1] : []

            content {
            days = lifecycle_rule.value.expiration_days
            }
        }
    }
  }
}
// make bucket private
resource "aws_s3_bucket_public_access_block" "block_access" {
    bucket                  = aws_s3_bucket.bucket.id
    block_public_acls       = true
    block_public_policy     = true
    restrict_public_buckets = true
    ignore_public_acls      = true
}

// look into combinging with user input policy
// only allow ssl transport
// https://aws.amazon.com/premiumsupport/knowledge-center/s3-bucket-policy-for-config-rule/
resource "aws_s3_bucket_policy" "enforce_ssl" {
  bucket =  aws_s3_bucket.bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id"     : "EnforceSSL",
  "Statement": [
    {
      "Sid": "DenyInsecure",
      "Effect": "Deny",
      "Action": "s3:*",
      "Principal": "*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        },
        "NumericLessThan": {
          "s3:TlsVersion": 1.2
        }
      },
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}
