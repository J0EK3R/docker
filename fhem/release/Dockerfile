#########################################
##           FLAVOR: RELEASE           ##
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

# sshd on port 22 and allow root login / password = empty
RUN apt-get -y --force-yes install \
   openssh-server \
 && apt-get clean \
 && sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config \
 && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
 && echo "root:empty" | chpasswd \
 && /bin/rm  /etc/ssh/ssh_host_*
# RUN dpkg-reconfigure openssh-server


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

