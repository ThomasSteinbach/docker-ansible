#!/bin/bash

set -e

if [ $# -eq 0 ]; then
  echo 'sudo docker run -it --rm -v "$PWD:/ansible" -v "$(echo $HOME)/.ssh/id_rsa":/home/uid1000/.ssh/id_rsa --env "LOCAL_USER=$(whoami)" thomass/ansible bash'
fi

if [[ ! -z "$LOCAL_USER" ]]; then
  echo "localhost ansible_ssh_host=172.17.0.1 ansible_ssh_user=$LOCAL_USER" > /etc/ansible/hosts
fi

exec "$@"
