.PHONY: help
.DEFAULT_GOAL := help
SHELL ?= /usr/bin/bash

COLOR_GREEN=$(shell echo "\033[0;32m")
COLOR_RED=$(shell echo "\033[0;31m")
COLOR_END=$(shell echo "\033[0;0m")

BUFFER_ITERATIONS = 12
BUFFER_SLEEP = 10

## ---
## HELP - SHOWS A LIST OF AVAILABLE TARGETS WHICH CAN BE CALLED WITH MAKE.
## ---

help:
	@for makefile in $(MAKEFILE_LIST) ; do \
		grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $$makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' ; \
	done

## ---
## A LIST OF STAGES TO OPERATE IN ORDER. NOT SHOWN IN MAKE LIST.
## ---

terraform-deploy: ## Run the Terraform commands to deploy the virtual machine infrastructure.
	@echo "$(COLOR_GREEN)\n--- Deploying infrastructure using Terraform.$(COLOR_END)"
	@cd tf && terraform init && terraform plan && terraform apply -auto-approve

terraform-teardown: ## Run the Terraform commands to destroy the K8s infrastructure. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Tearing down infrastructure deployed by Terraform.$(COLOR_END)"
	@cd tf && terraform destroy -auto-approve 

ansible-deploy: ## Run the Ansible playbook against the K8s infrastructure.
	@echo "$(COLOR_GREEN)\n--- Running Ansible Playbook.$(COLOR_END)"
	@cd tf && cd ansible && ansible-playbook -i inventory.ini main.yaml

pause-buffer:
	@echo "$(COLOR_GREEN)\n--- Waiting $(BUFFER_ITERATIONS)0s to allow the backend infrastructure to process any unfinished work.\nPlease wait.$(COLOR_END)"

	@n=$(BUFFER_ITERATIONS); \
	while [ $${n} -gt 0 ]; do\
		echo $$n"0"; \
		n=`expr $$n - 1`; \
		sleep $(BUFFER_SLEEP); \
	done; \
	true

	@echo "$(COLOR_GREEN)\n--- Pause Buffer Complete.  Continuing.$(COLOR_END)"

## --
## CALL MULTIPLE TARGETS FROM A SINGLE CALL
## ---

setup: terraform-deploy pause-buffer ansible-deploy ## Runs a full, end-to-end deployment with infrastructure, K8s, and umbrella.
	@echo "$(COLOR_GREEN)\n--- Setup completed.$(COLOR_END)"

teardown: terraform-teardown ## Runs all cleanup and teardown commands. WARNING: Permanent deletion!
	@echo "$(COLOR_GREEN)\n--- Teardown completed.$(COLOR_END)"
