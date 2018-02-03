This Dockerfile builds an Alpine-bases image for ebusd including the Weishaupt message-definitions.                                                         

https://hub.docker.com/r/j0ek3r/ebusd/

The image is a multistage build:
* first stage builds the ebusd binaries
* second stage the  resulting image.

The Dockerfile contains some environment variables defined for my personal requirements.
The variables correspond to the start-parameters of ebusd.

Feel free to adjust them to your own needs...

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
