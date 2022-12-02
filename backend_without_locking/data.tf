########################################
# Data sources
########################################

# Computed variables
locals {
  ########################################
  ## Terraform State S3 Bucket
  ########################################
  bucket_name = "s3-${lower(var.app_name)}-${var.env}-terraform-backend-${random_integer.digits.result}"
  acl         = "private"
  tags        = merge(
                    var.tags, 
                    tomap({
                        "Name" = local.bucket_name
                    })
                  )
}

# Current account ID
data "aws_caller_identity" "this" {}

# S3 Bucket Policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root",
      ]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root",
      ]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
  }
}