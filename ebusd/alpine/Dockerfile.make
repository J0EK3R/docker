#########################################
##            FLAVOR: TEST             ##
#########################################
#FROM debian:stretch-slim
FROM alpine:latest

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
ENV EBUSD_LOGFILE="/var/log/ebusd.log"

ENV EBUSD_MQTTHOST="mqtt.fritz.box"
ENV EBUSD_MQTTPORT="1883"
ENV EBUSD_MQTTTOPIC="ebusd/%circuit/%name/%field"
ENV EBUSD_MQTTRETAIN="true"

ENV EBUSD_FRONTAILPORT="80"

ENV EBUSD_VERSION="3.1"
ENV EBUSD_ARCH="amd64"

LABEL maintainer="J0EK3R@gmx.net"
LABEL version="${EBUSD_VERSION}-${EBUSD_ARCH}"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
# install required packages

RUN apk add --no-cache \
    argp-standalone \
    curl \
    dpkg \
    gnupg \
    libc6-compat \
    libgcc \
    libstdc++ \
    logrotate \
    mosquitto-libs

RUN apk add --no-cache \
    alpine-sdk \
    autoconf \
    automake \
    build-base \
    g++ \
    git \
    mosquitto-dev \
    make

WORKDIR /build
RUN git clone https://github.com/john30/ebusd.git \
 && cd ebusd \
 && ./autogen.sh \
 && make install-strip

WORKDIR /

RUN rm -rf /build


RUN mkdir /etc/ebusd

# download message definitions from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/john30/ebusd-configuration/archive/master.tar.gz \
    | tar xz --strip-components=3 -C /etc/ebusd ebusd-configuration-master/ebusd-2.1.x/de

# download message definitions for Weishaupt WTC devices from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/J0EK3R/ebusd-configuration-weishaupt/archive/master.tar.gz \
    | tar xz --strip-components=1 -C /etc/ebusd ebusd-configuration-weishaupt-master

# get 
#RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -

# install nodejs package
#RUN apt-get install -y nodejs

# remove ebusd package-file
#RUN rm nodejs

#RUN npm i frontail -g

#########################################
##           CONTAINER START           ##
######################################### 

# copy start-script into container
COPY docker-entrypoint.sh /

# define start-script as entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 
# Export volumes

# expose port for ebusd
EXPOSE 8888
EXPOSE $EBUSD_FRONTAILPORT
