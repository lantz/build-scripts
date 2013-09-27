#!/bin/bash

filter=$1

set -u  # error on undefined var

images=/build/mn-$filter*/*.vmdk
build=~/mininet/util/vm/build.py
# was: --verbose
opts=""
branch=""
#--branch master"

tests=" --test core --test examplesquick --test walkthrough"
#tests="--test sanity"

echo "* Found the following VM images"
echo $images

for image in $images; do
  echo "* Testing $image"
  cmd="$build $opts $branch $tests --image $image"
  echo "- $cmd"
  $cmd
done

echo "* Testing complete"
