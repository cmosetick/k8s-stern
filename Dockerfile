# quay.io/cmosetick/k8s-stern:latest
# quay.io/cmosetick/k8s-stern:v1.10

# sops build
# https://github.com/mozilla/sops
FROM golang:1.12
RUN go get go.mozilla.org/sops/cmd/sops
RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-static"' go.mozilla.org/sops/cmd/sops


FROM alpine:latest

ADD https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64 /usr/local/bin/stern

FROM alpine:latest
WORKDIR /root
COPY --from=0 /go/bin/sops /usr/local/bin/sops
COPY --from=1 /usr/local/bin/stern /usr/local/bin/stern

RUN \
apk add --no-cache --update ca-certificates && \
chmod +x /usr/local/bin/sops && \
chmod +x /usr/local/bin/stern && \
mkdir /root/.kube

CMD ["stern", "'.*'", "--all-namespaces", "--tail", "1" ]

# originally based on:
# https://github.com/cmosetick/k8s-kubectl/blob/master/Dockerfile
# https://hub.docker.com/r/leprechaun/stern/dockerfile
