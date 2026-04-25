# Stage 1: Build stage

FROM node:22.22-bookworm@sha256:9059d9d7db987b86299e052ff6630cd95e5a770336967c21110e53289a877433 AS builder
WORKDIR /usr/src/
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ python-is-python3 \
    libx11-dev libxkbfile-dev libsecret-1-dev libkrb5-dev \
    git git-lfs quilt \
    rsync jq gnupg \
    libgcc1 \
    && rm -rf /var/lib/apt/lists/*
RUN git clone --recursive --depth 1 --branch v4.112.0 https://github.com/coder/code-server.git code-server
WORKDIR /usr/src/code-server
RUN git submodule update --init
RUN quilt push -a
RUN npm install
RUN npm run build
RUN VERSION=4.112.0 npm run build:vscode
RUN KEEP_MODULES=1 npm run release
RUN npm run release:standalone

# Stage 2: Run Build stage

FROM ubuntu:24.04@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b
WORKDIR /app
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN useradd -m coder
COPY --from=builder --chown=coder:coder /usr/src/code-server/release-standalone/ ./
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/healthz || exit 1
USER coder
EXPOSE 8080

ENTRYPOINT ["/app/lib/node", "out/node/entry.js"]
CMD ["--bind-addr", "0.0.0.0:8080", "--auth", "none"]