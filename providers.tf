terraform {
  required_version = "~>1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-bucket-udemy-10162025"
    key    = "backends/default/defaultstate.tfstate"
    region = "ap-southeast-1"
  }
}

#set the aws region
provider "aws" {
  region = "ap-southeast-1"
  alias = "ap-southeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}
