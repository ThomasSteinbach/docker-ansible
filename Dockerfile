FROM ubuntu:17.10
MAINTAINER Thomas Steinbach (@aikq.de)

# install requirements from repos
RUN \
 apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install \
  ssh-client \
  vim \
  sudo \
  docker.io \
  python-pip \
  python-docker &&\
apt-get clean && \
apt-get autoremove

# install ansible
RUN pip install ansible

RUN adduser --disabled-password --gecos '' uid1000

# create ansibles default inventory dummy
RUN mkdir -p /etc/ansible && \
    touch /etc/ansible/hosts && \
    chown uid1000:uid1000 /etc/ansible/hosts

# add start script
ADD start.sh /usr/local/bin/start.sh
RUN chmod 0655 /usr/local/bin/start.sh

# create directories for Ansible repositories
RUN mkdir /ansible && \
    chown uid1000:uid1000 /ansible

USER uid1000

WORKDIR /ansible
ENTRYPOINT ["start.sh"]
