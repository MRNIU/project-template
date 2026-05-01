# Copyright The Project Template Contributors

FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PLANTUML_JAR=/opt/plantuml/plantuml.jar \
    CARGO_TERM_COLOR=always \
    PATH=/usr/local/cargo/bin:${PATH}

# System packages:
# - bootstrap/runtime helpers
# - source control and SSH
# - native build and FFI tooling
# - shell, editor, search, JSON, and documentation utilities
# - Python runtime used by pre-commit and helper scripts
# - Node.js and npm from the Ubuntu archive, with npm updated to latest
RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install --no-install-recommends --fix-missing -y \
        ca-certificates \
        curl \
        gnupg \
        sudo \
        unzip \
        wget \
        git \
        git-lfs \
        gh \
        openssh-client \
        build-essential \
        clang \
        cmake \
        lld \
        llvm \
        libclang-dev \
        libssl-dev \
        make \
        ninja-build \
        pkg-config \
        bat \
        fd-find \
        graphviz \
        htop \
        jq \
        less \
        locales \
        default-jre-headless \
        ripgrep \
        tree \
        vim \
        zsh \
        nodejs \
        npm \
        python3 \
        python3-pip \
        python3-venv \
        python-is-python3; \
    ln -sf /usr/bin/fdfind /usr/local/bin/fd; \
    ln -sf /usr/bin/batcat /usr/local/bin/bat; \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen; \
    locale-gen; \
    apt-get autoremove -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    useradd --create-home --user-group --shell /usr/bin/zsh dev; \
    echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev; \
    chmod 0440 /etc/sudoers.d/dev

# Keep pre-commit isolated from system Python packages.
RUN set -eux; \
    python3 -m venv /opt/pre-commit; \
    /opt/pre-commit/bin/pip install --no-cache-dir --upgrade \
        pip \
        pre-commit \
        setuptools \
        wheel; \
    ln -sf /opt/pre-commit/bin/pre-commit /usr/local/bin/pre-commit

# PlantUML's distro package is often much older than upstream, so the template
# installs the latest upstream jar while keeping Java and Graphviz in apt.
RUN set -eux; \
    mkdir -p "$(dirname "${PLANTUML_JAR}")"; \
    curl --proto '=https' --tlsv1.2 -fsSL \
        -o "${PLANTUML_JAR}" \
        https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar; \
    printf '%s\n' \
        '#!/usr/bin/env sh' \
        "exec java -jar ${PLANTUML_JAR} \"\$@\"" \
        > /usr/local/bin/plantuml; \
    chmod 0755 /usr/local/bin/plantuml

# Template-level npm tools used by docs, Dev Container workflows, and upgrades.
RUN set -eux; \
    npm install -g npm@latest; \
    hash -r; \
    npm install -g \
        @devcontainers/cli \
        @mermaid-js/mermaid-cli \
        npm-check-updates

# Rust stable is part of the template baseline because current projects use
# Rust and cargo-based quality gates in the default development workflow.
RUN set -eux; \
    curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs \
        | sh -s -- -y \
        --profile minimal \
        --default-toolchain stable \
        --component clippy,rustfmt,llvm-tools-preview; \
    chmod -R a+w "${RUSTUP_HOME}" "${CARGO_HOME}"

# Cleanup stays separate from install and verification logic.
RUN set -eux; \
    npm cache clean --force; \
    rm -rf /tmp/*

# Version checks stay together so installation steps remain focused on setup.
RUN set -eux; \
    python3 --version; \
    node --version; \
    npm --version; \
    rustc --version; \
    cargo --version; \
    cargo clippy --version; \
    rustfmt --version; \
    gh --version; \
    pre-commit --version; \
    devcontainer --version; \
    mmdc --version; \
    plantuml -version; \
    ncu --version

ENV SHELL=/usr/bin/zsh

WORKDIR /workspace
