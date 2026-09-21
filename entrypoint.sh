#!/usr/bin/env bash

# 1. รัน Python HTTP Server เปิดพอร์ต 10000 ไว้หลอก Render ให้สถานะเป็น Live
python3 -m http.server 10000 &

# 2. ตั้งค่ารหัสผ่าน VNC เป็น 123456
mkdir -p ~/.vnc
echo "123456" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 3. สั่งรัน VNC Server บนพอร์ต 5901
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Opening Serveo TCP Tunnel... ==="

# 4. ใช้ Serveo เปิดพอร์ต TCP ตรงๆ ออกภายนอก (จะได้ Host และ Port ไปใส่ AVNC ตรงๆ)
ssh -o StrictHostKeyChecking=no -R 0:localhost:5901 serveo.net &

# รอค้างไว้
wait
