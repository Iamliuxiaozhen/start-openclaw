# Start openclaw
这是小圳快速启动Openclaw的脚本
## 快捷命令

### 构建镜像
```bash
sudo docker compose build
```

### 启动容器
```bash
sudo docker compose up -d
```

### 检查状态
```bash
sudo docker ps
sudo docker logs -f openclaw-bot
```
### 要进入容器调试：
```bash
sudo docker exec -it openclaw-bot bash
```
⚠️ 不要用 bash 来启动 gateway，主进程必须是 openclaw gateway --foreground，否则会无限重启。