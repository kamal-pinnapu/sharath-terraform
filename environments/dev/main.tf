module "s3_buckets" {
  source = "../../modules/s3-buckets"

  default_tags = {
    Environment = "dev"
    Team        = "abc"
  }

  buckets = var.buckets
}
