# Copyright The Project Template Contributors

FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends --fix-missing -y \
    ca-certificates \
    curl \
    wget \
    git \
    build-essential \
    pkg-config \
    zsh \
    vim \
    less \
    tree \
    htop \
    jq \
    ripgrep \
    fd-find \
    bat \
    unzip \
    sudo \
    locales \
    python3 \
    python3-pip \
    python-is-python3 \
    graphviz \
    nodejs \
    npm \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && ln -sf /usr/bin/batcat /usr/local/bin/bat \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install --no-install-recommends -y gh \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @mermaid-js/mermaid-cli

ENV SHELL=/usr/bin/zsh

WORKDIR /workspace
