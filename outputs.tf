output "website_address" {
  value = module.cloudfront_s3_website_oudam_es.website_address
}

output "s3_domain" {
  value = module.cloudfront_s3_website_oudam_es.s3_domain_name
}

output "s3_bucket_regional_domain_name" {
  value = module.cloudfront_s3_website_oudam_es.s3_bucket_regional_domain_name
}