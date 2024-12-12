data "aws_route53_zone" "main" {
  name  = "tycm2-infra.fr"
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 5.0"

  domain_name  = "tycm2-infra.fr"
  zone_id      = data.aws_route53_zone.main.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.tycm2-infra.fr",
    "awshift.tycm2-infra.fr" 
  ]

  wait_for_validation = true

  tags = {
    Name = "tycm2-infra.fr"
  }
}

resource "aws_route53_record" "awshift" {
  zone_id = "Z2ES7B9AZ6SHAE"
  name    = "awshift.tycm2-infra.fr"
  type    = "CNAME"
  ttl     = 300

  records = [""] # Load Balancer url to add
}
