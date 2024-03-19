resource "aws_s3_bucket" "www_bucket" {
  bucket = "baluaws1"

#   tags = var.common_tags
}

# resource "aws_s3_bucket_website_configuration" "www_bucket" {
#   bucket = aws_s3_bucket.www_bucket.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }
# }

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.www_bucket.id

  block_public_acls   = false
  block_public_policy = false
}

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.www_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = "*"
#         Action = [
#           "s3:GetObject",
#           "s3:PutBucketPolicy"
#         ]
#         Resource = [
#           "${aws_s3_bucket.www_bucket.arn}/*"
#         ]
#       }
#     ]
#   })
# }
