#!/bin/bash

set -e

if [[ ! -z "$LOCAL_USER" ]]; then
  echo "localhost ansible_ssh_host=172.17.0.1 ansible_ssh_user=$LOCAL_USER" > .inventory_temp
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
  git reset --hard origin/HEAD
  cd "$REPO"
  git checkout "$BRANCH"
fi

if [[ ! -z "$VERSION" ]]; then
  git reset --hard origin/HEAD
  cd "$REPO"
  git reset --hard "$VERSION"
fi

source "${REPO}/hacking/env-setup" -q

exec "$@"
