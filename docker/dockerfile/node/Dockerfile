# Base OS Use with node.js
FROM node:10

# Install Node.js
RUN \
  apt-get update -y && \
  apt-get install -y \
      rsync

# Upgrade Yarn
RUN \
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

#
EXPOSE 80/tcp
WORKDIR /repo

#
COPY docker-entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
