#!/usr/bin/env bash

CURR_DIR=$(pwd)
DOCKER_COMPOSE_FILE="docker-compose.yml"

if [ -f ./.env ]; then
	set -a
	. ./.env
	set +a
	docker-compose -f $DOCKER_COMPOSE_FILE logs --tail 100 -f $@
else
	echo "Please create an .env file"
fi
