# Start openclaw
Quickly launch your openclaw with Docker
language/语言:[简体中文](README-zh_CN.md)

## Quick Start
Before getting started, please ensure the following prerequisites are met:
- Docker is installed on the host machine
- The host machine can access `ghcr.io`
- The host machine can access `github.com`

### 1. Pull the Image
You can pull the image using the following command:
```bash
sudo docker pull ghcr.io/iamliuxiaozhen/start-openclaw:latest
```

### 2. Run
There are two methods to run the project. Please choose according to your needs:
- Method 1: `docker-compose` (Recommended)
- Method 2: `docker run` command

#### Running with `docker-compose`
Refer to the `docker-compose.yml.example` file in this project. After downloading this file, rename it to `docker-compose.yml`.

```yaml
services:
  openclaw:
    build: .
    container_name: openclaw-bot
    restart: unless-stopped
    privileged: true
    ports:
      - "127.0.0.1:18789:18789"
    volumes:
     # Mount volumes here
     # -/home/username/ai-workspace:/workspace
     # /home/username/.openclaw:/root/.openclaw
    environment:
      - NODE_ENV=production

    stdin_open: true
    tty: true
```

Typically, you only need to modify the volume mounts.

> [!CAUTION]
> We strongly recommend configuring volume mounts, otherwise the AI may lose context or even important data.

##### Running with `docker run` command
You can start the project using the following command:
```bash
docker run -d \
  --name openclaw-bot \
  --restart unless-stopped \
  --privileged \
  -p 127.0.0.1:18789:18789 \
  -v /home/username/ai-workspace:/workspace \
  -v /home/username/.openclaw:/root/.openclaw \
  -e NODE_ENV=production \
  -it \
  openclaw:latest
```

Please replace the `-v` parameters with your desired mount locations.

> [!CAUTION]
> We strongly recommend configuring volume mounts, otherwise the AI may lose context or even important data.

### Initializing openclaw (Required for first-time setup)
To initialize openclaw, you need to enter the container first. Use the following command to access the Docker container:
```bash
docker exec -it openclaw-bot bash
```

Then, initialize openclaw:
```bash
openclaw onboard
```

![openclaw onboarding security consent page](images/1.png)

Read and acknowledge the risks:

```
◆  Onboarding mode
│  ● QuickStart (Configure details later via openclaw configure.)
│  ○ Manual
```

Select `QuickStart` to continue.

```
◆  Model/auth provider
│  ● OpenAI (Codex OAuth + API key)
│  ○ Anthropic
│  ○ Chutes
│  ○ MiniMax
│  ○ Moonshot AI (Kimi K2.5)
│  ○ Google
│  ○ xAI (Grok)
│  ○ Mistral AI
│  ○ Volcano Engine
│  ○ BytePlus
│  ○ OpenRouter
│  ○ Kilo Gateway
│  ○ Qwen
│  ○ Z.AI
│  ○ Qianfan
│  ○ Alibaba Cloud Model Studio
│  ○ Copilot
│  ○ Vercel AI Gateway
│  ○ OpenCode
│  ○ Xiaomi
│  ○ Synthetic
│  ○ Together AI
│  ○ Hugging Face
│  ○ Venice AI
│  ○ LiteLLM
│  ○ Cloudflare AI Gateway
│  ○ Custom Provider
│  ○ Ollama
│  ○ SGLang
│  ○ vLLM
│  ○ Skip for now
└
```

Select your preferred large model provider.

```
◇  Model configured ─────────────────────────────╮
│                                                │
│  Default model set to qwen-portal/coder-model  │
│                                                │
├────────────────────────────────────────────────╯
│
◆  Default model
│  ● Keep current (qwen-portal/coder-model)
│  ○ Enter model manually
│  ○ qwen-portal/coder-model
│  ○ qwen-portal/vision-model
└
```

Select the model to use.

```
◆  Select channel (QuickStart)
│  ● Telegram (Bot API) (recommended · newcomer-friendly)
│  ○ WhatsApp (QR link)
│  ○ Discord (Bot API)
│  ○ IRC (Server + Nick)
│  ○ Google Chat (Chat API)
│  ○ Slack (Socket Mode)
│  ○ Signal (signal-cli)
│  ○ iMessage (imsg)
│  ○ LINE (Messaging API)
│  ○ Feishu/Lark (飞书)
│  ○ Nostr (NIP-04 DMs)
│  ○ Microsoft Teams (Bot Framework)
│  ○ Mattermost (plugin)
│  ○ Nextcloud Talk (self-hosted)
│  ○ Matrix (plugin)
│  ○ BlueBubbles (macOS app)
│  ○ Zalo (Bot API)
│  ○ Zalo (Personal Account)
│  ○ Synology Chat (Webhook)
│  ○ Tlon (Urbit)
│  ○ Skip for now
└
```

Configure your messaging platform here. If you don't select `Skip for now`.

```
◇  Web search ────────────────────────────────────────╮
│                                                     │
│  Web search lets your agent look things up online.  │
│  Choose a provider and paste your API key.          │
│  Docs: https://docs.openclaw.ai/tools/web           │
│                                                     │
├─────────────────────────────────────────────────────╯
│
◆  Search provider
│  ● Brave Search (Structured results · country/language/time filters)
│  ○ Gemini (Google Search)
│  ○ Grok (xAI)
│  ○ Kimi (Moonshot)
│  ○ Perplexity Search
│  ○ Skip for now
```

Configure web search functionality here. If you don't select `Skip for now`.

Follow the prompts to complete the setup.

Some steps have been omitted here and will be added later.

### Accessing openclaw
After configuration is complete, you can access the web interface of openclaw at:
```url
http://127.0.0.1:18789/
```

## Advanced Configuration and Other Topics

### Fixing Host Machine Unable to Access `http://127.0.0.1:18789/`
Enter the container:
```bash
docker exec -it openclaw-bot bash
```

Navigate to the directory:
```bash
cd /root/.openclaw
```

Edit the configuration:
```bash
nano openclaw.json
```

Find `"bind": "loopback"` and change it to `"bind": "lan"`.

| Mode | Listening Scope |
|------|----------------|
| loopback | Container internal only |
| lan | Local network |
| auto | Auto-detect |
| tailnet | Tailscale only |
| custom | Custom |

### Configuring Global Network Access to openclaw Web Interface

Modify the Docker startup configuration from `127.0.0.1` to `0.0.0.0`:

In `docker-compose.yml`:
```yaml
ports:
    - "0.0.0.0:18789:18789"
```

In `docker run` command:
```bash
-p 0.0.0.0:18789:18789 \
```

> [!CAUTION]
> This step carries risks. If your host firewall is not properly configured, it could potentially allow public access. We recommend using Nginx reverse proxy when conditions permit.