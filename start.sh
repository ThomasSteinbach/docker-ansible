#!/bin/bash

set -e

if [[ ! -z "$LOCAL_USER" ]]; then
  echo "localhost ansible_ssh_host=172.17.0.1 ansible_ssh_user=$LOCAL_USER" > /etc/ansible/hosts
fi

if [[ "$USE_THOMASS_REPO" = 'true' ]]; then
  REPO="/ansible_thomassteinbach"
else
  REPO="/ansible_official"
fi

if [[ "$UPDATE_REPO" = 'true' ]]; then
  cd "$REPO"
  git pull --rebase
  git submodule update --init --recursive
fi

if [[ ! -z "$BRANCH" ]]; then
  cd "$REPO"
  git reset --hard origin/HEAD
  git checkout "$BRANCH"
  git submodule update --init --recursive
fi

if [[ ! -z "$VERSION" ]]; then
  cd "$REPO"
  git reset --hard "$VERSION"
  git submodule update --init --recursive
fi

source "${REPO}/hacking/env-setup" -q

cd /ansible

exec "$@"
