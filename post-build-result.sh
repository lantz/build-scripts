#!/bin/bash

# Break on error or undefined variables
set -e -u

# Script to post a build result to Jenkins
#
# Bob Lantz, September 2013

if [ "$#" -lt 2 ]; then
  echo "$0: run build commands and post results to Jenkins"
  echo "Usage: $0 build-name build-cmd [args...]"
  exit 1
fi

BUILD=$1
shift
CMD=$*

echo "* Build name: $BUILD"
echo "* Build command: $CMD"

# Jenkins user, password, and server URL
JDIR=/home/mininet/.jenkins
JUSER=`cat $JDIR/build-user`
JPWD=`cat $JDIR/build-passwd`
JENKINS=localhost:8080
export JENKINS_HOME=http://$JUSER:$JPWD@$JENKINS/

# Java home and certificates so that we can connect using SSL
export JAVA_HOME=/usr/lib/jvm/default-java/
export JAVA=$JAVA_HOME/bin/java
# CERT=-Djavax.net.ssl.trustStore=$JAVA_HOME/jre/lib/security/cacerts
# PWD=-Djavax.net.ssl.trustStorePassword=changeit
# export JAVA_OPTS="$CERT $PWD"

# Command to post build results to jenkins
export MONITOR=/usr/share/jenkins/external-job-monitor/java/jenkins-core-*.jar

echo "* Starting Jenkins job $BUILD: $CMD"
  $JAVA -jar $MONITOR "$BUILD" $CMD

echo "* Done"
exit 0
