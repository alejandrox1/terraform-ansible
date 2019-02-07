terraform {
  reuired_version = ">= 0.11, < 0.12"

  backend "s3" {}
}


module "eks-cluster" {
  source = "../../modules/eks"

  cluster-name = "terraform-test-1"
}
