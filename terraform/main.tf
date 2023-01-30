terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = "~> 1.0"
  backend "s3" {}
}

module "s3-static-website" {
  source = "cn-terraform/s3-static-website/aws"

  providers = {
    aws.main         = aws
    aws.acm_provider = aws
  }

  name_prefix         = "abla-hoppscotch"
  website_domain_name = var.DOMAIN_URL
  website_bucket_acl  = "private"

  website_error_document = "index.html"
  website_index_document = "index.html"

  # CORS
  # website_cors_allowed_headers = ["*"]
  # website_cors_allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
  # website_cors_additional_allowed_origins = []
  # website_cors_expose_headers = []
  # website_cors_max_age_seconds = 3600

  comment_for_cloudfront_website = "CloudFront distribution para o portal hoppscotch. Gestor de colecoes de APIs"

  cloudfront_custom_error_responses = [
    {
      error_caching_min_ttl = 300
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
    },
    {
      error_caching_min_ttl = 300
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
    }
  ]

  # abla.com.br
  create_route53_hosted_zone = false
  route53_hosted_zone_id     = "Z02901972GYE28YO8W4MZ"

  # *.abla.one
  # create_acm_certificate = false
  # acm_certificate_arn_to_use = "arn:aws:acm:us-east-1:865320629804:certificate/e8506a30-52ea-4591-b66a-a0e667e0f6bc"

  tags = {
    "projeto" = "hoppscotch"
  }
}
