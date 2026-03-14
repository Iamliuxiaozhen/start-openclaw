# Dockerfile
FROM node:20-bullseye

# 安装额外依赖
RUN apt-get update && \
    apt-get install -y git python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 安装 OpenClaw
RUN npm install -g openclaw

# 设置工作目录
WORKDIR /root

# 默认命令
CMD ["openclaw", "gateway"]