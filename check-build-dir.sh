#!/bin/bash
set -u
set -e
dir=$1
log=$dir/build.log
echo "* Checking build log $log"
egrep -i 'ok' $log
if ! egrep -i 'fail|error' $log ; then
  echo "* Build log check: OK"
  exit 0
else
  echo "* Build log check: FAILED"
  echo "* Dumping log:"
  cat $log
  exit 1
fi
