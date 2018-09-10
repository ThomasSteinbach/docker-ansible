FROM alpine:3.8
LABEL maintainer="Thomas Steinbach"

# install requirements from repos
RUN \
  apk update && \
  apk add \
    ansible \
    sudo \
    openssh-client

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
