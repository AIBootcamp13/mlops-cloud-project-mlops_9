#!/bin/bash

DEMO_ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DEMO_ROOT_DIR" || exit
source .venv/bin/activate

PYTHONPATH="${DEMO_ROOT_DIR}" streamlit run st_demo.py --server.port 8501
