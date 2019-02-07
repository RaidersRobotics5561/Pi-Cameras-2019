#!/bin/bash

# This script is intended to make launching mjpg_streamer streams easier to launch with configurable options
# Ver 1.5.1  |  2019.02.06 - eNeu


# == PRE-DEFINED VARS ==

# BIN/LIB Locations
BIN_MJPG="/usr/local/bin/mjpg_streamer"     # Location of mjpg_streamer binary
LIB_CAMIN="/usr/local/lib/input_uvc.so"     # Location of stream input library (Current: UVC. Gets streams from USB camera)
LIB_CAMOUT="/usr/local/lib/output_http.so"  # Location of stream output library (Current: HTTP. Sends stream to web server)
OUT_WEB_FILES_PATH="/usr/local/www"         # Location of mjpg_streamer's web files for http output

# Static options for INPUT
DEF_RES="440x330"                           # Stream resolution
DEF_FPS="24"                                # Stream frame rate
DEF_QUAL="15"                               # Stream quality (compression percentage)
DEF_DEV="/dev/video0"                       # Input device. In this case, the USB camera to pull images from

# Static options for OUTPUT
DEF_PORT="1185"                             # Port to send the stream on / where to access it from



# == USER DEFINED VARS ==
# Prints default values
echo ""
echo "DEFAULTS:   FPS:     ${DEF_FPS}  |  Resolution: ${DEF_RES}"
echo "            Quality: ${DEF_QUAL}  |  Port:       ${DEF_PORT}"
echo "            Device:  ${DEF_DEV}"
echo ""
echo "Defaults can be changed by modifying this script."
echo ""
echo "Press enter to use defaults"

# Asks user for their input
printf "Resolution [WIDTHxHEIGHT]                 > "; read IN_RES
printf "Frame rate [FPS]                          > "; read IN_FPS
printf "Quality [Percent as integer]              > "; read IN_QUAL
printf "Device [/dev/videoX] or [/path/to/device] > "; read IN_DEV
printf "Web port [PORT]                           > "; read IN_PORT


# == OPTION PROCESSING ==
# Resolution
if [ "${IN_RES}" = "" ]; then               # Checks to see if the user only hit enter
  RUN_RES=${DEF_RES}                        # Sets the resolution that mjpg_streamer will run at to the default value
else
  RUN_RES=${IN_RES}                         # Otherwise, use the user input as the resolution to run at
fi

# Frame rate
if [ "${IN_FPS}" = "" ]; then
  RUN_FPS=${DEF_FPS}
else
  RUN_FPS=${IN_FPS}
fi

# Quality
if [ "${IN_QUAL}" = "" ]; then
  RUN_QUAL=${DEF_QUAL}
else
  RUN_QUAL=${IN_QUAL}
fi

# Device
if [ "${IN_DEV}" = "" ]; then
  RUN_DEV=${DEF_DEV}
elif [[ ( "${IN_DEV}" = "0" ) || ( "${IN_DEV}" = "1" ) || ( "${IN_DEV}" = "2" ) || ( "${IN_DEV}" = "3" ) || ( "${IN_DEV}" = "4" ) || ( "${IN_DEV}" = "5" ) || ( "${IN_DEV}" = "6" ) || ( "${IN_DEV}" = "7" ) || ( "${IN_DEV}" = "8" ) || ( "${IN_DEV}" = "9" ) ]]; then
  RUN_DEV="/dev/video${IN_DEV}"             # If the user enters a number between 0 and 9, set the device to /dev/videoX, where X = that number
else
  RUN_DEV=${IN_DEV}
fi

# Port
if [ "${IN_PORT}" = "" ]; then
  RUN_PORT=${DEF_PORT}
else
  RUN_PORT=${IN_PORT}
fi

echo "" # Prints blank lines to start mjpg_streamer's log on a new line
#Runs mjpg_streamer with all of the selected options
${BIN_MJPG} -i "${LIB_CAMIN} -r ${RUN_RES} -f ${RUN_FPS} -q ${RUN_QUAL} -d ${RUN_DEV}" -o "${LIB_CAMOUT} -w ${OUT_WEB_FILES_PATH} -p ${RUN_PORT}"
