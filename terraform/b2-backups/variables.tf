variable "bucket_prefix" {
  description = "Prefix for bucket names. B2 bucket names are globally unique across all accounts."
  type        = string
  default     = "rossyserver"
}

variable "buckets" {
  description = "One bucket (and one scoped key) per backup target."
  type = map(object({
    description = string
  }))
  default = {
    compose = { description = "/compose - stack files and .env secrets" }
    config  = { description = "/config - app config directories" }
  }
}
