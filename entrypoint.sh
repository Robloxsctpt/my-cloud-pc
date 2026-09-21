#!/usr/bin/env bash

export USER=root
export HOME=/root

# 1. เคลียร์ไฟล์ล็อกขยะและเซสชันเก่าให้เกลี้ยง ป้องกัน VNC ชนกัน
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1
vncserver -kill :1 &>/dev/null

# 2. รัน Python HTTP Server หลอกพอร์ต 10000 ไว้
python3 -m http.server 10000 &

# 3. ตั้งค่ารหัสผ่าน VNC แบบว่างไว้ก่อนเพื่อเทส
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 4. สั่งรัน VNC Server รอบเดียวเน้นๆ
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Opening Pinggy TCP Tunnel... ==="

# 5. เปิด Pinggy TCP Tunnel
ssh -p 443 -o StrictHostKeyChecking=no -R0:localhost:5901 tcp@a.pinggy.io &

# รอค้างไว้
wait
