#!/bin/bash

set -e

echo '* Simple Mininet VM build script'

build=${HOME}/mininet/util/vm/build.py
opts='-v -z --timeout 1800'

# precise quantal raring saucy
# 32 64

for dist in saucy; do
    for arch in 32; do
    target="${dist}${arch}server"
    echo "* Building $target"
    $build $opts $target || true
  done
done


