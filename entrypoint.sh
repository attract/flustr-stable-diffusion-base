#!/bin/bash
set -e

. ~/miniconda3/bin/activate

# Stable Diffusion workers
echo "Creating logs..."
echo "SD_DEV" > /worker-log-dev.out;
echo "SD_STAGE" > /worker-log-stage.out;
echo "SD_PROD" > /worker-log-prod.out;

echo "Starting workers dev, stage, prod..."
nohup python3 /app_dev/worker.py dev &> /worker-log-dev.out &
#nohup python3 /app_stage/worker.py stage &> /worker-log-stage.out &
#nohup python3 /app_prod/worker.py prod &> /worker-log-prod.out &

tail -f /worker-log-dev.out /worker-log-stage.out /worker-log-prod.out