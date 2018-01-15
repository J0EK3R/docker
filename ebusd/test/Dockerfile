#########################################
##            FLAVOR: TEST             ##
#########################################
FROM debian:stretch-slim

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables 
ENV EBUSD_ADDRESS="FF"
ENV EBUSD_SCANCONFIG="full"
ENV EBUSD_DEVICE="ebus.fritz.box:5000"
ENV EBUSD_LATENCY="80000"
ENV EBUSD_RECEIVETIMEOUT="25000"
ENV EBUSD_ANSWER="true"
ENV EBUSD_ENABLEHEX="true"
ENV EBUSD_LOGLEVEL="notice"

ENV EBUSD_MQTTHOST="mqtt.fritz.box"
ENV EBUSD_MQTTPORT="1833"
ENV EBUSD_MQTTTOPIC="ebusd/%circuit/%name/%field"
ENV EBUSD_MQTTRETAIN="true"

ENV EBUSD_VERSION="3.1"
ENV EBUSD_ARCH="amd64"

LABEL maintainer="J0EK3R@gmx.net"
LABEL version="${EBUSD_VERSION}-${EBUSD_ARCH}"

# define start-script as entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-f"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
# install required packages
RUN apt-get update \
  && apt-get install -y \
    curl \
    libc6 \
    libgcc1 \
    libmosquitto1 \
    libstdc++6 \
    logrotate \
  && rm -rf /var/lib/apt/lists/*

# get ebusd-package direct from ebusd-project on github
RUN curl -SL https://github.com/john30/ebusd/releases/download/v${EBUSD_VERSION}/ebusd-${EBUSD_VERSION}_${EBUSD_ARCH}-stretch_mqtt1.deb > ebusd.deb

# install ebusd package
RUN dpkg -i ebusd.deb

# remove ebusd package-file
RUN rm ebusd.deb

# download message definitions from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/john30/ebusd-configuration/archive/master.tar.gz \
    | tar xz --strip-components=3 -C /etc/ebusd ebusd-configuration-master/ebusd-2.1.x/de

# download message definitions for Weishaupt WTC devices from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/J0EK3R/ebusd-configuration-weishaupt/archive/master.tar.gz \
    | tar xz --strip-components=1 -C /etc/ebusd ebusd-configuration-weishaupt-master

# copy start-script into container
COPY docker-entrypoint.sh /

#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 
# Export volumes

# expose port for ebusd
EXPOSE 8888
