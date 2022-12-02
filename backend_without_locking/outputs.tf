## S3 ##

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket_policy.b.id, aws_s3_bucket.b.id, "")
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.b.arn, "")
}
