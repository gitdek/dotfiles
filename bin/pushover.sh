#!/usr/bin/env bash

if [ $# -eq 0 ]; then
	echo "Usage: ./pushover <message> [title]"
	exit
fi

MESSAGE=$1
TITLE=$2

if [ $# -lt 2 ]; then
	TITLE="`whoami`@${HOSTNAME}"
fi


# Required environmental variables:
#  PUSHOVER_APP_TOKEN
#  PUSHOVER_USER_TOKEN

if hash wget; then
	wget https://api.pushover.net/1/messages.json --post-data="token=$PUSHOVER_APP_TOKEN&user=$PUSHOVER_USER_TOKEN&message=$MESSAGE&title=$TITLE" -qO- > /dev/null 2>&1 &
fi

