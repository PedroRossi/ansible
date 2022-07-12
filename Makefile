help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup: ## Update fresh install
	./bin/update-fresh-install.sh

ansible/deps: ## Download ansible deps
	ansible-galaxy install -r requirements.yml

ansible/popos: ## Run ansible Pop!_OS recipe
	ansible-playbook -b popos.yml

ansible/m1: ## Run ansible MacOS M1 recipe
	ansible-playbook -b m1.yml
