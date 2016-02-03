#!/usr/bin/env sh

if [ "$ENV" = "development" ];then
  bundle exec guard
fi
