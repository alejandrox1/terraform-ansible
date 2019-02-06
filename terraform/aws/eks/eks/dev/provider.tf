provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

# This data source is included for ease of sample architecture deployment.
data "aws_region" "current" {}
