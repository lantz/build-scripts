#!/bin/bash

# This is the cron job which invokes the nightly build

scripts=/home/mininet/build-scripts
post=$scripts/post-build-result.sh
nightly=$scripts/nightly.sh

$post 'Mininet Nightly Build' $nightly
