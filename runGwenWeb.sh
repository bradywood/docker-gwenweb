#!/bin/bash -x
#
# This bash script is to allow a user to run gwen from anywhere passing in
# both a feature directory and report directory.
# It will attempt to run the features against the running docker-compose selenium
# grid.  It is making an assumption that the management of the docker-compose  
# environment up to the user to start and scale appropriately.

# Args: feature directory
#       report directory

DOCKER_GWENWEB_NAME=dockergwenweb

PID=$$

if [ "$#" -eq 2 ]
then
  docker pull selenoid/vnc:firefox_57.0

  DOCKER_CMD="docker"
  #GWEN_IMAGE=gwen/gwenweb
  GWEN_IMAGE=gwen-web

  export FEATURE_DIRECTORY=$1
  export REPORTS_DIRECTORY=$2

  mkdir -p $REPORTS_DIRECTORY;
  export ABSOLUTE_REPORTS_PATH=$(cd `dirname "$REPORTS_DIRECTORY"` && pwd)/`basename "$REPORTS_DIRECTORY"`

  ${DOCKER_CMD} run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -v `pwd`/gwen.properties:/opt/gwen-web/gwen.properties -v `pwd`:/tmp -v $FEATURE_DIRECTORY:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link selenoid:selenoid gwen-web /features/ -p /opt/gwen-web/gwen.properties

else
  echo "To run gwenweb, please run as follows: "
  echo "runGwenWeb.sh <feature directory> <report directory>"
fi

