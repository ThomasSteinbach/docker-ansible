ARG BASEIMAGE
FROM ${BASEIMAGE}

COPY . /ansible/
RUN cd /ansible && \
    ansible-galaxy install -r requirements.yml
