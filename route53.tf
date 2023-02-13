# create a route53 to translate domain name into ip_address

# get hosted zone details
resource "aws_route53_zone" "project_zone" {
  name = var.domain_name
}

# create a terraform aws record set in route 53
resource "aws_route53_record" "project_domain_record" {
  zone_id = aws_route53_zone.project_zone.id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.project_lb.dns_name
    zone_id                = aws_lb.project_lb.zone_id
    evaluate_target_health = true
  }
}