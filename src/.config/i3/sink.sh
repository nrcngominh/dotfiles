#!/usr/bin/env bash

SINK=$(pactl list short sinks | grep RUNNING | cut -f1)

if [ "$SINK" == "" ]; then
  SINK="0"
fi

echo $SINK
