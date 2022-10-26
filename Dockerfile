ARG ARCH="amd64"
ARG OS="linux"
FROM golang:1.17 AS builder

COPY . /go/src

WORKDIR /go/src

RUN make

FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

ARG ARCH="amd64"
ARG OS="linux"
COPY --from=builder /go/src/pgbouncer_exporter /bin/pgbouncer_exporter
COPY LICENSE                                /LICENSE

USER       nobody
ENTRYPOINT ["/bin/pgbouncer_exporter"]
EXPOSE     9127
