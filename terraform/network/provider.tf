terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "awshift-backend"
    key    = "state/network.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.region
}
