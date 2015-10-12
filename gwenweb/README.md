#How to run

./runGwenWeb.sh ~/gwen-web/features/ reports

##Optional Parameters
BROWSER_TYPE=${BROWSER_TYPE:-chrome}
BROWSER_COUNT=${BROWSER_COUNT:-3}
DEBUG=${DEBUG:-false}

##Connect via VNC if running debug
If on mac, use the $DOCKER_HOST variable for the ip address.  Connect using safari 
  vnc://192.168.1.1:<debug port>
  secret is the selenium vnc password
