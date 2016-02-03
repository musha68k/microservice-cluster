  #!/usr/bin/env sh

# helper functions

log_status() {
  echo ""
  echo "---------------------------------------"
  echo "# Creating $1 container image"
  echo "---------------------------------------"
  echo ""
}

# building base container images

for BASE_SERVICE_DIR in {services/base/*}; do
  BASE_SERVICE=(basename "$BASE_SERVICE_DIR")

  log_status "$BASE_SERVICE"
  docker build -t "${BASE_SERVICE}-build" "$BASE_SERVICE_DIR"

done

# build environment specific "application" container images

for APP_SERVICE_DIR in {services/app/*}; do
  APP_SERVICE=(basename "$APP_SERVICE_DIR")

  log_status "$APP_SERVICE"
  docker build -t "{$APP_SERVICE}-build" -f Dockerfile "$APP_SERVICE_DIR"

  if [ "$ENV" = "development" ]; then
    docker build -t "{$APP_SERVICE}-development" -f Dockerfile.development "$APP_SERVICE_DIR"
  elif [ "$ENV" = "production" ]; then
    docker build -t "${APP_SERVICE}-production" -f Dockerfile.production "$APP_SERVICE_DIR"

  else
    echo "Environment must be either one of 'development' or 'production'."
    break

  fi

done
