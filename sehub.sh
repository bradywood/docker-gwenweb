# shell function to start mvp one hub, one chrome, one firefox
sehub() {

  local hub=selenium/hub
  local chrome=selenium/node-chrome
  local firefox=selenium/node-firefox

  case "$1" in
    start)
      echo "starting"
      docker run -d --name hub -P $hub
      docker run -d --link hub:hub -P --name chrome $chrome
      docker run -d --link hub:hub -P --name firefox $firefox
      ;;
    pull)
      echo "WARNING: this will pull the latest images from docker hub"
      read -r -p "!!! QUESTION: Are you sure you want to update images? [y/n]" response
      if [[ $response =~ ^(yes|y| ) ]]; then
        docker pull $hub
        docker pull $chrome
        docker pull $firefox
      else
        echo "Update Aborted"
      fi
      ;;
    stop)
      echo "stopping containers"
      docker stop chrome firefox hub
      echo "and removing containers"
      docker rm chrome firefox hub
      ;;
    *)
      echo "Docker Selenium Grid MVP on local machine. Hub and 2 nodes (Chrome and Firefox)"
      echo ""
      echo "Usage: sehub {start|stop|pull}"
      echo ""
      echo "start         starts containers downloaded by last pull operation"
      echo "stop          stops and removes containers so you can start fresh again"
      echo "pull          pull latest defined containers from docker hub"
      ;;
  esac
}
sehub $@
