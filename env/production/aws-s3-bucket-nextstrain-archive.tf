resource "aws_s3_bucket" "nextstrain-archive" {
  bucket        = "nextstrain-archive"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
