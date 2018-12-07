FROM openjdk:8-jre

MAINTAINER Brady and Branko <gwen-interpreter@googlegroups.com>

RUN  mkdir -p /opt/ \
  && mkdir -p /tmp \
  && cd /opt/ \ 
  && wget --no-verbose https://oss.sonatype.org/content/repositories/releases/org/gweninterpreter/gwen-web/2.28.1/gwen-web-2.28.1.zip \
  && unzip *.zip \
  && mv gwen-web-2.28.1 gwen-web

ADD gwen.properties /tmp/
RUN ln -s /tmp/gwen.properties /opt/gwen-web/gwen.properties
WORKDIR /opt/gwen-web
ENTRYPOINT ["./gwen"]
