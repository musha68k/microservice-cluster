#!/usr/bin/env sh

SERVICE_NAME="example-app-service"

if [ "$ENV" = "development" ];then
  docker run -it -v .:/app "$SERVICE_NAME" "bundle exec guard"
fi
