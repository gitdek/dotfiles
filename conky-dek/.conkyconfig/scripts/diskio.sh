#!/bin/bash
iostat -d -y 1 1 | awk '/sda/ {print $3+$4}'
