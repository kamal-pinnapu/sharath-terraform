resource "aws_s3_bucket" "this" {
  for_each      = var.buckets
  bucket        = each.value.bucket_name
  force_destroy = try(each.value.force_destroy, false)

  tags = merge(var.default_tags, try(each.value.tags, {}))
}

# Website configuration (ONLY when website is enabled)
resource "aws_s3_bucket_website_configuration" "this" {
  for_each = local.website_buckets
  bucket   = aws_s3_bucket.this[each.key].id

  index_document {
    suffix = each.value.website.index_document
  }

  error_document {
    key = try(each.value.website.error_document, "error.html")
  }

  routing_rules = try(each.value.website.routing_rules_json, null)
}

# Public access block
# - default: safe (blocks public)
# - if website.public_read=true: relax blocks so website can be public
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.buckets
  bucket   = aws_s3_bucket.this[each.key].id

  block_public_acls       = contains(keys(local.website_public_buckets), each.key) ? false : try(each.value.public_access_block.block_public_acls, true)
  block_public_policy     = contains(keys(local.website_public_buckets), each.key) ? false : try(each.value.public_access_block.block_public_policy, true)
  ignore_public_acls      = contains(keys(local.website_public_buckets), each.key) ? false : try(each.value.public_access_block.ignore_public_acls, true)
  restrict_public_buckets = contains(keys(local.website_public_buckets), each.key) ? false : try(each.value.public_access_block.restrict_public_buckets, true)
}

# Bucket policy to allow public read (ONLY when website.public_read=true)
resource "aws_s3_bucket_policy" "public_read" {
  for_each = local.website_public_buckets
  bucket   = aws_s3_bucket.this[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadForWebsite"
      Effect    = "Allow"
      Principal = "*"
      Action    = ["s3:GetObject"]
      Resource  = "${aws_s3_bucket.this[each.key].arn}/*"
    }]
  })

  depends_on = [aws_s3_bucket_public_access_block.this]
}

