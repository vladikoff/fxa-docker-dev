FROM vladikoff/fxa-slim-image:latest

MAINTAINER vladikoff <vlad@vladikoff.com>

RUN adduser --disabled-password --gecos '' fxa && adduser fxa sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER fxa

RUN cd /home/fxa && git clone https://github.com/mozilla/fxa-content-server.git && cd fxa-content-server && npm i --production && cp server/config/local.json-dist server/config/local.json
RUN cd /home/fxa && git clone https://github.com/mozilla/fxa-auth-server.git && cd fxa-auth-server && npm i && node ./scripts/gen_keys.js
RUN npm cache clear

VOLUME /home/fxa

WORKDIR /home/fxa/fxa-content-server
CMD npm start

# Expose ports
EXPOSE 3030
EXPOSE 9010
EXPOSE 9011
