# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2" # Specify your desired AWS region
}

# Define the S3 Bucket resource
resource "aws_s3_bucket" "my_example_bucket" {
  bucket = "krish-abhi-unique-12345" # Replace with a globally unique bucket name

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


