FROM node:10.16.3-alpine

ARG CLOUD_SDK_VERSION=264.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

RUN yarn global add firebase-tools typescript lerna forever && \
    yarn cache clean

ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk --no-cache add \
    curl \
    python \
    py-crcmod \
    bash \
    libc6-compat \
    openssh-client \
    git \
    gnupg \
    gettext \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    gcloud components list

VOLUME ["/root/.config"]