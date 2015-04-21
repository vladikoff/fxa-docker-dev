FROM ubuntu:utopic

MAINTAINER vladikoff <vlad@vladikoff.com>

ENV NODE_ENV development

# Install deps
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl && curl -sL https://deb.nodesource.com/setup | sudo bash - && DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs git-core libgmp3-dev graphicsmagick redis-server python-virtualenv

RUN useradd --home /home/fxa fxa
# Install fxa-local-dev
RUN cd /home/fxa && git clone https://github.com/vladikoff/fxa-local-dev.git && cd fxa-local-dev && npm i --unsafe-perm

WORKDIR /home/fxa/fxa-local-dev
VOLUME ["/home/fxa"]

# Expose ports
EXPOSE 8125/udp
