#!/bin/bash
echo "* Checking build results"
egrep -i 'ok|fail' /build/*/build.log
