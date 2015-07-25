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

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get -y -q install software-properties-common htop
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y -q update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y -q install oracle-java8-installer
RUN apt-get -y -q install oracle-java7-installer
RUN update-java-alternatives -s java-8-oracle
RUN apt-get -y --no-install-recommends install
RUN apt-get install -y ca-certificates
RUN apt-get install -y  openjdk-8-jdk 
#RUN apt-get install -y   openjdk-7-jre-headless 
RUN apt-get install -y    unzip
RUN apt-get install -y    wget 
RUN rm -rf /var/lib/apt/lists/* 
RUN sed -i 's/\/dev\/urandom/\/dev\/.\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security


#==========
# gwen-web
#==========
RUN  mkdir -p /opt/gwen-web \
  && cd /opt/gwen-web \ 
  && wget --no-verbose https://oss.sonatype.org/content/repositories/snapshots/org/gweninterpreter/gwen-web_2.11/1.0.0-SNAPSHOT/gwen-web_2.11-1.0.0-SNAPSHOT.zip -O /opt/gwen-web/gwen-web.zip \
  && unzip gwen-web


ADD gwen.properties /opt/gwen-web/
ADD runGwenWeb.sh /opt/gwen-web/

RUN chmod a+x /opt/gwen-web/runGwenWeb.sh

#============================
#gwen-web update properties
#============================
#RUN echo 'gwen.web.browser=chrome' >> /opt/gwen-web/gwen.properties \
# && echo 'gwen.web.remote.url=http://dockergwenweb_hub_1:4444/wd/hub' >> /opt/gwen-web/gwen.properties \
# && echo 'gwen.web.capture.screenshots=true' >> /opt/gwen-web/gwen.properties \
# && echo 'gwen-web-1.0.0-SNAPSHOT/bin/gwen-web /features -b -r /opt/gwen-web/reports -p gwen.properties --parallel' >> /opt/gwen-web/runMe.sh
#
#RUN chmod +x /opt/gwen-web/runMe.sh

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd gwen --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo gwen \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'gwen:gwen' | chpasswd

