resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_zone" "staging" {
  provider = aws.staging
  name     = "staging.${aws_route53_zone.main.name}"
}

resource "aws_route53_record" "staging-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.staging.name
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.staging.name_servers.0,
    aws_route53_zone.staging.name_servers.1,
    aws_route53_zone.staging.name_servers.2,
    aws_route53_zone.staging.name_servers.3,
  ]
}
