FROM ubuntu:14.04

ENV VERSION 2.45.0

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -yq rng-tools haveged && apt-get clean

RUN apt-get update -qqy \
&& apt-get -qqy --no-install-recommends install \
software-properties-common \
&& rm -rf /var/lib/apt/lists/*
RUN add-apt-repository -y ppa:webupd8team/java

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update -qqy \
&& apt-get -qqy --no-install-recommends install \
oracle-java7-installer \
&& rm -rf /var/lib/apt/lists/*

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

# SeleniumHQ/docker-selenium/issues/14
RUN apt-get update -qqy \
  && apt-get -qqy install \
    haveged \
  && service haveged start \
  && update-rc.d haveged defaults

RUN wget http://selenium-release.storage.googleapis.com/${VERSION%.*}/selenium-server-standalone-${VERSION}.jar
