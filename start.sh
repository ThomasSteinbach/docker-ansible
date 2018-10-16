#!/bin/sh

set -e

runPlaybook()
{
  cd /ansible
  exec ansible-playbook site.yml
}

printHelp()
{
  echo 'sudo docker run -it --rm -v "$PWD:/ansible" -v "$(echo $HOME)/.ssh/id_rsa":/home/uid1000/.ssh/id_rsa --env "LOCAL_USER=$(whoami)" thomass/ansible bash'
  exit 0
}

#
# start script execution
#

# when playbook is meant to be run against docker host...
if [[ ! -z "$LOCAL_USER" ]]; then
  echo "localhost ansible_ssh_host=172.17.0.1 ansible_ssh_user=$LOCAL_USER" > /etc/ansible/hosts
fi

# When script is called with zero parameters
if [ $# -eq 0 ]; then
  # for derived ansible docker images check if a playbook is provided
  if [[ -f /ansible/site.yml ]]; then
    runPlaybook
  else
    printHelp
  fi
fi

exec "$@"
