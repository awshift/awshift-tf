data "aws_route53_zone" "main" {
  name = "tycm2-infra.fr"
}

# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 5.0"

#   domain_name = "matih.eu"
#   zone_id     = data.aws_route53_zone.main.zone_id

#   validation_method = "DNS"

#   # subject_alternative_names = [
#   #   "*.tycm2-infra.fr",
#   #   "awshift.tycm2-infra.fr" 
#   # ]

#   wait_for_validation = true

#   tags = {
#     Name = "matih.eu"
#   }
# }

# resource "aws_route53_record" "awshift" {
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = "awshift.matih.eu"
#   type    = "CNAME"
#   ttl     = 300

#   records = [module.master_instances[0].public_ips]
# }
