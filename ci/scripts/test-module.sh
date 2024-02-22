#!/bin/bash
# Basic terraform test on a config.
# Params: $1 is the directory name, $2 (optional), the module registry URL, $3 (optional), the module version
set -e
pushd "$1"
if [ -n "$2" ] ; then sed -i "s@source =.*@source = \"$2\"@g" main.tf; fi
if [ -n "$3" ] ; then sed -i "s@# version =.*@version = \"$3\"@g" main.tf; fi
cat main.tf
terraform init
terraform validate
# Create
terraform plan
terraform apply -auto-approve
terraform plan | grep "No changes"
sleep 1
terraform destroy -auto-approve
popd