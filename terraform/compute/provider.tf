terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "dhole-backend"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
  # default_tags {
  #   tags = merge(local.common_tags)
  # }
}
