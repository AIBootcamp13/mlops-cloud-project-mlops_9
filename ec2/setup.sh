#!/bin/bash

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y \
  ca-certificates curl gnupg lsb-release git docker-ce docker-ce-cli containerd.io

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) \
-o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version

# TODO:
# docker compose 실행 (airflow, mlflow)
# - env 파일 초기화

# bento-ml
# curl -LsSf https://astral.sh/uv/install.sh | sh
# uv venv
# source .venv/bin/activate
# uv pip install -r requirements.txt

# demo webapp
# node + PM2 설치
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
#source ~/.bashrc
#nvm install --lts
#node -v
#npm -v
# sudo npm install -g pm2
# pm2 -v
# pm2 startup
# pm2 save

