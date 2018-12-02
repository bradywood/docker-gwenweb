FROM openjdk:8-jre

MAINTAINER Brady and Branko <gwen-interpreter@googlegroups.com>

RUN  mkdir -p /opt/ \
  && cd /opt/ \ 
  && wget --no-verbose https://oss.sonatype.org/content/repositories/releases/org/gweninterpreter/gwen-web/2.28.1/gwen-web-2.28.1.zip \
  && unzip *.zip \
  && mv gwen-web-2.28.1 gwen-web

ADD gwen.properties /opt/gwen-web/
ADD gwen-web /opt/gwen-web/
WORKDIR /opt/gwen-web
ENTRYPOINT ["./gwen"]
