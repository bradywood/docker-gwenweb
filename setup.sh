#!/bin/bash

RUNCMD=docker run -v `pwd`/universal/stage/features/blogs:/features -v `pwd`/reports:/reports --link dockergwenweb_hub_1:hub --rm=true --workdir="/opt/gwen-web" gwenweb /opt/gwen-web/runGwenWeb.sh

SETUP_DOCKER

# setup where the docker-compose.yml file is.  
# setup an alias or a run command /bin/startGwenWebCompose.sh

