FROM node:20-bullseye

# 安装系统依赖和常用的浏览器运行环境库
RUN apt-get update && \
    apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装 OpenClaw
RUN npm install -g openclaw


WORKDIR /root

# 默认命令
CMD ["sh", "-c", "openclaw gateway"]