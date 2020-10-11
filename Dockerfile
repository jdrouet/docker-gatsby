FROM node:lts-buster-slim AS base

RUN apt-get update \
  && apt-get install -y libgl1 libxi6 make python3 \
  && rm -rf /var/lib/apt/lists/*

# disable sending usage telemetry to gatsby
# to avoid having this big message poping at each build
ENV GATSBY_TELEMETRY_DISABLED=1

FROM debian:buster-slim AS fetcher

RUN apt-get update && apt-get install -y zip && rm -rf /var/lib/apt/lists/*

ADD https://github.com/gatsbyjs/gatsby-starter-default/archive/master.zip /gatsby.zip

WORKDIR /code
RUN unzip /gatsby.zip

FROM base AS tester

COPY --from=fetcher /code/gatsby-starter-default-master /code
WORKDIR /code

RUN npm install
RUN npm run build
