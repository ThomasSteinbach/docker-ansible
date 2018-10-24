ARG BASEIMAGE
FROM ${BASEIMAGE}

COPY site.yml /ansible/site.yml
RUN cd /ansible && \
    ansible-galaxy install -r requirements.yml
