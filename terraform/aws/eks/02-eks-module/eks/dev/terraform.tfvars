# Configure DynamoDB for locking.
terragrunt = {
  dependencies {
    paths = ["../../global/s3"]
  }

  # Configure terragrunt to automatically store tfstate files in S3.
  remote_state {
    backend = "s3"

    config {
      bucket = "terraform-test-alejandrox1-1"
      key    = "${path_relative_to_include()}/eks/dev/terraform.tfstate"
      region = "us-east-1"
      encrypt = true

      # Tell Terraform to do locking using DynamoDB. Terragrunt will automatically
      # create this table for you if it doesn't already exist.
      dynamodb_table = "my-lock-table"
    }
  }
}
