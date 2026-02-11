module "s3" {
  source = "./modules/s3-buckets"

  default_tags = {
    Environment = "dev"
    Team        = "CloudEng"
  }

  buckets = {
    tfstate = {
      bucket_name = "my-tfstate-123456"
      # no website block => website resources NOT created
    }

    static_site = {
      bucket_name = "my-static-site-123456"
      website = {
        index_document = "index.html"
        error_document = "error.html"
        public_read    = true
      }
    }
  }
}
