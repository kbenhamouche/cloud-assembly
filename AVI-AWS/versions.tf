terraform {
  required_providers {
    avi = {
      source = "terraform-providers/avi"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"
}
