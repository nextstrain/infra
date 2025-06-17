resource "aws_s3_bucket" "nextstrain-archive" {
  bucket        = "nextstrain-archive"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  versioning_configuration {
    # extra protection, as we probably don't ever want to delete
    # something we've archived…
    mfa_delete = "Enabled"
    status     = "Disabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "nextstrain-archive" {
  bucket = aws_s3_bucket.nextstrain-archive.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "nextstrain-archive" {
  depends_on = [aws_s3_bucket_ownership_controls.nextstrain-archive]

  bucket = aws_s3_bucket.nextstrain-archive.id

  acl = "private"

  # the above ACL should be equivalent to this access_control_policy:

  # access_control_policy {
  #   grant {
  #     grantee {
  #       id   = data.aws_canonical_user_id.current.id
  #       type = "CanonicalUser"
  #     }
  #     permission = "FULL_CONTROL"
  #   }
  #   owner {
  #     id           = data.aws_canonical_user_id.current.id
  #   }
  # }
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
