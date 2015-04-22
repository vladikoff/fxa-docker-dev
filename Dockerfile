FROM dockerfile/nodejs

MAINTAINER vladikoff <vlad@vladikoff.com>

RUN adduser --disabled-password --gecos '' fxa && adduser fxa sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN npm install -g npm@2.4 && sh -c "ulimit -n 65535 && exec su $LOGNAME"

USER fxa

# Install fxa-local-dev
RUN cd /home/fxa && git clone https://github.com/vladikoff/fxa-local-dev.git && cd fxa-local-dev

WORKDIR /home/fxa/fxa-local-dev
VOLUME /root/.npm /home/fxa

# Expose ports
EXPOSE 3030
EXPOSE 9010
EXPOSE 9011
EXPOSE 5000
