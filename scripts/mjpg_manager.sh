#!/bin/bash
# Ver 1.0 | 2019.01.26 - eNeu

# Find running streams and kill the processes
if [ "$1" = "-k" ]; then
  RUNNING="$(pidof mjpg_streamer)"
  kill -3 $RUNNING
  echo "Done."
fi

# Start streams by using the stream launcher script
if [ "$1" = "-s" ]; then
  /usr/raiders/mjpg-s_launcher.sh
fi

# Restart (kill old processes and start new processes)
if [ "$1" = "-r" ]; then
  RUNNING="$(pidof mjpg_streamer)"
  kill $RUNNING
  echo "Restarting..."
  /usr/raiders/mjpg-s_launcher.sh
fi

# If no argument is passed, print information about the script
if [ "$1" = "" ]; then
  echo "5561 mjpg_streamer Management Script for Raspberry Pi Camera System
  Options:
    -s   Start camera streams (/usr/raiders/mjpg-s_launcher.sh)
    -k   Kill currently running streams
    -r   Restart camera streams"
fi
