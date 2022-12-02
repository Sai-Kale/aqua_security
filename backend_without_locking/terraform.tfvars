########################################
# Environment setting
########################################
region = "ap-northeast-1"
#role_name    = "Admin"
profile_name = "aws_eks"
env = "dev"
#application_name = "terraform-eks-demo-infra"
app_name = "terraform-eks-demo-infra"

########################################
## Terraform State S3 Bucket
########################################
#acl = "private"
force_destroy = false
versioning_enabled = "Enabled"

## s3 bucket public access block ##
block_public_policy = true
block_public_acls = true
ignore_public_acls = true
restrict_public_buckets = true