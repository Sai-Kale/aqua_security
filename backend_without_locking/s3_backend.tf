# used to append random integer to S3 bucket to avoid conflicting bucket name across the globe
resource "random_integer" "digits" {
  min = 1
  max = 100

  keepers = {
    # Generate a new integer each time s3_bucket_name value gets updated
    listener_arn = var.app_name
  }
}

## Creation of S3 bucket and fetching values from data for metadata
## Most values of variables are taken default from vairables.tf

resource "aws_s3_bucket" "b" {
  bucket = local.bucket_name

#  policy   = data.aws_iam_policy_document.bucket_policy.json

  force_destroy = var.force_destroy
}


resource "aws_s3_bucket_acl" "b" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "b" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = var.versioning_enabled
  }
}

resource "aws_s3_bucket_public_access_block" "b" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}