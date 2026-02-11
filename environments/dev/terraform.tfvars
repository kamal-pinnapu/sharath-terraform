buckets = {
  logs = {
    bucket_name        = "mihp-dev-logs-123456"
    versioning_enabled = true
    force_destroy      = false
    tags = { Purpose = "logs" }
  }

  artifacts = {
    bucket_name        = "mihp-dev-artifacts-123456"
    versioning_enabled = true
    tags = { Purpose = "artifacts" }
  }
}
