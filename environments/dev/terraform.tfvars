region = "us-east-1"

buckets = {

  # 🔥 Static Website Bucket
  static_site = {
    bucket_name   = "sharath-static-site-123456"
    force_destroy = true

    tags = {
      Purpose = "static-website"
    }

    website = {
      index_document = "index.html"
      error_document = "error.html"
      public_read    = true
    }
  }

  # 🔒 Regular Private Bucket
  private_bucket = {
    bucket_name   = "sharath-private-bucket-123456"
    force_destroy = false

    tags = {
      Purpose = "application-storage"
    }

    # No website block → stays private
  }
}
