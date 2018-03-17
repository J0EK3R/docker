#!/bin/bash

# exit immediately if a command exits with a non-zero status
set -e

# default values
MQTTPORT="1883"
MQTTTOPIC="ebusd/%circuit/%field"

# if first parameter starts with "-" then command is missing
# insert "ebusd" at first position as command
if [ "$1" == "" ] ||
   [ "${1#-}" != "$1" ]; then
  set -- ebusd "$@"
fi

# set parameter "-f" to run ebusd in foreground
set -- "$@" "-f"

# if environment variable EBUSD_ADDRESS is set then append parameter
if [ "$EBUSD_ADDRESS" != "" ]; then
  set -- "$@" "-a $EBUSD_ADDRESS"
fi

# if environment variable EBUSD_SCANCONFIG is set then append parameter
if [ "$EBUSD_SCANCONFIG" != "" ]; then
  if [ "$EBUSD_SCANCONFIG" == "default" ]; then
    set -- "$@" "-s"
  else
    set -- "$@" "--scanconfig=$EBUSD_SCANCONFIG"
  fi
fi

# if environment variable EBUSD_DEVICE is set then append parameter
if [ "$EBUSD_DEVICE" != "" ]; then
  set -- "$@" "--device=$EBUSD_DEVICE"
  # set nodevicecheck
  set -- "$@" "-n"
fi

# if environment variable EBUSD_LATENCY is set then append parameter
if [ "$EBUSD_LATENCY" != "" ]; then
  set -- "$@" "--latency=$EBUSD_LATENCY"
fi

# if environment variable EBUSD_RECEIVETIMEOUT is set then append parameter
if [ "$EBUSD_RECEIVETIMEOUT" != "" ]; then
  set -- "$@" "--receivetimeout=$EBUSD_RECEIVETIMEOUT"
fi

# if environment variable EBUSD_ANSWER is set to true then append parameter
if [ "$EBUSD_ANSWER" == "true" ]; then
  set -- "$@" "--answer"
fi

# if environment variable EBUSD_LOGLEVEL is set then append parameter
if [ "$EBUSD_LOGLEVEL" != "" ]; then
  set -- "$@" "--loglevel=$EBUSD_LOGLEVEL"
fi

# if environment variable EBUSD_ENABLEHEX is set to true then append parameter
if [ "$EBUSD_ENABLEHEX" == "true" ]; then
  set -- "$@" "--enablehex"
fi

# if environment variable EBUSD_MQTTHOST is set then append parameter
if [ "$EBUSD_MQTTHOST" != "" ]; then
  # override default values
  # if environment variable EBUSD_MQTTPORT is set then override default value
  if [ "$EBUSD_MQTTPORT" != "" ]; then
    MQTTPORT="$EBUSD_MQTTPORT"
  fi

  # if environment variable EBUSD_MQTTTOPIC is set then override default value
  if [ "$EBUSD_MQTTTOPIC" != "" ]; then
    MQTTTOPIC="$EBUSD_MQTTTOPIC"
  fi

  set -- "$@" "--mqtthost=$EBUSD_MQTTHOST"
  set -- "$@" "--mqttport=$MQTTPORT"
  set -- "$@" "--mqtttopic=$MQTTTOPIC"

  # if environment variable EBUSD_MQTTRETAIN is set to true then append parameter
  if [ "$EBUSD_MQTTRETAIN" == "true" ]; then
    set -- "$@" "--mqttretain"
  fi
fi

# disable updatecheck
set -- "$@" "--updatecheck=off"

# if environment variable EBUSD_LOGFILE is set then tee console output to logfile
if [ "$EBUSD_LOGFILE" != "" ]; then

  FRONTAILCMD="/usr/bin/frontail -p 80 -l 2000 -n 200 --ui-highlight --ui-highlight-preset /etc/frontail/ebusd.json $EBUSD_LOGFILE"
  echo "Starting with frontail: $FRONTAILCMD" |& tee -a $EBUSD_LOGFILE

  $FRONTAILCMD |& tee -a $EBUSD_LOGFILE &

  echo "Starting ebusd with commandline: $@" |& tee -a $EBUSD_LOGFILE

  exec "$@" |& tee -a $EBUSD_LOGFILE
else
  echo "Starting ebusd with commandline: $@"

  exec "$@"
fi
