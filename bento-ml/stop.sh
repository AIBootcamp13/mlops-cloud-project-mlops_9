#!/bin/bash

# 기본 경로 및 변수
BENTO_ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BENTO_RUN_DIR="$BENTO_ROOT_DIR/run/"    # "var/run/$PROJECT_NAME/"

# run.id 파일 찾기
RUN_ID_FILE=$(find "$BENTO_RUN_DIR" -type f -name "run.id" | head -n 1)

if [ -z "$RUN_ID_FILE" ]; then
  echo "No run.id file found in $RUN_DIR"
  exit 1
fi

# BentoML module path 로드
BENTO_MODULE_PATH=$(cat "$RUN_ID_FILE")

if [ -z "$BENTO_MODULE_PATH" ]; then
  echo "No bento_module_path found in $RUN_ID_FILE"
  exit 1
fi

echo "Stopping processes with pattern: $BENTO_MODULE_PATH"
# ex) pkill -f "models.disease_classifier.make_bento:BentoDiseaseClassifier"
pkill -f "$BENTO_MODULE_PATH"

if [ $? -eq 0 ]; then
  echo "Successfully sent termination signal to processes."
else
  echo "No matching processes found or error occurred."
fi