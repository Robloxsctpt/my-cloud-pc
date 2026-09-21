#!/usr/bin/env bash
export USER=root
export HOME=/root
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1
killall Xtightvnc Xvnc python3 ssh &>/dev/null
python3 -m http.server 10000 &
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd
vncserver :1 -geometry 1280x720 -depth 24
echo "=== Starting Serveo Tunnel ==="
ssh -o StrictHostKeyChecking=no -R 0:localhost:5901 serveo.net
