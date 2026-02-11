locals {
  # only buckets that have website enabled
  website_buckets = {
    for k, v in var.buckets :
    k => v
    if v.website != null && try(v.website.enabled, true)
  }

  # only buckets that want public read for website
  website_public_buckets = {
    for k, v in local.website_buckets :
    k => v
    if try(v.website.public_read, true)
  }
}
