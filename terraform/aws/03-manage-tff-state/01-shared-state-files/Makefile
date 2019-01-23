.PHONY: init bucket

init:
	terraform init

# Create s3 bucet for storing state.
bucket: init
	terraform plan -out a.plan
	terraform apply a.plan

fmt:
	terraform fmt
