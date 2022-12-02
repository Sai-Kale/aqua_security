########################################
# Metadata
########################################
variable "env" {
  description = "The name of the environment."
  type = string
}

variable "app_name" {
  description = "The name of the application."
  type = string
}

variable "region" {
  description = "The AWS region this bucket should reside in."
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type = map
  default  = {}
}

variable "profile_name" {
  type = string
}


########################################
## S3
########################################
#variable "acl" {
#  description = "The canned ACL to apply."
#  type = string
#}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type = string
}

variable "versioning_enabled" {
  description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state."
  type = string
}

## s3 bucket public access block ##
variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type = string
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type = string
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type = string
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type = string
}