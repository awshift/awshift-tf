terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "awshift-backend"
    key     = "state/compute.tfstate"
    region  = "eu-north-1"
    profile = "ynov"
  }
}

provider "aws" {
  region  = var.region
  profile = "ynov"

}
