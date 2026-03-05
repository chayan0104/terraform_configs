resource "random_id" "rand_id" {
  byte_length = 3
}

/*
locals {
  bucket_time = formatdate("DDMMMYYYY-hhmm", timestamp())
}
*/

resource "aws_s3_bucket" "my_bucket" {
  //bucket name with random hexa number
  bucket = "bucket-terra-demo-${random_id.rand_id.hex}"
  //bucket name with timestamp
  //bucket = "my-bucket-${lower(local.bucket_time)}"
  tags = {
    Name        = "S3 Bucket"
    Environment = "Devops"
  }
   versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_details" {
  value = {
    id  = aws_s3_bucket.my_bucket.id
    arn = aws_s3_bucket.my_bucket.arn
    rand_id = random_id.rand_id.hex
    link = "https://s3.console.aws.amazon.com/s3/buckets/${aws_s3_bucket.my_bucket.id}"
  }
}

// Upload file to bucket
resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.my_bucket.bucket
  source = "./demofile.txt"
  key    = "mydata.txt"
}
