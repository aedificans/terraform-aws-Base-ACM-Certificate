data "aws_route53_zone" "validation" {
  name         = var.hosted_zone_domain
  private_zone = false
}
