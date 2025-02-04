module "alb" {
  source = "terraform-aws-modules/alb/aws"


  name_prefix                = "awshif"
  vpc_id                     = module.vpc.vpc.id
  subnets                    = module.vpc.public_subnet[*].id
  enable_deletion_protection = false

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.cidr_block
    }
  }

  listeners = {
    http-redirect = {
      port     = 3000
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:acm:eu-north-1:149028371915:certificate/bbd2cd01-ed68-479a-bbcb-d4b6549b17e3"

      forward = {
        target_group_key = "worker-instances"
      }
    }
  }

  target_groups = {
    worker-instances = {
      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 3000
      target_type = "instance"
      target_id   = module.bastion_instance.instance.id
    }
  }

  tags = {
    "project_name" = "awshift"
  }

  route53_records = {
    awshift = {
      zone_id = data.aws_route53_zone.main.zone_id
      name    = "awshift.${data.aws_route53_zone.main.name}"
      type    = "A"
    }
  }
}
