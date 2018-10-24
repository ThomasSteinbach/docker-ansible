FROM alpine:3.8
LABEL maintainer="Thomas Steinbach"

# install requirements from repos
RUN \
  apk add --no-cache \
    ansible \
    sudo \
    openssh-client && \
  rm -rf /var/cache/apk/*

RUN ln -s /usr/bin/python3 /usr/bin/python

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

RUN mkdir /home/uid1000/.ssh && \
    chmod 0700 /home/uid1000/.ssh

ENTRYPOINT ["start.sh"]
