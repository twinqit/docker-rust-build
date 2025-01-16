FROM rust:1.84

ARG TARGETPLATFORM

RUN apt-get update && apt-get install -y musl-tools
RUN cargo install --locked cargo-chef cargo-nextest

RUN case "$TARGETPLATFORM" in \
    "linux/amd64")  echo "x86_64-unknown-linux-musl" > /tmp/target ;; \
    "linux/arm64")  echo "aarch64-unknown-linux-musl" > /tmp/target ;; \
    *)              echo "Unsupported platform: $TARGETPLATFORM" && exit 1 ;; \
    esac

RUN rustup target add $(cat /tmp/target)