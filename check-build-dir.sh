#!/bin/bash
set -u
set -e
for dir in $*; do
  echo "* Checking build results in $dir"
  egrep -i 'ok|fail' $dir/build.log || true
done
