#!/bin/bash -x
#
# This bash script is to allow a user to run gwen from anywhere passing in
# both a feature directory and report directory.

# Args: feature directory
#       report directory

GWEN_IMAGE=gwen/gwenweb
DOCKER_GWENWEB_NAME=dockergwenweb

PID=$$

pullDownImages () {
  docker pull gwen/gwenweb
  docker pull aerokube/selenoid:latest-release 
  docker pull selenoid/vnc:firefox_57.0
}

startSelenoidImage () {
  docker run -d                                   \
  --name selenoid                                 \
  -p 4444:4444                                    \
  -v /var/run/docker.sock:/var/run/docker.sock    \
  -v `pwd`/config/:/etc/selenoid/:ro              \
  aerokube/selenoid:latest-release
}

checkSelenoid () {
  selenoidDockerLine=$(docker ps -f name=selenoid)
}

startSelenoid () {
  SELENOID_RUNNING=$(checkSelenoid || echo "SomeErrorString")
  if [ $DOWNLOADED_ARTIFACT == "SomeErrorString" ]; then
    startSelenoidImage
  fi 
}

runGwen () {
  if [ "$#" -eq 2 ]
  then
    export FEATURE_DIRECTORY=$1
    export REPORTS_DIRECTORY=$2

    mkdir -p $REPORTS_DIRECTORY;
    export ABSOLUTE_REPORTS_PATH=$(cd `dirname "$REPORTS_DIRECTORY"` && pwd)/`basename "$REPORTS_DIRECTORY"`

    docker run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -v `pwd`/gwen.properties:/opt/gwen-web/gwen.properties -v $FEATURE_DIRECTORY:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link selenoid:selenoid gwen/gwenweb /features/ -p /opt/gwen-web/gwen.properties
  
  else
    echo "Running Demo Mode"
    mkdir -p reports
    docker run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -v `pwd`/reports:/reports --link selenoid:selenoid gwen/gwenweb /opt/gwen-web/features/google/ -p /opt/gwen-web/gwen.properties --parallel -b
  fi
}

startSelenoid
runGwen $1 $2 
