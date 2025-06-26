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

resource "aws_s3_bucket_lifecycle_configuration" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  rule {
    id = "all-intelligent-tiering"

    # we want everything in this bucket to go into the intelligent
    # tiering storage class
    filter {}

    transition {
      days          = 0
      storage_class = "INTELLIGENT_TIERING"
    }

    status = "Enabled"
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
