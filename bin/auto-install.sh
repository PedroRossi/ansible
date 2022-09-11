#!/bin/sh

ANSIBLE_PREFIX=my_ansible
ANSIBLE_DIR=~/.$ANSIBLE_PREFIX
ANSIBLE_INIT_FILE=$ANSIBLE_PREFIX.sh

# TODO: check if exists to clone or pull
git clone https://github.com/PedroRossi/ansible $ANSIBLE_DIR
# TODO: ask or check before these
$ANSIBLE_DIR/bin/update-fresh-install.sh

OS=$(uname -s)
SU="sudo"

if [ "$OS" = "Darwin" ]; then
  PLAYBOOK=m1
elif [ "$OS" = "Linux" ]; then
  DISTRO=$(head -n 1 /etc/issue | cut -d ' ' -f1)
  if [ "$DISTRO" = "Debian" ]; then
    SU=""
    PLAYBOOK=debian
  else
    PLAYBOOK=popos
  fi
fi

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
$SU mv ~/$ANSIBLE_INIT_FILE /etc/init.d/
$SU update-rc.d $ANSIBLE_INIT_FILE defaults
exit 0
