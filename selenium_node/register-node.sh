#!/bin/bash
Xvfb :10 -screen 5 2000x2000x16 -ac &
export DISPLAY=:10.5
export HOST_IP=$(ip addr show dev eth0 | grep "inet " | awk '{print $2}' | cut -d '/' -f 1)
[[ $HUB_1_PORT_4444_TCP_ADDR ]] || SELENIUM_1_PORT_4444_TCP_ADDR=$GRID_IP
java -jar selenium-server-standalone-${VERSION}.jar -role webdriver -host ${HOST_IP} -hub http://${HUB_1_PORT_4444_TCP_ADDR}:4444/grid/register -browser browserName=firefox

