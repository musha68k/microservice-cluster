#!/usr/bin/env sh

# helper functions

log_status() {
  echo ""
  echo "# $1"
  echo ""
}

check_build_status() {
  if [ $? = 1 ]; then
    log_status "Build failed: Environment must be either one of 'development' or 'production'"
    exit 1
  fi
}

run_builds() {
  SERVICE_DIR=$1
  SERVICE=$(basename "$SERVICE_DIR")
  log_status "Creating \"${SERVICE}\" container image"
  cd "$SERVICE_DIR" || exit 2
  ./build.sh
  check_build_status
  cd - >/dev/null
}

# building base container images

for BASE_SERVICE_DIR in services/base/*; do
  run_builds "$BASE_SERVICE_DIR"
done

# build environment specific "application" container images

for APP_SERVICE_DIR in services/app/*; do
  run_builds "$APP_SERVICE_DIR"
done

log_status "Cluster build completed"
