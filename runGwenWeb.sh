#!/bin/bash -x
#
# This bash script is to allow a user to run gwen from anywhere passing in
# both a feature directory and report directory.
# It will attempt to run the features against the running docker-compose selenium
# grid.  It is making an assumption that the management of the docker-compose  
# environment up to the user to start and scale appropriately.

# Args: feature directory
#       report directory

HOST_USER_ID=`id -u`
HOST_GROUP_ID=`id -g`
BROWSER_TYPE=${BROWSER_TYPE:-chrome}
BROWSER_COUNT=${BROWSER_COUNT:-3}
DEBUG=${DEBUG:-false}
DOCKER_GWENWEB_NAME=dockergwenweb

PID=$$

if [ "$#" -eq 2 ]
then
  DOCKER_CMD="docker"
  GWEN_IMAGE=gwen/gwenweb

  export FEATURE_DIRECTORY=$1
  export REPORTS_DIRECTORY=$2

  mkdir -p $REPORTS_DIRECTORY;
  echo $REPORTS_DIRECTORY
  export ABSOLUTE_REPORTS_PATH=$(cd `dirname "$REPORTS_DIRECTORY"` && pwd)/`basename "$REPORTS_DIRECTORY"`
  export ABSOLUTE_FEATURE_PATH=$(cd `dirname "$FEATURE_DIRECTORY"` && pwd)/`basename "$FEATURE_DIRECTORY"`

  echo $ABSOLUTE_REPORTS_PATH


  ${DOCKER_CMD} run -d -P --name ${DOCKER_GWENWEB_NAME}_hub_1 hvdb/docker-selenium-hub


  if [ "$DEBUG" == true ]
  then
    DEBUG="-debug"
  else
    DEBUG=""
  fi

  #start the browsers
  for INSTANCE in $(eval echo "{0..$((BROWSER_COUNT - 1))}")
  do
    echo "starting ${BROWSER_TYPE}{DEBUG} as instance: $INSTANCE"
    
    ${DOCKER_CMD} run -d -P -p 5555 --name ${DOCKER_GWENWEB_NAME}_${BROWSER_TYPE}_${INSTANCE} --link ${DOCKER_GWENWEB_NAME}_hub_1:hub selenium/node-${BROWSER_TYPE}${DEBUG}
  done

  #${DOCKER_CMD} run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -u ${HOST_USER_ID}:${HOST_GROUP_ID} -v `pwd`:/tmp -v $FEATURE_DIRECTORY:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link ${DOCKER_GWENWEB_NAME}_hub_1:hub --workdir='/opt/gwen-web' $GWEN_IMAGE /bin/bash runMe.sh
  #${DOCKER_CMD} run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -u ${HOST_USER_ID}:${HOST_GROUP_ID} -v `pwd`:/tmp -v $FEATURE_DIRECTORY:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link ${DOCKER_GWENWEB_NAME}_hub_1:hub gwen/gwenweb "-m /features/*.meta -p /opt/gwen-web/gwen.properties"
  #${DOCKER_CMD} run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -v `pwd`/gwen.properties:/opt/gwen-web/gwen.properties -v `pwd`:/tmp -v $ABSOLUTE_FEATURE_PATH:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link dockergwenweb_hub_1:hub gwen/gwenweb "-m /features/*.meta -p /opt/gwen-web/gwen.properties"
  ${DOCKER_CMD} run -it --rm --name ${DOCKER_GWENWEB_NAME}_instance_${PID} -v `pwd`/gwen.properties:/opt/gwen-web/gwen.properties -v `pwd`:/tmp -v $ABSOLUTE_FEATURE_PATH:/features -v $ABSOLUTE_REPORTS_PATH:/reports --link dockergwenweb_hub_1:hub gwen/gwenweb "-p /opt/gwen-web/gwen.properties -b /features/ "


  #docker run -it --name test2 --rm -v `pwd`:/tmp -v `pwd`/../../gwen-web/features/jkvine/:/meta -v `pwd`/gwenreports:/reports --link dockergwenweb_hub_1:hub gwen/gwenweb "-m /meta/jkvine.meta -p /opt/gwen-web/gwen.properties"

  #sleep 10

  #PROCESSES=$(docker ps | grep ${DOCKER_GWENWEB_NAME}_ | awk 'FS=" " {printf("%s ",$1)}')
  #docker kill ${PROCESSES}
  #docker rm -f ${PROCESSES}

else
  echo "To run gwenweb, please run as follows: "
  echo "runGwenWeb.sh <feature directory> <report directory>"
fi

