#!/usr/bin/env bash

export USER=root
export HOME=/root

# เคลียร์ล็อกเก่าให้เกลี้ยง
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1
killall Xtightvnc Xvnc python3 loclx &>/dev/null

# 1. รัน Python HTTP Server หลอกพอร์ต 10000 ไว้
python3 -m http.server 10000 &

# 2. ตั้งค่ารหัสผ่าน VNC แบบว่างไว้
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 3. สั่งรัน VNC Server
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Installing LocalXpose Tunnel ==="

# 4. ดาวน์โหลดและติดตั้ง LocalXpose
curl -s https://localxpose.io/installer/linux.sh | bash &>/dev/null

# 5. รันคำสั่งไบนารีของ LocalXpose (มักจะชื่อ loclx) เพื่อเปิดพอร์ต TCP 5901
loclx tunnel tcp --to :5901 &

# รอค้างไว้
wait
