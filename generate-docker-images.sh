#!/bin/bash

docker login

./update.sh

GHOST_VERSION=`git ls-remote --tags https://github.com/TryGhost/Ghost.git | cut -d$'\t' -f2 | grep -E '^refs/tags/[0-9]+\.[0-9]+' | cut -d/ -f3 | cut -d^ -f1 | sort -ruV | head -1`
echo $GHOST_VERSION

docker build 2/debian/ -t alparaschiv/ghost-node-10.15.0:$GHOST_VERSION
docker build 2/alpine/ -t alparaschiv/ghost-node-10.15.0:$GHOST_VERSION-alpine

docker tag alparaschiv/ghost-node-10.15.0:$GHOST_VERSION alparaschiv/ghost-node-10.15.0:latest

docker push alparaschiv/ghost-node-10.15.0:$GHOST_VERSION-alpine
docker push alparaschiv/ghost-node-10.15.0:$GHOST_VERSION
docker push alparaschiv/ghost-node-10.15.0:latest
