#!/bin/bash
set -e

# default values
MQTTPORT="1883"
MQTTTOPIC="ebusd/%circuit/%field"

# if first parameter starts with "-" then command is missing
# insert "ebusd" at first position as command
if [ "${1#-}" != "$1" ]; then
  set -- ebusd "$@"
fi

# if environment variable EBUSD_ADDRESS is set then append parameter
if [ "$EBUSD_ADDRESS" != "" ]; then
  set -- "$@" "--address=$EBUSD_ADDRESS"
fi

# if environment variable EBUSD_SCANCONFIG is set then append parameter
if [ "$EBUSD_SCANCONFIG" != "" ]; then
  if [ "$EBUSD_SCANCONFIG" == "default" ]; then
    set -- "$@" "--scanconfig"
  else
    set -- "$@" "--scanconfig=$EBUSD_SCANCONFIG"
  fi
fi

# if environment variable EBUSD_DEVICE is set then append parameter
if [ "$EBUSD_DEVICE" != "" ]; then
  set -- "$@" "--device=$EBUSD_DEVICE --nodevicecheck"
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
    MQTTPORT=$EBUSD_MQTTPORT
  fi

  # if environment variable EBUSD_MQTTTOPIC is set then override default value
  if [ "$EBUSD_MQTTTOPIC" != "" ]; then
    MQTTTOPIC=$EBUSD_MQTTTOPIC
  fi

  set -- "$@" "--mqtthost=$EBUSD_MQTTHOST --mqttport=$MQTTPORT --mqtttopic=$MQTTTOPIC"

  # if environment variable EBUSD_MQTTRETAIN is set to true then append parameter
  if [ "$EBUSD_MQTTRETAIN" == "true" ]; then
    set -- "$@" "--mqttretain"
  fi
fi

echo "Starting with commandline: $@"

exec "$@"