#!/bin/bash
set -u
set -e
echo "* Checking build results in $1"
egrep -i 'ok|fail' $1/build.log
