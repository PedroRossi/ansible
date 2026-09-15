help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup: ## Update fresh install
	./bin/update-fresh-install.sh

ansible/deps: ## Download ansible deps
	ansible-galaxy install -r requirements.yml

ansible/desktop: ## Run ansible Debian desktop recipe
	ansible-playbook -b desktop.yml

ansible/m1: ## Run ansible MacOS M1 recipe
	ansible-playbook -b m1.yml -K

ansible/debian: ## Run ansible Debian recipe
	ansible-playbook -b debian.yml

ansible/nas: ## Run ansible NAS recipe
	ansible-playbook -b nas.yml

docker/debian: ## Run docker debian to simulate server for development
	docker run -it \
		-v $(shell pwd):/root/ansible/ \
		-v ${HOME}/.gitconfig:/root/.gitconfig \
		-v ${HOME}/.ssh/:/root/.ssh/ \
		debian bash
