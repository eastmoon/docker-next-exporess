# Base OS Use with mongo
# Ref : https://hub.docker.com/_/mongo
FROM mongo

# Install Node.js
ENV NVM_VERSION=10.16.0
RUN \
  apt-get update -y && \
  apt-get install -y \
      curl && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

RUN \
  . ~/.bashrc && \
  nvm install $NVM_VERSION && \
  nvm use $NVM_VERSION && \
  npm install -g yarn

WORKDIR /repo
