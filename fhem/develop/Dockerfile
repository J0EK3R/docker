#########################################
##            FLAVOR: TEST             ##
#########################################
FROM j0ek3r/sshd:latest

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

LABEL maintainer="J0EK3R@gmx.net"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

# Install perl packages
RUN apk add --update \
  dpkg \
  perl \
 && rm -rf /var/cache/apk/*

#  libalgorithm-merge-perl \
#  libclass-isa-perl \
#  libcommon-sense-perl \
#  libdpkg-perl \
#  liberror-perl \
#  libfile-copy-recursive-perl \
#  libfile-fcntllock-perl \
#  libio-socket-ip-perl \
#  libjson-perl \
#  libnet-telnet-perl \
#  libjson-xs-perl \
#  libmail-sendmail-perl \
#  libsocket-perl \
#  libswitch-perl \
#  libsys-hostname-long-perl \
#  libterm-readkey-perl \
#  libterm-readline-perl-perl \
#  libdevice-serialport-perl \
#  libio-socket-ssl-perl \
#  libwww-perl \
#  libcgi-pm-perl \
#  sqlite3 \
#  libdbd-sqlite3-perl \
#  libtext-diff-perl

# configure timezone
#RUN echo Europe/Berlin > /etc/timezone \
# && dpkg-reconfigure tzdata

# configure supervisord
#RUN mkdir -p /var/log/supervisor
#COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install fhem
RUN wget http://fhem.de/fhem-5.8.deb
RUN dpkg -i fhem-5.8.deb
RUN apt-get install -f

#RUN chown fhem /opt/fhem/fhem.cfg

#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 
# Export volumes
VOLUME ["/opt/fhem"]

# expose port for fhem
EXPOSE 8083 8084 8085

#########################################
##                START                ##
######################################### 
CMD ["/usr/bin/supervisord"]
