FROM debian:buster-slim AS fetcher

RUN apt-get update && apt-get install -y zip && rm -rf /var/lib/apt/lists/*

ADD https://github.com/gatsbyjs/gatsby-starter-default/archive/master.zip /gatsby.zip

WORKDIR /code
RUN unzip /gatsby.zip

FROM jdrouet/gatsby:local

COPY --from=fetcher /code/gatsby-starter-default-master /code
WORKDIR /code

RUN npm install
RUN npm run build
