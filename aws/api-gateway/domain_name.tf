/*

**** WIP ****

==============
variables.tf
==============
variable "root_domain" {
  type        = string
  description = "The domain name to associate with the API"
  default     = "demo.hands-on-cloud.com" //replace your root domain name here
}
variable "subdomain"{
  type        = string
  description = "The subdomain for the API"
  default     = "api.demo.hands-on-cloud.com" //replace your subdomain name here
}

=================
domain_config.tf
=================
data "aws_route53_zone" "root_domain" {
  name         = var.root_domain
  private_zone = false
}
#certificate generation and validation:
resource "aws_acm_certificate" "certificate" {
  domain_name       = var.subdomain
  validation_method = "DNS"
}

resource "aws_route53_record" "certificate_validation" {
  name    = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.root_domain.zone_id
  records = [tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}
resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.certificate_validation.fqdn]
}

# The domain name to use with api-gateway
resource "aws_api_gateway_domain_name" "domain_name" {
  domain_name = var.subdomain
  regional_certificate_arn = aws_acm_certificate_validation.certificate_validation.certificate_arn
  endpoint_configuration {
    types = [
      "REGIONAL",
    ]
  }
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  api_id      = aws_api_gateway_rest_api.rest_api.id
  stage_name  = aws_api_gateway_stage.rest_api_stage.stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
}

#creating route53 record for the domain to be used with REST API
resource "aws_route53_record" "sub_domain" {
  name    = var.subdomain
  type    = "A"
  zone_id = data.aws_route53_zone.root_domain.zone_id
  alias {
    name                   = aws_api_gateway_domain_name.domain_name.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.domain_name.regional_zone_id
    evaluate_target_health = false
  }
}
*/