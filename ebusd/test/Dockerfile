# flavor: test
FROM debian:stretch-slim

# install required packages
RUN apt-get update && apt-get install -y \
    logrotate libmosquitto1 libstdc++6 libc6 libgcc1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

LABEL maintainer "J0EK3R@gmx.net"

ENV EBUSD_VERSION 3.1
ENV EBUSD_ARCH amd64

LABEL version "${EBUSD_VERSION}-${EBUSD_ARCH}"

# get ebusd-package direct from github project
RUN curl -SL https://github.com/john30/ebusd/releases/download/v${EBUSD_VERSION}/ebusd-${EBUSD_VERSION}_${EBUSD_ARCH}-stretch_mqtt1.deb > ebusd.deb

# install ebusd package
RUN dpkg -i ebusd.deb

# remove ebusd package
RUN rm ebusd.deb

# download message definitions from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/john30/ebusd-configuration/archive/master.tar.gz \
    | tar xz --strip-components=3 -C /etc/ebusd ebusd-configuration-master/ebusd-2.1.x/de

# download message definitions for Weishaupt WTC devices from github and expand them to /etc/ebusd
RUN curl -SL https://github.com/J0EK3R/ebusd-configuration-weishaupt/archive/master.tar.gz \
    | tar xz --strip-components=1 -C /etc/ebusd ebusd-configuration-weishaupt-master

# expose port for ebusd
EXPOSE 8888

# copy start-script into container
COPY docker-entrypoint.sh /

# define start-script as entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

#
CMD ["-f", "--scanconfig"]
