#########################################
##            FLAVOR: TEST             ##
#########################################
FROM alpine:latest

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
ENV TERM xterm

LABEL maintainer="J0EK3R@gmx.net"

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

# Install dependencies
RUN apk add --update \
  supervisor \
 && rm -rf /var/cache/apk/*

# configure supervisord
RUN mkdir -p /var/log/supervisor
COPY ./etc/supervisord.conf /etc/supervisord.conf

# sshd on port 22 and allow root login / password = screencast
RUN apk add --update \
  openssh-server \
 && rm -rf /var/cache/apk/*

RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN ssh-keygen -A

#########################################
##         EXPORTS AND VOLUMES         ##
######################################### 

# expose port for ssh-server
EXPOSE 22

#########################################
##                START                ##
######################################### 
CMD ["/usr/bin/supervisord"]
