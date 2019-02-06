S3_DIR := ./global/s3

.PHONY: all init clean clean-all 

all:
	terragrunt apply-all

bucket:
	terragrunt init \
		--terragrunt-working-dir $(S3_DIR)
	terragrunt plan \
		--terragrunt-working-dir $(S3_DIR)
	terragrunt apply \
		--terragrunt-working-dir $(S3_DIR)

kubeconfig:
	terragrunt output \
		--terragrunt-working-dir eks/dev/ \
		kubeconfig > kubeconfig

clean:
	rm -rf aws-auth.yaml kubeconfig
	rm -rf $(S3_DIR)/.terraform
	rm -rf ./eks/dev/.terraform

destroy-clustr:
	terragrunt destroy \
		--terragrunt-working-dir eks/dev/

clean-all: clean
	terragrunt destroy-all
