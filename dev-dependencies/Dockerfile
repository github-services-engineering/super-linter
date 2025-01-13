FROM node:23.6.0-bookworm

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  jq \
  && rm -rf /var/lib/apt/lists/*

ENV APP_DIR=/app
WORKDIR "${APP_DIR}"

COPY package.json package-lock.json ./

RUN npm ci \
  && rm -rf ~/.npm

ENV NODE_PATH="${APP_DIR}/node_modules"
ENV PATH="${NODE_PATH}/.bin:${PATH}"

# Split this from the previous RUN instruction so we can cache the costly installation step
# hadolint ignore=DL3059
RUN release-please --version \
  && git config --global --add safe.directory /source-repository

ARG USERNAME=super-linter-dev
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} -o "${USERNAME}" \
  && useradd -m -u ${UID} -g ${GID} -o -s /bin/bash -l "${USERNAME}"
USER $USERNAME
