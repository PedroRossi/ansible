#!/bin/sh

sudo apt install software-properties-common 
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible