#!/usr/bin/env bash

export USER=root
export HOME=/root

# ป้องกันการรันซ้ำซ้อน ถ้ามีโปรเซสค้างให้เคลียร์ทิ้งก่อน
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1
killall Xtightvnc Xvnc python3 ssh &>/dev/null

# 1. รัน Python HTTP Server หลอกพอร์ต 10000 ไว้เบื้องหลังแบบไม่บล็อก
python3 -m http.server 10000 &

# 2. ตั้งค่ารหัสผ่าน VNC แบบว่างไว้ก่อนเพื่อเทส
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 3. สั่งรัน VNC Server รอบเดียวจบ
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Opening Pinggy TCP Tunnel... ==="

# 4. เปิด Pinggy TCP Tunnel (ใช้ exec เพื่อให้รันยาวๆ เป็นกระบวนการหลัก ไม่ให้สคริปต์มันวนลูปซ้ำ)
exec ssh -p 443 -o StrictHostKeyChecking=no -R0:localhost:5901 tcp@a.pinggy.io

