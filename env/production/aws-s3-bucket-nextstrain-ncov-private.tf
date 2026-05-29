import {
  to = aws_s3_bucket.nextstrain-ncov-private
  id = "nextstrain-ncov-private"
}

resource "aws_s3_bucket" "nextstrain-ncov-private" {
  bucket        = "nextstrain-ncov-private"
  force_destroy = null
}

import {
  to = aws_s3_bucket_versioning.nextstrain-ncov-private
  id = "nextstrain-ncov-private"
}

resource "aws_s3_bucket_versioning" "nextstrain-ncov-private" {
  bucket = aws_s3_bucket.nextstrain-ncov-private.id

  versioning_configuration {
    status = "Enabled"
  }
}

import {
  to = aws_s3_bucket_server_side_encryption_configuration.nextstrain-ncov-private
  id = "nextstrain-ncov-private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nextstrain-ncov-private" {
  bucket = aws_s3_bucket.nextstrain-ncov-private.id

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

import {
  to = aws_s3_bucket_lifecycle_configuration.nextstrain-ncov-private
  id = "nextstrain-ncov-private"
}

resource "aws_s3_bucket_lifecycle_configuration" "nextstrain-ncov-private" {
  depends_on = [aws_s3_bucket_versioning.nextstrain-ncov-private]

  bucket                                 = aws_s3_bucket.nextstrain-ncov-private.id
  transition_default_minimum_object_size = "varies_by_storage_class"

  rule {
    id = "Cleanup dev files under branch/"

    filter {
      prefix = "branch/"
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    expiration {
      days = 15
    }

    noncurrent_version_expiration {
      noncurrent_days = 15
    }

    status = "Enabled"
  }
}
