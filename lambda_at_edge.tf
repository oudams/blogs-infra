locals {
  lambda_name = "index-routing-handler"
}

module "index_routing_handler_at_edge" {
  source  = "transcend-io/lambda-at-edge/aws"
  version = "0.4.0"

  name                   = local.lambda_name
  description            = "Cloudformation index.html request handling"
  lambda_code_source_dir = "./lambdas/${local.lambda_name}/"
  s3_artifact_bucket     = aws_s3_bucket.index_routing_handler_lambda_artifact.bucket
  runtime                = "nodejs14.x"
}

resource "aws_s3_bucket" "index_routing_handler_lambda_artifact" {
  bucket = "${local.lambda_name}-lambda-artifact"
  acl    = "private"

  tags = {
    Name = "cloudfront index routing handler lambda function artifact"
  }
}