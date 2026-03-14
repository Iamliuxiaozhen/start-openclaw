# Dockerfile
FROM ubuntu:latest

# 基础依赖
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 安装 Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs
    
# 安装 OpenClaw CLI
RUN npm install -g openclaw

# 设置工作目录
WORKDIR /root

# 挂载 .openclaw 和 workspace 由 docker-compose 处理

# 前台启动 OpenClaw gateway
CMD ["openclaw", "gateway", "--foreground"]