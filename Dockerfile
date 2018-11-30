FROM openjdk:8-jre

MAINTAINER Brady and Branko <gwen-interpreter@googlegroups.com>

ADD https://oss.sonatype.org/content/repositories/releases/org/gweninterpreter/gwen-web/2.28.1/gwen-web-2.28.1.zip gwen-web.zip 

#==========
# gwen-web
#==========
RUN  mkdir -p /opt/gwen-web \
  && cd /opt/gwen-web \ 
  && wget --no-verbose https://oss.sonatype.org/content/repositories/releases/org/gweninterpreter/gwen-web/2.28.1/gwen-web-2.28.1.zip -O /opt/gwen-web/gwen-web.zip \
  && unzip gwen-web


ADD gwen.properties /opt/gwen-web/
ADD gwen-web /opt/gwen-web/
WORKDIR /opt/gwen-web/gwen-web-2.28.1
ENTRYPOINT ["./gwen"]

#ENTRYPOINT ["/opt/gwen-web/gwen-web-1.0.0-SNAPSHOT/bin/gwen-web"]

#ADD runGwenWeb.sh /opt/gwen-web/

#RUN chmod a+x /opt/gwen-web/runGwenWeb.sh

#============================
#gwen-web update properties
#============================
#RUN echo 'gwen.web.browser=chrome' >> /opt/gwen-web/gwen.properties \
# && echo 'gwen.web.remote.url=http://hub:4444/wd/hub' >> /opt/gwen-web/gwen.properties \
# && echo 'gwen.web.capture.screenshots=true' >> /opt/gwen-web/gwen.properties \
# && echo '#!/bin/bash' > /opt/gwen-web/runMe.sh  \
# && echo 'if [ -f "/tmp/gwen.properties" ]; then export GWEN_PROPERTIES=/tmp/gwen.properties; else export GWEN_PROPERTIES=/opt/gwen-web/gwen.properties; fi' >> /opt/gwen-web/runMe.sh \
# && echo 'gwen-web-1.0.0-SNAPSHOT/bin/gwen-web /features -b -r /reports -p ${GWEN_PROPERTIES} --parallel' >> /opt/gwen-web/runMe.sh \
# && chmod +x /opt/gwen-web/runMe.sh

#========================================
# Add normal user with passwordless sudo
#========================================
#RUN sudo useradd gwen --shell /bin/bash --create-home \
#  && sudo usermod -a -G sudo gwen \
#  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
#  && echo 'gwen:gwen' | chpasswd

