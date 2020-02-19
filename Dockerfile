FROM node:lts-buster-slim

RUN apt-get update \
  && apt-get install -y libgl1 libxi6 \
  && rm -rf /var/lib/apt/lists/*

# disable sending usage telemetry to gatsby
# to avoid having this big message poping at each build
ENV GATSBY_TELEMETRY_DISABLED=1
