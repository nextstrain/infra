# Import existing configuration for the `nextstrain-tmp` bucket
## Note that this is a one-time operation; we leave the import block
## here to show where this resource originally came from
import {
  to = aws_s3_bucket.nextstrain-tmp
  id = "nextstrain-tmp"
}

resource "aws_s3_bucket" "nextstrain-tmp" {
  bucket        = "nextstrain-tmp"
  force_destroy = null
}

resource "aws_s3_bucket_versioning" "nextstrain-tmp" {
  bucket = aws_s3_bucket.nextstrain-tmp.id

  versioning_configuration {
    mfa_delete = "Disabled"
    status     = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "nextstrain-tmp" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.nextstrain-tmp]

  bucket = aws_s3_bucket.nextstrain-tmp.id

  rule {
    id = "delete old objects"

    # apply this rule to all objects in the bucket
    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
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

resource "aws_s3_bucket_ownership_controls" "nextstrain-tmp" {
  bucket = aws_s3_bucket.nextstrain-tmp.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "nextstrain-tmp" {
  depends_on = [aws_s3_bucket_ownership_controls.nextstrain-tmp]

  bucket = aws_s3_bucket.nextstrain-tmp.id

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

resource "aws_s3_bucket_server_side_encryption_configuration" "nextstrain-tmp" {
  bucket = aws_s3_bucket.nextstrain-tmp.id

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
