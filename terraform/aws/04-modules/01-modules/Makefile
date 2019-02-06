export TF_VAR_db_password := "password"


.PHONY: clean

all:
	terragrunt apply-all

clean:
	rm -rf ./global/s3/.terraform
	rm -rf ./stage/data-stores/mysql/.terraform
	rm -rf ./stage/services/webserver-cluster/.terraform
	rm -rf ./prod/data-stores/mysql/.terraform
	rm -rf ./prod/services/webserver-cluster/.terraform

clean-all:
	terragrunt destroy \
		--terragrunt-working-dir ./stage/data-stores/mysql
	terragrunt destroy \
		--terragrunt-working-dir ./stage/services/webserver-cluster
