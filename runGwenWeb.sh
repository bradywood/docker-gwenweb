#!/bin/bash -x
#
# This bash script is to allow a user to run gwen from anywhere passing in
# both a feature directory and report directory.
# It will attempt to run the features against the running docker-compose selenium
# grid.  It is making an assumption that the management of the docker-compose  
# environment up to the user to start and scale appropriately.

# Args: feature directory
#       report directory

DOCKER_CMD="docker"
if [ $# -eq 2 ]
then

  export FEATURE_DIRECTORY=$1
  export REPORTS_DIRECTORY=$2

  mkdir -p $REPORTS_DIRECTORY;
  echo $REPORTS_DIRECTORY
  export ABSOLUTE_REPORTS_PATH=$(cd `dirname "$REPORTS_DIRECTORY"` && pwd)/`basename "$REPORTS_DIRECTORY"`

  echo $ABSOLUTE_REPORTS_PATH


  ${DOCKER_CMD} run -v $FEATURE_DIRECTORY:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link dockergwenweb_hub_1:hub --rm=true --workdir='/opt/gwen-web' gwenweb /opt/gwen-web/runGwenWeb.sh

else
  echo "To run gwenweb, please run as follows: "
  echo "runGwenWeb.sh <feature directory> <report directory>"
fi

