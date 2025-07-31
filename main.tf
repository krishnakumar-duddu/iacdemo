# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

# Define the S3 Bucket resource
resource "aws_s3_bucket" "my_example_bucket" {
  bucket = "my-unique-s3-bucket-name-12345" # Replace with a globally unique bucket name

  tags = {
    Environment = "Development"
    Project     = "Terraform-S3-Demo"
  }
}

# Optional: Enable bucket versioning
resource "aws_s3_bucket_versioning" "my_example_bucket_versioning" {
  bucket = aws_s3_bucket.my_example_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Add a bucket policy for public read access (use with caution)
resource "aws_s3_bucket_policy" "my_example_bucket_policy" {
  bucket = aws_s3_bucket.my_example_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = ["${aws_s3_bucket.my_example_bucket.arn}/*"]
      }
    ]
  })
}
