#!/bin/bash

##################
debug_flag="$1"
if [ "${debug_flag}" == "-d" ]; then
  set -x
  DEBUG_MODE="-d"
  LOG_LEVEL="DEBUG"
  shift 1
fi

set -e
[ -n "${WORKSPACE}" ] || WORKSPACE="$(dirname $(dirname $(realpath $0)))"
source ${WORKSPACE}/lib/log.sh

CURRENT_DIR="$(dirname $0)"
###################

source ${WORKSPACE}/lib/check.sh

main() {
    check_deps

    export WORKSPACE
    docker-compose \
        -f ./deploy/docker-compose.yml \
        --env-file etc/docker-compose.env \
        down || die "停止失败"

    log_info "停止完毕。"
}

main
