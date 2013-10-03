#!/bin/bash

# This is the cron job which invokes the nightly build

scripts=/home/mininet/build-scripts
post=$scripts/post-build-result.sh
nightly=$scripts/nightly.sh

# We log to a separate file to avoid Jenkins timeouts

date=`date +%Y-%m-%d-%a`
log=/tmp/mininet-build-$date.log

echo "* Logging to $log"
  $nightly >& $log

echo "* Posting to Jenkins"
  $post 'Mininet Nightly Build' cat $log
