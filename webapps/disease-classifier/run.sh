#!/bin/bash

DEMO_ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DEMO_ROOT_DIR" || exit
PYTHONPATH="${DEMO_ROOT_DIR}" streamlit run st_demo.py --server.port 5000