#!/bin/bash

# 기본 경로 및 변수
PROJECT_NAME="bentoml"
BENTO_ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BENTO_RUN_DIR="$BENTO_ROOT_DIR/run/"    # "var/run/$PROJECT_NAME/"
LOG_FILE="${BENTO_RUN_DIR}/${PROJECT_NAME}.log"
BENTO_MODULE_PATH="models.disease_classifier.make_bento:BentoDiseaseClassifier"

# venv 활성화 & run dir 생성
cd $BENTO_ROOT_DIR
source .venv/bin/activate
mkdir -p "$BENTO_RUN_DIR"

# 인자 체크: model_uri, port 필수
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <model_uri> <port> [--background]"
  echo "Bento module is: $BENTO_MODULE_PATH"
  exit 1
fi

MODEL_URI="$1"
SERVING_PORT="$2"

# background 플래그 체크
if [ "${@: -1}" == "--background" ]; then
  BACKGROUND=true
else
  BACKGROUND=false
fi

cd "$BENTO_ROOT_DIR" || exit
BENTOML_CMD="bentoml serve $BENTO_MODULE_PATH \
  --port $SERVING_PORT \
  --arg model_uri=$MODEL_URI \
  --working-dir ."

if [ "$BACKGROUND" = true ]; then
  echo "[INFO] Starting in background mode..." >> "$LOG_FILE"
  nohup bash -c "$BENTOML_CMD" > "$LOG_FILE" 2>&1 < /dev/null &
  BENTO_PID=$!
  sleep 2
  if ps -p $BENTO_PID > /dev/null; then
    echo "$BENTO_MODULE_PATH" > "${BENTO_RUN_DIR}/run.id"
    echo "[SUCCESS] BentoML serve started in background. PID: $BENTO_PID" >> "$LOG_FILE"
  else
    echo "[ERROR] BentoML serve failed to start in background." >> "$LOG_FILE"
    exit 1
  fi
else
  eval "$BENTOML_CMD"
fi
