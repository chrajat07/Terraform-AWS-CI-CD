output "bucket_name" {
  description = "S3 website bucket name"
  value       = aws_s3_bucket.example.bucket
}

output "website_endpoint" {
  description = "S3 website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}