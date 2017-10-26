#!/bin/bash

set -e

if [[ ! -z "$LOCAL_USER" ]]; then
  echo "localhost ansible_ssh_host=172.17.0.1 ansible_ssh_user=$LOCAL_USER" > /etc/ansible/hosts
fi

cd /opt/ansible

if [[ "$UPDATE_REPO" = 'true' ]]; then
  git pull --rebase
  git submodule update --init --recursive
fi

if [[ ! -z "$BRANCH" ]]; then
  git reset --hard origin/HEAD
  git checkout "$BRANCH"
  git submodule update --init --recursive
fi

if [[ ! -z "$VERSION" ]]; then
  git reset --hard "$VERSION"
  git submodule update --init --recursive
fi

source "/opt/ansible/hacking/env-setup" -q

cd /ansible

exec "$@"
