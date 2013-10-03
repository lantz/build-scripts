#!/bin/bash

if [ "$1$2" == "" ]; then
  echo "Mininet nightly build tester"
  echo "Usage: $0 <day> <flavor> [<test>...]"
  echo "Valid tests include: sanity core examplesquick examples ..."
  exit 1
fi

set -u  # error on undefined var
set -e  # exit on error

day=$1
flavor=$2
shift
shift

tests=""
for test in $*; do
  tests="$tests --test $test"
done

image=`eval ls /build/*$day*/*$flavor*/*.vmdk`
build=~/mininet/util/vm/build.py
# was: --verbose
opts=""
branch=""
#--branch master"

echo "* Testing $image"
  cmd="$build $opts $branch $tests --image $image"
  echo "- $cmd"
  $cmd

echo "* Done testing $image"
exit 0
