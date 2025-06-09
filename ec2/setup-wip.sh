#!/bin/bash

set -e

# --- Docker 설치 ---
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

# --- Docker Compose 설치 ---
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) \
-o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version

# --- .env 파일 생성 ---
echo "Creating .env files..."

AIRFLOW_UID=1000
AIRFLOW_GID=1000
DOCKER_GID=$(getent group docker | cut -d: -f3)
HOST_USERNAME=$(whoami)
FERNET_KEY="CHANGE_THIS_TO_YOUR_KEY"

# Root .env
cat <<EOF > .env
AIRFLOW_UID=$AIRFLOW_UID
AIRFLOW_GID=$AIRFLOW_GID
DOCKER_GID=$DOCKER_GID
HOST_USERNAME=$HOST_USERNAME
AIRFLOW__CORE__FERNET_KEY=$FERNET_KEY
EOF
echo ".env created"

# catch/airflow/.env
cp catch/airflow/env.template catch/airflow/.env
echo "catch/airflow/.env created"

# catch/mlflow/.env
cp catch/mlflow/env.template catch/mlflow/.env
echo "catch/mlflow/.env created"

# --- Docker Compose 서비스 실행 ---
echo "Starting Airflow..."
docker compose -f catch/airflow/docker-compose.yaml up -d

echo "Starting MLflow..."
docker compose -f catch/mlflow/docker-compose.yaml up -d

echo "Starting Monitoring Stack (Prometheus + Grafana)..."
docker compose -f catch/monitor/docker-compose.yaml up -d

# --- BentoML 설치 ---
echo "Installing BentoML dependencies..."

# uv 설치
curl -LsSf https://astral.sh/uv/install.sh | sh

# PATH 적용 (uv 설치 후 경로 적용 필요)
export PATH="$HOME/.local/bin:$PATH"

# catch/bento-ml로 이동 후 venv 생성 및 install
cd catch/bento-ml
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
deactivate
cd ../..

# --- Webapp Node.js + PM2 설치 ---
echo "Installing Node.js and PM2..."

# nvm 설치
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# nvm 적용
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# node LTS 설치
nvm install --lts
node -v
npm -v

# pm2 설치
sudo npm install -g pm2
pm2 -v

# PM2 startup 설정
pm2 startup
pm2 save

echo "Setup completed!"
