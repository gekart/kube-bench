FROM golang:1.9
WORKDIR /kube-bench
RUN go get github.com/gekart/kube-bench

FROM alpine:latest
WORKDIR /
COPY --from=0 /go/bin/kube-bench /kube-bench 
COPY --from=0 /go/src/github.com/gekart/kube-bench/cfg /cfg
COPY --from=0 /go/src/github.com/gekart/kube-bench/entrypoint.sh /entrypoint.sh

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="kube-bench" \
    org.label-schema.description="Run the CIS Kubernetes Benchmark tests" \
    org.label-schema.url="https://github.com/gekart/kube-bench" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/gekart/kube-bench" \
    org.label-schema.schema-version="1.0"

CMD sh
