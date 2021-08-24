#!/usr/bin/env bash

CURR_DIR=$(pwd)

if [ -f ./.env ]; then
	set -a
	. ./.env
	set +a
	docker-compose stop -t0
	docker-compose rm -f
else
	echo "Please create an .env file"
fi
