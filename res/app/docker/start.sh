#!/bin/bash

#sanity check
for f in /data/gogs/data /data/gogs/conf /data/gogs/log /data/git; do
  if ! test -d $f; then
    mkdir -p $f
  fi
done

chown -R git:git /data

su git -c "./gogs web"
