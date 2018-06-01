resource "aws_s3_bucket" "my-bucket-1234" {
  bucket = "my-bucket-1234"
  acl    = "private"

  tags {
    Name        = "my-bucket-1234"
  }
}
