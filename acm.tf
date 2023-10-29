resource "aws_acm_certificate" "this" {
  domain_name               = var.certificate_domain
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags = merge(
    local.tags,
    tomap({ Name = "${local.naming.display} SSL Certificate" })
  )
}
resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn
}
