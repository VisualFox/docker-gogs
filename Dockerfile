FROM alpine:3.2
MAINTAINER p@visualfox.me

ENV GOGS_CUSTOM /data/gogs
COPY ./res/app/docker /app/docker
COPY ./res/nsswitch.conf /etc/nsswitch.conf

RUN echo "@community http://dl-4.alpinelinux.org/alpine/edge/community" | tee -a /etc/apk/repositories \
 && export GOPATH=/tmp/go \
 && export PATH=${PATH}:${GOPATH}/bin \
 && apk -U --no-progress upgrade \
 && apk -U --no-progress add bash git curl \
 && /app/docker/build.sh

# Configure Docker Container
WORKDIR /app/gogs/
VOLUME ["/data"]
EXPOSE 3000
ENTRYPOINT ["/app/docker/start.sh"]
