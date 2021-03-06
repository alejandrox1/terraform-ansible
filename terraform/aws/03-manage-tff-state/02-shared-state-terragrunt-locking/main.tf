provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.11"

  backend "s3" {}
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-alejandrox1"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}
