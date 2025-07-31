module "my_s3_bucket" {
  source = "github.com/terraform-aws-modules/s3-bucket?ref=v3.0.0" # Replace with the desired module and version
  # Add module-specific variables here
  bucket_name = "abhikrishthejprannubucket"
  acl         = "private"
  versioning  = {
    enabled = true
  }
}
