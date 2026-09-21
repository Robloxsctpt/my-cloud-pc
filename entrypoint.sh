#!/usr/bin/env bash

export USER=root
export HOME=/root

# เคลียร์ล็อกเก่าให้เกลี้ยง
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1
killall Xtightvnc Xvnc python3 ssh &>/dev/null

# 1. รัน Python HTTP Server หลอกพอร์ต 10000 ไว้
python3 -m http.server 10000 &

# 2. ตั้งค่ารหัสผ่าน VNC แบบว่างไว้ก่อน
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 3. สั่งรัน VNC Server รอบเดียวจบ
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Opening LocalTCP Tunnel... ==="

# 4. ใช้ LocalXpose หรือสลับมาใช้บริการพอร์ต TCP ที่เสถียรผ่าน SSH (เช่น Serveo แบบระบุพอร์ตตรง หรือ Pinggy แบบ IP Direct)
ssh -p 443 -o StrictHostKeyChecking=no -R 0:localhost:5901 tcp@a.pinggy.io
