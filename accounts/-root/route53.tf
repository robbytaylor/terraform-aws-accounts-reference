resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_zone" "test-account" {
  provider = aws.test-account
  name     = "test-account.${aws_route53_zone.main.name}"
}

resource "aws_route53_record" "test-account-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.test-account.name
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.test-account.name_servers.0,
    aws_route53_zone.test-account.name_servers.1,
    aws_route53_zone.test-account.name_servers.2,
    aws_route53_zone.test-account.name_servers.3,
  ]
}
