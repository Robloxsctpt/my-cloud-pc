#!/bin/bash

# ตั้งค่ารหัสผ่าน VNC เป็น 123456 (เอาไว้กรอกตอนต่อ AVNC)
mkdir -p ~/.vnc
echo "123456" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# สั่งรัน VNC Server บนหน้าจอความละเอียด 1280x720 พอร์ต 5901
vncserver :1 -geometry 1280x720 -depth 24

echo "=== VNC Started. Starting Cloudflare Tunnel... ==="

# สั่งเจาะอุโมงค์ Cloudflare แบบ Quick Tunnel ไปที่พอร์ต VNC (5901)
# มันจะสร้างลิงก์ .trycloudflare.com ออกมาให้ เอาไปแปลงใส่ AVNC
cloudflared tunnel --url tcp://localhost:5901
