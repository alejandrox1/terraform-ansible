terraform {
  required_version = ">= 0.11, < 0.12"

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
}
