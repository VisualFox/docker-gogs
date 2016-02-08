#!/bin/sh
set -x
set -e

# Install build deps
apk -U --no-progress add go@community

# Set temp environment vars
export GOPATH=/tmp/go
export PATH=${PATH}:${GOPATH}/bin

# build Gogs
go get -u github.com/gogits/gogs
cd ${GOPATH}/src/github.com/gogits/gogs
go build

# Create git user for Gogs
adduser -H -D -g 'Gogs Git User' git -h /data/git -s /bin/bash && passwd -u git
echo "export GOGS_CUSTOM=${GOGS_CUSTOM}" >> /etc/profile

# move gogs to /app
mv $GOPATH/src/github.com/gogits/gogs /app/

# folder and permission
ln -s /data/gogs/data /app/data && chown -h git:git /app/gogs/data
ln -s /data/gogs/log /app/log && chown -h git:git /app/gogs/log

# Remove build deps
apk --no-progress del go

# Cleanup GOPATH
rm -r $GOPATH
