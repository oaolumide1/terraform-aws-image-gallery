terraform {

  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "oaolumide1-tfstate-738882406911"
    key            = "image-gallery/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}