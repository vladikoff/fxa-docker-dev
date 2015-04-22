FROM ubuntu:utopic

MAINTAINER vladikoff <vlad@vladikoff.com>

# Install deps
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl && curl -sL https://deb.nodesource.com/setup | sudo bash - && DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential nodejs git-core libgmp3-dev graphicsmagick redis-server python-dev python-virtualenv

RUN adduser --disabled-password --gecos '' fxa && adduser fxa sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN npm install -g npm@2.4 && sh -c "ulimit -n 65535 && exec su $LOGNAME"

USER fxa

# Install fxa-local-dev
RUN cd /home/fxa && git clone https://github.com/vladikoff/fxa-local-dev.git && cd fxa-local-dev && npm i

WORKDIR /home/fxa/fxa-local-dev
VOLUME /root/.npm /home/fxa

# Expose ports
EXPOSE 3030
EXPOSE 9010
EXPOSE 9011
EXPOSE 5000

RUN ./pm2 kill
ENTRYPOINT ./pm2 start servers.json
