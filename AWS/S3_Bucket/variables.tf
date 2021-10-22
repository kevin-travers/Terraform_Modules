variable "bucket_name" {
    description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length."
    type        = string
}

variable "tags" {
  description = "Custom tags"
  type        = map(string)
  default     = {}
}

variable "acl" {
    description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant."
    default = "private"
    type        = string
}

variable "logging_target_bucket" {
    description = "(Required for logging) The name of the bucket that will receive the log objects."
    default = null
    type        = string
}
variable "logging_target_prefix" {
    description = "(Optional) To specify a key prefix for log objects."
    default = null
    type        = string
}



variable "kms_master_key_id" {
    description = "he AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
    default = null
    type        = string
}

variable "sse_algorithm" {
    description = "(required to enable encryption) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
    default = "AES256"
    type        = string
}

variable "versioning_enabled" {
    description = "(Optional) deteremins if versioning is turned on"
    default = false
    type        = bool
}

variable "force_destroy" {
    description = " (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
    default = false
    type        = bool
}

variable "transfer_acceleration_enabled"{
    description = " (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
    default = false
    type = bool
}


variable "lifecycle_rules" {
  type = list(object({
    prefix  = string
    enabled = bool
    tags    = map(string)

    glacier_transition_enabled            = bool
    deeparchive_transition_enabled        = bool
    standard_ia_transition_enabled        = bool
    current_object_expiration_enabled     = bool
    noncurrent_version_expiration_enabled = bool

    abort_incomplete_multipart_upload_days         = number
    noncurrent_version_glacier_transition_days     = number
    noncurrent_version_deeparchive_transition_days = number
    noncurrent_version_expiration_days             = number

    standard_transition_days    = number
    glacier_transition_days     = number
    deeparchive_transition_days = number
    expiration_days             = number
  }))
  default = [{
    enabled = false
    prefix  = ""
    tags    = {}

    glacier_transition_enabled            = false
    deeparchive_transition_enabled        = false
    standard_ia_transition_enabled        = false
    current_object_expiration_enabled     = false
    noncurrent_version_expiration_enabled = false

    abort_incomplete_multipart_upload_days         = 7
    noncurrent_version_glacier_transition_days     = 0
    noncurrent_version_deeparchive_transition_days = 0
    noncurrent_version_expiration_days             = 0

    standard_transition_days    = 0
    glacier_transition_days     = 0
    deeparchive_transition_days = 0
    expiration_days             = 0
  }]
  description = "A list of lifecycle rules"
}


variable "Name" {
  default = "dev"
}
variable "Business_Unit" {
  default = "s3 bucket"
}
variable "Business_Unit_Division" {
  default = "kevin travers"
}
variable "Sub-BU_Division" {
  default = "dev"
}
variable "Application" {
  default = "s3 bucket"
}
variable "Financial_Owner_Name" {
  default = "kevin travers"
}
variable "Financial_Owner_E-mail" {
  default = "kevin travers"
}
variable "Technical_Team_Owner" {
  default = "kevin travers"
}

variable "Technical_Owner_Name" {
  default = "kevin travers"
}
variable "Technical_Owner_E-mail" {
  default = "kevin travers"
}
variable "Service" {
  default = "kevin travers"
}
variable "Category" {
  default = "kevin travers"
}
variable "Stack" {
  default = "kevin travers"
}
variable "region" {
  default = "us-east-1"
}