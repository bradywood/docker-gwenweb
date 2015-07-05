
# Running gwenweb against preconfigured selenium grid

The gwenweb docker file and docker-compose, allows someone wanting to run gwenweb the ability to run it against a preconfigured selenium grid.  The advantage of docker, is speed and ease of use, however it also removes the requirement for gwenweb to be tightly coupled to a version.  

Running gwenweb this way will also allow the browser to test in the background whilst you continue to do your work.  In effect its a browser that is being displayed in a [Virtual Frame Buffer](https://en.wikipedia.org/wiki/Xvfb)

The following instructions will walk you through running gwenweb on a preconfigured selenium grid

1. download and install docker and docker-compose [Docker](http://docs.docker.com/installation/) [Docker Compose](https://docs.docker.com/compose/install/)
2. run the next statement to pull down selenium grid and chrome version 2:45 
```
docker-compose build
```
3. run the next statement to start compose
```
docker-compose up -d
```
4. run the next statement to scale chrome up to 4 browsers.
```
docker-compose scale chrome=4
```
5. you will probably want to see whats going on, so run
```
docker-compose logs
```
6. In a new terminal window, run the next statement pointing to any feature directory, and a location of where you want reports to be created.  It will create the directory if it hasn't been already created.
```
runGwenWeb.sh <feature directory> <report directory>
```


## What have you done?
That's it! You have now downloaded a preconfigured selenium grid, scaled chrome to run 4 browsers and ran gwenweb testing using features stored on your computer.  The reports are written to a location of your choosing, before the virtual machine is removed from your machine.  Actually running gwenweb like this means you can run multiple features from anywhere on your computer and all at the same time.  The only thing you need to be aware of is matching the number of browsers against the number of testing activities.  

## What if I want to change versions of the grid
Well this is also pretty simple.  Inside the docker-compose.yml file there is a version, feel free to change this to any version that is currently available.
