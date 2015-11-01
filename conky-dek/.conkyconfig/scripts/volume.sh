#!/bin/bash
amixer get Master | awk -F'[]%[]' '/%/ {if ($5 == "off") { print "Muted";exit } else { print $2"%";exit }}'
