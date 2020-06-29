FROM rustlang/rust:nightly-buster-slim AS build

RUN apt-get update
RUN apt-get install -y build-essential clang

RUN cargo install sonic-server
RUN strip /usr/local/cargo/bin/sonic

FROM debian:buster-slim

WORKDIR /usr/src/sonic

COPY --from=build /usr/local/cargo/bin/sonic /usr/local/bin/sonic

CMD [ "sonic", "-c", "/etc/sonic.cfg" ]

EXPOSE 1491
