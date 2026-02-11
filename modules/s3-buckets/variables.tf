variable "buckets" {
  description = "Map of bucket configs keyed by logical name"
  type = map(object({
    bucket_name        = string
    versioning_enabled = optional(bool, true)
    force_destroy      = optional(bool, false)

    sse_algorithm      = optional(string, "AES256") # or "aws:kms"
    kms_key_arn        = optional(string, null)

    block_public_acls       = optional(bool, true)
    block_public_policy     = optional(bool, true)
    ignore_public_acls      = optional(bool, true)
    restrict_public_buckets = optional(bool, true)

    tags = optional(map(string), {})
  }))
}

variable "default_tags" {
  description = "Tags applied to every bucket"
  type        = map(string)
  default     = {}
}
