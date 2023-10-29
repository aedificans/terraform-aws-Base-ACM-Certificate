output "arn" {
  description = "The ARN of the ACM Certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}
