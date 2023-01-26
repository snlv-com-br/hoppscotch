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
  source = "git@github.com:snlv-com-br/terraform_modules.git//aws/s3_static_hosting"

  providers = {
    aws.main         = aws
    aws.acm_provider = aws
  }

  name_prefix         = "abla-hoppscotch"
  website_domain_name = var.DOMAIN_URL
  website_bucket_acl  = "private"

  website_error_document = "index.html"
  website_index_document = "index.html"

  user_name = var.AWS_USER_NAME

  # CORS
  # website_cors_allowed_headers = ["*"]
  # website_cors_allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
  # website_cors_additional_allowed_origins = []
  # website_cors_expose_headers = []
  # website_cors_max_age_seconds = 3600

  comment_for_cloudfront_website = "CloudFront distribution para o portal hoppscotch. Gestor de colecoes de APIs"

  create_route53_hosted_zone = false
  route53_hosted_zone_id     = "Z09148111EOX0T0NFNVW2" # abla.one

  tags = {
    "projeto" = "hoppscotch"
  }
}