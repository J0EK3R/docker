#########################################
##            FLAVOR: TEST             ##
#########################################
#FROM debian:latest
#FROM debian:jessie
FROM debian:stretch-slim

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
ENV DEBIAN_FRONTEND noninteractive 
ENV TERM xterm

LABEL maintainer="J0EK3R@gmx.net"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

# Install dependencies
RUN apt-get update

RUN apt-get -y --force-yes install \
  supervisor \
  telnet \
  wget \
  curl \
  vim \
  git \
  nano \
  make \
  gcc \
  g++ \
  apt-transport-https \
  sudo

# Install perl packages
RUN apt-get -y --force-yes install \
  libalgorithm-merge-perl \
  libclass-isa-perl \
  libcommon-sense-perl \
  libdpkg-perl \
  liberror-perl \
  libfile-copy-recursive-perl \
  libfile-fcntllock-perl \
  libio-socket-ip-perl \
  libjson-perl \
  libnet-telnet-perl \
  libjson-xs-perl \
  libmail-sendmail-perl \
  libsocket-perl \
  libswitch-perl \
  libsys-hostname-long-perl \
  libterm-readkey-perl \
  libterm-readline-perl-perl \
  libdevice-serialport-perl \
  libio-socket-ssl-perl \
  libwww-perl \
  libcgi-pm-perl \
  sqlite3 \
  libdbd-sqlite3-perl \
  libtext-diff-perl

# configure timezone
RUN echo Europe/Berlin > /etc/timezone \
 && dpkg-reconfigure tzdata

# configure supervisord
RUN mkdir -p /var/log/supervisor
COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install fhem
RUN wget http://fhem.de/fhem-5.8.deb
RUN dpkg -i fhem-5.8.deb
RUN apt-get install -f

RUN chown fhem /opt/fhem/fhem.cfg

# sshd on port 22 and allow root login / password = screencast

RUN apt-get update \
 && apt-get install -y \
  openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 
# Export volumes
VOLUME ["/opt/fhem"]

# expose port for fhem
EXPOSE 8083 8084 8085

# expose port for ssh-server
EXPOSE 22

#########################################
##                START                ##
######################################### 
CMD ["/usr/bin/supervisord"]
