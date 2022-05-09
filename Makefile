help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup: ## Update fresh install and install ansible
	./bin/update-fresh-install.sh
	./bin/ansible-setup.sh

ansible/deps: ## Download ansible deps
	ansible-galaxy install -r requirements.yml

ansible/popos: ## Run ansible Pop!_OS recipe
	ansible-playbook --ask-become-pass popos.yml