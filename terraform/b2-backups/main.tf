resource "b2_bucket" "backup" {
  for_each = var.buckets

  bucket_name = "${var.bucket_prefix}-${each.key}"
  bucket_type = "allPrivate"

  # B2 keeps every version of deleted files by default.
  # Restic prunes its own old data, so purge hidden files after 1 day to actually free space.
  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 30
  }

  # Server-side encryption at rest (restic also encrypts client-side).
  default_server_side_encryption {
    mode      = "SSE-B2"
    algorithm = "AES256"
  }
}

# One key per bucket, scoped to that bucket only, with only what restic needs.
resource "b2_application_key" "backup" {
  for_each = var.buckets

  key_name   = "backrest-${var.bucket_prefix}-${each.key}"
  bucket_ids = [b2_bucket.backup[each.key].bucket_id]

  capabilities = [
    "listBuckets",
    "listFiles",
    "readFiles",
    "writeFiles",
    "deleteFiles",
  ]
}
