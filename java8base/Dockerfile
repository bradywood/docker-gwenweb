FROM ubuntu:14.04
MAINTAINER Brady and Branko <gwen-interpreter@googlegroups.com>

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
#RUN apt-get update -qqy \
#  && apt-get -qqy --no-install-recommends install \
#    ca-certificates \
#    openjdk-7-jre-headless \
#    unzip \
#    wget \
#  && rm -rf /var/lib/apt/lists/* \
#  && sed -i 's/\/dev\/urandom/\/dev\/.\/urandom/' ./usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

RUN apt-get update -qqy \
  && apt-get upgrade -y \
  && apt-get -y -q install software-properties-common htop \
  && apt-get -y -q update \
  && apt-get -y --no-install-recommends install \
  && apt-get install -y ca-certificates \
  && apt-get install -y    unzip \
  && apt-get install -y    wget  \
  && rm -rf /var/lib/apt/lists/* 

RUN mkdir /opt/jdk \
  && cd /opt \
  && wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz \
  && tar -zxf jdk-8u5-linux-x64.tar.gz -C /opt/jdk \
  && update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_05/bin/java 100 \
  && update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_05/bin/javac 100

