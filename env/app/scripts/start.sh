#!/bin/bash

# NPM setup
if [ ! -d $WEBROOT/.npm ]; then
	mkdir -p $WEBROOT/.npm
fi
if [ ! -d $WEBROOT/.config ]; then
	mkdir -p $WEBROOT/.config
fi
if [ -d $WEBROOT/node_modules ]; then
	chmod -R 755 $WEBROOT/node_modules
fi
chown -R ${USERNAME}:${USERNAME} $HOMEDIR
chown -R ${USERNAME}:${USERNAME} $WEBROOT/.npm
chown -R ${USERNAME}:${USERNAME} $WEBROOT/.config

# Start CRON service
# service cron start