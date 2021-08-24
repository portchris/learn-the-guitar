#!/usr/bin/env bash

CURR_DIR=$(pwd)
DOCKER_COMPOSE_FILE="docker-compose.yml"

if [ -f ./.env ]; then
	set -a
	. ./.env
	set +a
	docker-compose -f $DOCKER_COMPOSE_FILE exec --user www app npm $@ --prefix $WEBROOT
else
	echo "Please create an .env file"
fi