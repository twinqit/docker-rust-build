FROM rust:1.91.0

ARG TARGETPLATFORM

# Need to install openssl libssl-dev pkg-config to cross-compile Rust code that uses OpenSSL
RUN apt-get update && apt-get install -y musl-tools openssl libssl-dev pkg-config
RUN cargo install --locked cargo-chef cargo-nextest

RUN case "$TARGETPLATFORM" in \
    "linux/amd64")  echo "x86_64-unknown-linux-musl" > /tmp/target ;; \
    "linux/arm64")  echo "aarch64-unknown-linux-musl" > /tmp/target ;; \
    *)              echo "Unsupported platform: $TARGETPLATFORM" && exit 1 ;; \
    esac

RUN rustup target add $(cat /tmp/target)