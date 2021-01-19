#!/usr/bin/env bash
if hash figlet && hash lolcat; then
	figlet -f lean | tr ' _/' '/  ' | lolcat -s 90 -f -d 1 -F 0.9
fi
