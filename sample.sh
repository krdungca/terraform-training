terraform init -reconfigure
cat .terraform/terraform.tfstate | grep "key"

#terraform apply -auto-approve

aws s3 ls | grep dev
