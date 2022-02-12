provider "aws" {
  # cloudfront requires ssl cert to be in us-east-1
  region = "us-east-1"
}

locals {
  domain = "oudam.es"
}

module "cloudfront_s3_website_oudam_es" {
  source                      = "./terraform-aws-cloudfront-s3-website"
  hosted_zone                 = local.domain
  domain_name                 = local.domain
  acm_certificate_domain      = local.domain #aws_acm_certificate.oudam_es_ssl_cert.domain_name
  lambda_function_association = {
    event_type : "origin-request"
    include_body : false
    lambda_arn : module.index_routing_handler_at_edge.arn
  }
}

resource "aws_acm_certificate" "oudam_es_ssl_cert" {
  domain_name       = local.domain
  validation_method = "DNS"

  tags = {
    flows = "cloudfront:s3"
  }

  lifecycle {
    create_before_destroy = true
  }
}