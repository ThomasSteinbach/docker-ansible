FROM ubuntu:16.04
MAINTAINER Thomas Steinbach <thomas.steinbach@aikq.de>

# install requirements from repos
RUN \
 apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install \
  ssh-client \
  vim \
  python-pip \
  python-docker && \
 apt-get clean && \
 apt-get autoclean

# install requirements from pip
RUN pip install paramiko PyYAML Jinja2 httplib2 six

# create ansibles default inventory dummy
RUN mkdir -p /etc/ansible && \
    touch /etc/ansible/hosts && \
    chown uid1000:uid1000 /etc/ansible/hosts

# add start script
ADD start.sh /usr/local/bin/start.sh
RUN chmod 0655 /usr/local/bin/start.sh

RUN adduser --disabled-password --gecos '' uid1000

# create directories for Ansible repositories
RUN mkdir /ansible && \
    mkdir /ansible_official && \
    mkdir /ansible_thomassteinbach && \
    chown uid1000:uid1000 /ansible && \
    chown uid1000:uid1000 /ansible_official && \
    chown uid1000:uid1000 /ansible_thomassteinbach

USER uid1000

# clone repositories
RUN git clone --recursive git://github.com/ansible/ansible.git /ansible_official && \
    git clone --recursive git@github.com:ThomasSteinbach/ansible.git /ansible_thomassteinbach

WORKDIR /ansible
ENTRYPOINT ["start.sh"]
