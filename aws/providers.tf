terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest
provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/aws/latest
provider "aws" {
  profile                  = "cfs"
  # Configuration options
  default_tags {
    tags = {
      author = "Adam Smith <adam.smith@arusty.dev>"
    }
  }
}