terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "mara"
  region  = "us-east-1"
  default_tags {
    tags = {
      Environment  = "mara-lab"
      github_repos = "http://github.com/filthystinkingcasual/gggr-terraform"
    }
  }
}
