FROM selenium/base

ENV FIREFOX_MINOR 34.0.5

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

RUN apt-get update -qqy \
&& apt-get -qqy --no-install-recommends install \
firefox \
bzip2 \
&& rm -rf /var/lib/apt/lists/*

#==============
# VNC and Xvfb
#==============
RUN apt-get update -qqy \
  && apt-get -qqy install \
    x11vnc \
    x11-apps \
    xvfb \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ~/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd

RUN [ -e /usr/bin/firefox ] && rm /usr/bin/firefox
ADD https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FIREFOX_MINOR}/linux-x86_64/en-US/firefox-${FIREFOX_MINOR}.tar.bz2 /tmp/
RUN apt-get install -q -y libdbus-glib-1-2
RUN tar -xvjf /tmp/firefox-${FIREFOX_MINOR}.tar.bz2 -C /opt/
RUN chmod -R +x /opt/firefox/
RUN ln -s /opt/firefox/firefox /usr/bin/firefox

ADD register-node.sh /var/register-node.sh
RUN chmod 755 /var/register-node.sh

EXPOSE 5555

CMD ["/bin/bash", "/var/register-node.sh"]
