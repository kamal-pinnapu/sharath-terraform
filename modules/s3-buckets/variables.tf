variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "buckets" {
  description = "Map of bucket configs keyed by logical name"
  type = map(object({
    bucket_name   = string
    force_destroy = optional(bool, false)

    tags = optional(map(string), {})

    # Optional: enable S3 static website hosting for THIS bucket
    website = optional(object({
      enabled       = optional(bool, true)
      index_document = string
      error_document = optional(string, "error.html")

      # If true, module will make bucket public-read for website content
      public_read = optional(bool, true)

      # Optional: custom routing rules JSON (advanced)
      routing_rules_json = optional(string, null)
    }), null)

    # Public access block defaults (safe). Will be overridden when website.public_read=true
    public_access_block = optional(object({
      block_public_acls       = optional(bool, true)
      block_public_policy     = optional(bool, true)
      ignore_public_acls      = optional(bool, true)
      restrict_public_buckets = optional(bool, true)
    }), {})
  }))
}

variable "default_tags" {
  type    = map(string)
  default = {}
}
