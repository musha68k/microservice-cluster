#!/usr/bin/env sh

SERVICE_NAME="example-app-service"

docker build -t ${SERVICE_NAME}-build -f Dockerfile.build .

if [ $ENV = "development" ]; then
  docker build -t ${SERVICE_NAME}-development -f Dockerfile.development .
elif [ $ENV = "production" ]; then
  docker build -t ${SERVICE_NAME}-production -f Dockerfile.production .
else
  exit 1
fi
