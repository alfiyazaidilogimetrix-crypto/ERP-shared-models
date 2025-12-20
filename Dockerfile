# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:latest AS base
WORKDIR /usr/src/app

# Install OpenSSL in the base image
RUN apt-get update -y && apt-get install -y openssl

# install dependencies into temp directory
# this will cache them and speed up future builds
FROM base AS install
RUN mkdir -p /temp/dev
COPY package.json bun.lock /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile  

# install with --production (exclude devDependencies)
RUN mkdir -p /temp/prod
COPY package.json bun.lock /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

FROM base AS prerelease
COPY --from=install /temp/dev/node_modules node_modules
COPY . .
RUN bun run prisma:build

# copy production dependencies and source code into final image
FROM base AS release
COPY --from=install /temp/prod/node_modules node_modules
COPY --from=prerelease /usr/src/app/prisma/src prisma/src
COPY --from=prerelease /usr/src/app/src/.env .
COPY --from=prerelease /usr/src/app/src/index.ts .
COPY --from=prerelease /usr/src/app/src/package.json .

# run the app
USER bun
ENTRYPOINT [ "bun", "run", "index.ts" ]