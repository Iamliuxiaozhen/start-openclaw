#!/bin/bash
# 如果 openclaw.json 不存在，就初始化
if [ ! -f /root/.openclaw/openclaw.json ]; then
  echo "首次启动，执行 onboard..."
  openclaw onboard
fi

# 启动 gateway
exec openclaw gateway