FROM ubuntu:22.04

# ตั้งค่าไม่ให้มันถาม Prompt เวลาติดตั้งแพ็กเกจ
ENV DEBIAN_FRONTEND=noninteractive

# ติดตั้งโปรแกรมพื้นฐาน, XFCE Desktop, TightVNC Server และ curl สำหรับโหลด Cloudflare
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Cloudflare Tunnel (cloudflared) ตัวล่าสุด
RUN curl -L --output /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# สร้างโฟลเดอร์สำหรับสคริปต์รันระบบ
WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 5901
CMD ["/app/entrypoint.sh"]
