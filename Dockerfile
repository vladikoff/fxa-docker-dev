FROM ubuntu:utopic

MAINTAINER vladikoff <vlad@vladikoff.com>

ENV NODE_ENV development

# Install deps
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install curl && curl -sL https://deb.nodesource.com/setup | sudo bash - && DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs git-core libgmp3-dev graphicsmagick redis-server python-virtualenv
# Install fxa-local-dev
RUN git clone https://github.com/vladikoff/fxa-local-dev.git && cd fxa-local-dev && npm i

# Expose ports
EXPOSE 8125/udp
