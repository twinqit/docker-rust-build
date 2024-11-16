FROM --platform=$BUILDPLATFORM rust:1.82

WORKDIR /app

ENV PKGCONFIG_SYSROOTDIR=/

RUN apt-get update && apt-get install -y musl-tools
RUN cargo install --locked cargo-chef
RUN rustup target add x86_64-unknown-linux-musl aarch64-unknown-linux-musl