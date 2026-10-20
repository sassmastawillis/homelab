output "buckets" {
  description = "Bucket names, used as Backrest repo URIs (b2:<name>)."
  value       = { for k, b in b2_bucket.backup : k => b.bucket_name }
}

output "key_ids" {
  description = "Application key IDs."
  value       = { for k, key in b2_application_key.backup : k => key.application_key_id }
}

output "keys" {
  description = "Application key secrets. Read with: terraform output -json keys"
  value       = { for k, key in b2_application_key.backup : k => key.application_key }
  sensitive   = true
}
