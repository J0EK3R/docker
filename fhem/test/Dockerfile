#########################################
##            FLAVOR: TEST             ##
#########################################
#FROM debian:stretch-slim
#FROM debian:stretch
FROM debian:jessie

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables 
ENV DEBIAN_FRONTEND noninteractive

LABEL maintainer="J0EK3R@gmx.net"

CMD ["/usr/bin/supervisord"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
# install required packages
RUN apt-get update
RUN apt-get install -y \
  wget \
  apt-transport-https

# Install perl packages
RUN apt-get install -y \
  libalgorithm-merge-perl \
  libclass-isa-perl \
  libcommon-sense-perl \
  libdpkg-perl \
  liberror-perl \
  libfile-copy-recursive-perl \
  libfile-fcntllock-perl \
  libio-socket-ip-perl \
  libio-socket-multicast-perl \
  libjson-perl \
  libjson-xs-perl \
  libmail-sendmail-perl \
  libsocket-perl \
  libswitch-perl \
  libsys-hostname-long-perl \
  libterm-readkey-perl \
  libterm-readline-perl-perl \
  libxml-simple-perl \
  libcrypt-pbkdf2-perl \
  libcpan-meta-yaml-perl \
  build-essential

RUN cpan install Net::MQTT:Simple
RUN wget -qO - https://debian.fhem.de/archive.key | apt-key add -
RUN echo "deb https://debian.fhem.de/nightly/ /" | tee -a /etc/apt/sources.list.d/fhem.list

RUN apt-get update \
 && apt-get install -y \
    supervisor \
    fhem \
    telnet \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

RUN echo Europe/Berlin > /etc/timezone && dpkg-reconfigure tzdata

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 
# Export volumes
VOLUME ["/opt/fhem"]

# expose port for fhem
EXPOSE 8083

