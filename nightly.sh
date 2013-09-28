#!/bin/bash

set -e

# BL note: the actual cron job is another script which
# runs this one and posts its output to Jenkins

echo '* Simple Mininet Nightly Build Script'

date=`date +%Y-%m-%d-%a`
dir=/build/nightly-$date
build=${HOME}/mininet/util/vm/build.py
opts='-z --timeout 1800'
scripts=/home/mininet/build-scripts
post=$scripts/post-build-result.sh
check=$scripts/check-build-dir.sh
mkdir $dir
cd $dir

dists="precise quantal raring saucy"
archs="32 64"

for dist in $dists; do
  for arch in $archs ; do
    target="${dist}${arch}server"
    echo "* Building $target and posting to jenkins"
    $post "mininet-$target" $build $opts $target
    builddir=mn-$target*
    echo "* Checking build log for $builddir"
    echo $check $builddir
  done
done

