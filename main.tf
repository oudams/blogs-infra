provider "aws" {
  // for acm_certificate_domain only
  region = "us-east-1"
}

locals {
  lambda_function_association = {
    event_type : "origin-request"
    include_body : false
    lambda_arn : module.index_routing_handler_at_edge.arn
    #    lambda_arn : "arn:aws:lambda:us-east-1:883979811993:function:cloudfront-index-handler:1"
  }
}

module "cloudfront_s3_website_oudam_es" {
  source                      = "./terraform-aws-cloudfront-s3-website"
  hosted_zone                 = "oudam.es"
  domain_name                 = "oudam.es"
  acm_certificate_domain      = "oudam.es"
  lambda_function_association = local.lambda_function_association
}