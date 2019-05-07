FROM alpine:latest

ADD https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64 /usr/local/bin/stern
RUN chmod 755 /usr/local/bin/stern

CMD ["stern", "'.*'", "--all-namespaces", "--tail", "1" ]

# based on:
# https://hub.docker.com/r/leprechaun/stern/dockerfile
