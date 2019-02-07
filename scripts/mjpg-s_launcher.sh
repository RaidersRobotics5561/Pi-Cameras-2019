#!/bin/bash
# Version: 2019/01/19   | Ethan Neu

# mjpg_streamer binary location
MJPGS_BIN="/usr/local/bin/mjpg_streamer"
# USB webcam (/dev/videoX devices) input library location
MJPGS_UVC="/usr/local/lib/input_uvc.so"
# HTTP output library location
MJPGS_HTTP="/usr/local/lib/output_http.so"

# Global camera input settings
GLO_IN="-f 24 -r 440x330 -q 15"
# Global camera output settings
GLO_OUT="-w /usr/local/www"

ISCAM0="$(ls /dev/video0)"
if [ "$ISCAM0" = "/dev/video0" ]; then
  # Camera 0
  echo "Detected /dev/video0. Starting camera stream (mjpg_streamer)..."
  ${MJPGS_BIN} -i "${MJPGS_UVC} -d /dev/video0 ${GLO_IN}" -o "${MJPGS_HTTP} ${GLO_OUT} -p 1185" -b
  sleep 2.5
else
  echo "No /dev/video0 detected."
fi

ISCAM1="$(ls /dev/video1)"
if [ "$ISCAM1" = "/dev/video1" ]; then
  # Camera 1
  echo "Detected /dev/video1. Starting camera stream (mjpg_streamer)..."
  ${MJPGS_BIN} -i "${MJPGS_UVC} -d /dev/video1 -f 24 -r 320x240 -q 15" -o "${MJPGS_HTTP} ${GLO_OUT} -p 1186" -b
  sleep 2.5
else
  echo "No /dev/video1 detected."
fi

ISCAM2="$(ls /dev/video2)"
if [ "$ISCAM2" = "/dev/video2" ]; then
  # Camera 2
  echo "Detected /dev/video2. Starting camera stream (mjpeg_streamer)..."
  ${MJPGS_BIN} -i "${MJPGS_UVC} -d /dev/video2 -f 15 -r 320x240 -q 15" -o "${MJPGS_HTTP} ${GLO_OUT} -p 1187" -b
  sleep 2
else
  echo "No /dev/video2 detected."
fi
