#!/bin/bash

# We don't set -e because some of the commands may
# fail or exit with non-zero return codes.

# BL note: the actual cron job is another script which
# runs this one and posts its output to Jenkins

echo '* Simple Mininet Nightly Build Script'

date=`date +%Y-%m-%d-%a`
builddir=/build
dir=$builddir/nightly-$date
build=${HOME}/mininet/util/vm/build.py
opts='-z --timeout 1800'
scripts=/home/mininet/build-scripts
post=$scripts/post-build-result.sh
check=$scripts/check-build-dir.sh
maxbuilds=4

# If we have a bunch of builds, remove the oldest first
cd $builddir
while [ `ls -td nightly-* | wc -l` -gt $maxbuilds ]; do 
  oldest=`ls -td nightly-* | tail -1`
  echo "* Removing old build directory $oldest"
  sudo rm -rf $oldest
done

# Create new nightly build directory
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
    $post "check-$target" $check $builddir
  done
done

