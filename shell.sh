#!/usr/bin/env bash

CURR_DIR=$(pwd)
DOCKER_COMPOSE_FILE="docker-compose.yml"

if [ -f ./.env ]; then
	set -a
	. ./.env
	set +a
	read -p "Shell as www user? [Y/y]? " -n 1 -r
	echo # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		docker-compose -f $DOCKER_COMPOSE_FILE exec --user www app bash -c 'cd '"$WEBROOT"'; exec "${SHELL:-sh}"'
	else
		docker-compose -f $DOCKER_COMPOSE_FILE exec app bash -c 'cd '"$WEBROOT"'; exec "${SHELL:-sh}"'
	fi
else
	echo "Please create an .env file"
fi