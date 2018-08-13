FROM ubuntu:18.04
LABEL maintainer="Thomas Steinbach"

# install requirements from repos
RUN \
 apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ssh-client \
  vim \
  sudo \
  docker.io \
  python3-pip \
  python3-docker &&\
apt-get clean && \
apt-get autoremove && \
rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

# install ansible
RUN pip3 install ansible==2.6.2

RUN adduser --disabled-password --gecos '' uid1000

# create ansibles default inventory dummy
RUN mkdir -p /etc/ansible && \
    printf '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts && \
    chown uid1000:uid1000 /etc/ansible/hosts

# add start script
COPY start.sh /usr/local/bin/start.sh
RUN chmod 0655 /usr/local/bin/start.sh

# create directories for Ansible repositories
RUN mkdir /ansible && \
    chown uid1000:uid1000 /ansible

WORKDIR /ansible

USER uid1000

ENTRYPOINT ["start.sh"]
