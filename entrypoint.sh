#!/usr/bin/env bash

# 1. รัน Python HTTP Server หลอกพอร์ตไว้เบื้องหลัง (Render จะได้เข้าใจว่านี่คือ Web Service และเปลี่ยนสถานะเป็น Live)
python3 -m http.server 10000 &

# 2. รันคำสั่งเดิมของมึง (เช่น VNC / Termux / Cloudflare Tunnel)
# ตัวอย่าง: รัน cloudflared เพื่อต่ออุโมงค์ VNC
cloudflared tunnel --url tcp://localhost:5901 &

# รอให้ทุกอย่างรันค้างไว้
wait
