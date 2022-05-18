#!/bin/bash

ANSIBLE_PREFIX=my_ansible
ANSIBLE_DIR=~/.$ANSIBLE_PREFIX
ANSIBLE_INIT_FILE=$ANSIBLE_PREFIX.sh

git clone https://github.com/PedroRossi/ansible $ANSIBLE_DIR
$ANSIBLE_DIR/bin/update-fresh-install.sh
$ANSIBLE_DIR/bin/install-ansible.sh

# TODO: ask for available playbooks
PLAYBOOK=popos

echo -e """#!/bin/sh
# chkconfig: 345 99 10
case "\$1" in
  start)
    $ANSIBLE_DIR/bin/sync-ansible.sh $ANSIBLE_DIR $PLAYBOOK
    ;;
  *)
    ;;
esac
exit 0""" > ~/$ANSIBLE_INIT_FILE
chmod +x ~/$ANSIBLE_INIT_FILE
sudo mv ~/$ANSIBLE_INIT_FILE /etc/init.d/
update-rc.d $ANSIBLE_INIT_FILE defaults
exit 0
