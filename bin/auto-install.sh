#!/bin/sh

ANSIBLE_PREFIX=my_ansible
ANSIBLE_DIR=~/.$ANSIBLE_PREFIX
ANSIBLE_INIT_FILE=$ANSIBLE_PREFIX.sh

# TODO: check if exists to clone or pull
git clone https://github.com/PedroRossi/ansible $ANSIBLE_DIR

OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  PLAYBOOK=m1
elif [ "$OS" = "Linux" ]; then
  DISTRO=$(head -n 1 /etc/issue | cut -d ' ' -f1)
  if [ "$DISTRO" = "Debian" ]; then
    PLAYBOOK=debian
  else
    PLAYBOOK=popos
  fi
fi

echo """#!/bin/sh
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
sudo update-rc.d $ANSIBLE_INIT_FILE defaults
if [ "$DISTRO" = "Debian" ]; then
  echo "0 12 */7 * * /etc/init.d/$ANSIBLE_INIT_FILE start" | crontab -
fi
exit 0
