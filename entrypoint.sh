#!/usr/bin/env bash

# 1. รัน Python HTTP Server เปิดพอร์ต 10000 ไว้หลอก Render ให้สถานะเป็น Live
python3 -m http.server 10000 &

# 2. ปิดระบบรหัสผ่าน VNC ไปก่อน เพื่อทดสอบการเชื่อมต่อ (Security Blank)
mkdir -p ~/.vnc
echo "" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 3. สั่งรัน VNC Server แบบไม่ใช้รหัสผ่าน (หรือข้ามพาสเวิร์ด) และตั้งค่าดีสเพลย์
vncserver :1 -geometry 1280x720 -depth 24 -localhost no

echo "=== VNC Started. Opening Pinggy TCP Tunnel... ==="

# 4. ใช้ Pinggy เปิดพอร์ต TCP ตรงๆ ออกภายนอก
ssh -p 443 -o StrictHostKeyChecking=no -R0:localhost:5901 tcp@a.pinggy.io &

# รอค้างไว้
wait

