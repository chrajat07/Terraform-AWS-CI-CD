resource "aws_s3_bucket" "example" {
  bucket = "${var.bucket_name}"

  tags = {
    Name        = "My terraform S3 Bucket"
    Environment = "${var.environment}"
  }
}