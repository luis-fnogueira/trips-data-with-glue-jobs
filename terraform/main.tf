terraform {

  required_version = "1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }
  }


  backend "s3" {}

}

provider "aws" {

  region  = "us-east-1"
  profile = "luis"

}