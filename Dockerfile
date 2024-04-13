# Container image that runs your code
# docker build -t run-me -f ./Dockerfile . --progress=plain
# docker run --rm -it run-me
# docker run --rm -it --env-file <(infisical export --format=dotenv --path='/GITHUB_SAAS' --env=dev | while IFS= read -r line; do eval "echo  $line"; done) run-me rclone copy -P -M --no-check-dest --header "Cache-Control: public,max-age=31536004,immutable" '/cli/package.json' 'r2:/build-artifacts'
FROM node:18.20-alpine3.18

RUN apk update && apk add curl rclone postgresql14-client --no-cache
# RUN curl https://rclone.org/install.sh | sh

COPY ./ /cli

WORKDIR /cli

RUN corepack enable pnpm
RUN pnpm install

# WORKDIR /cli/packages/cli

# COPY entrypoint.sh /entrypoint.sh
# RUN ls -la
# RUN pnpm run run-me
# Copies your code file from your action repository to the filesystem path `/` of the container
# COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
# ENTRYPOINT ["/entrypoint.sh"]