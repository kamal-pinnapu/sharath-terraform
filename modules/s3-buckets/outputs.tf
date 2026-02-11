output "bucket_names" {
  value = { for k, b in aws_s3_bucket.this : k => b.bucket }
}

output "website_endpoints" {
  value = {
    for k, w in aws_s3_bucket_website_configuration.this :
    k => w.website_endpoint
  }
  description = "Only buckets with website enabled will appear here"
}

