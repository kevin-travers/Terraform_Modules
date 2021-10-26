output "arn" {
  value = aws_s3_bucket.bucket.arn
  description = "ARN of the security group."
}
output "id" {
  value = aws_s3_bucket.bucket.id
  description = "ID of the security group."
}
output "owner_id" {
  value = aws_s3_bucket.bucket.owner_id
  description = "Owner ID."
}
output "tags_all" {
  value = aws_s3_bucket.bucket.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}