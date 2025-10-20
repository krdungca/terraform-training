#random place holder for s3 bucket suffix
resource "random_id" "bucket_suffix_placeholder" {
  byte_length = 6
}

resource "random_id" "bucket_suffix_placeholder_2" {
  byte_length = 6
}

#create the s3bucket , name is extracted from random resource as variable
resource "aws_s3_bucket" "self_bucket" {
  #bucket = "default-bucket-ap-southeast-1-${random_id.bucket_suffix_placeholder.hex}"  #default-bucketname
  #bucket = "dev-bucket-ap-southeast-1-${random_id.bucket_suffix_placeholder.hex}"
  bucket = "staging-bucket-ap-southeast-1-${random_id.bucket_suffix_placeholder.hex}"
  provider = aws.ap-southeast-1
}

resource "aws_s3_bucket" "self_bucket_2" {
  #bucket = "default-bucket-us-east-1-${random_id.bucket_suffix_placeholder_2.hex}" #default-bucketname
  #bucket = "dev-bucket-us-east-1-${random_id.bucket_suffix_placeholder_2.hex}"
  bucket = "staging-bucket-us-east-1-${random_id.bucket_suffix_placeholder_2.hex}"
  provider = aws.us-east-1
}
#output the name

output "bucket_names" {
  value = [aws_s3_bucket.self_bucket.bucket, aws_s3_bucket.self_bucket_2.bucket]
}