# Random bucket suffix
resource "random_pet" "rand_pet" {
  length = 2
}

# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "staticsite-s3-${random_pet.rand_pet.id}"

  tags = {
    Name = "staticsite-s3-${random_pet.rand_pet.id}"
    Team = "Devops"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Upload index.html
resource "aws_s3_object" "my_data" {
  bucket       = aws_s3_bucket.my_bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

# Output details
output "s3_details" {
  value = {
    bucket_name  = aws_s3_bucket.my_bucket.bucket
    website_link = aws_s3_bucket_website_configuration.website.website_endpoint
  }
}