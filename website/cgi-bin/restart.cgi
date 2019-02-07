#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html>"
echo "<head><title>Cameras Restarting - Team 5561</title></head>"

sudo /usr/raiders/mjpg_manager.sh -r

echo "<body bgcolor='000000'><center>"
echo "<font color='FFFFFF'><h1>Camera Servers Restarted</h1><br />"
echo "<b1>If the camera feeds don't show up, try refreshing the page.</b1></font>"

echo "<br /><br />"
echo "<tr>"
echo "<td><a href='/cam0.html'><img src='/img/hires/hi_webcam0.jpg'></img></a></td>"
echo "<td><a href='/cam1.html'><img src='/img/hires/hi_webcam1_alt.jpg'></img></a></td>"
echo "<td><a href='/cam2.html'><img src='/img/hires/hi_webcam2.jpg'></img></a></td>"
echo "</tr></center>"

echo "</body></html>"
