# Container image that runs your code
# docker build -t run-me -f ./Dockerfile . --progress=plain
# docker run --rm -it run-me
FROM node:18.20-alpine3.18


COPY ./ /cli

WORKDIR /cli

RUN corepack enable pnpm
RUN pnpm install
RUN sleep 30


WORKDIR /cli/packages/cli

COPY entrypoint.sh /entrypoint.sh
# RUN ls -la
# RUN pnpm run run-me
# Copies your code file from your action repository to the filesystem path `/` of the container
# COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]