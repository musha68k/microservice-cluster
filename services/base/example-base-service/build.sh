#!/usr/bin/env sh

SERVICE_NAME="example-base-service"

docker build -t ${SERVICE_NAME}-build -f Dockerfile.build .
