#!/bin/bash

# Create necessary directories if they don't exist
mkdir -p /app/models /app/custom_nodes /app/workflows

# Check if we need to load a specific workflow
if [ -n "$WORKFLOW_FILE" ] && [ -f "/app/workflows/$WORKFLOW_FILE" ]; then
    echo "Found workflow file: $WORKFLOW_FILE"
    # We'll use the workflow file specified in the environment variable
    WORKFLOW_ARG="--default-workflow /app/workflows/$WORKFLOW_FILE"
elif [ -f "/app/workflows/default_workflow.json" ]; then
    echo "Using default workflow file"
    WORKFLOW_ARG="--default-workflow /app/workflows/default_workflow.json"
else
    echo "No workflow file specified or found"
    WORKFLOW_ARG=""
fi

# Download default models if directory is empty and DOWNLOAD_MODELS is set
if [ -n "$DOWNLOAD_MODELS" ] && [ "$(ls -A /app/models 2>/dev/null)" == "" ]; then
    echo "Downloading default models..."
    mkdir -p /app/models/checkpoints
    # Download a basic model for testing
    wget -q -O /app/models/checkpoints/v1-5-pruned-emaonly.safetensors https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors
fi

# Install custom nodes if specified
if [ -n "$CUSTOM_NODES" ]; then
    echo "Installing custom nodes..."
    IFS=',' read -ra NODE_REPOS <<< "$CUSTOM_NODES"
    for repo in "${NODE_REPOS[@]}"; do
        echo "Cloning: $repo"
        git clone "$repo" /app/custom_nodes/$(basename "$repo" .git)
        if [ -f "/app/custom_nodes/$(basename "$repo" .git)/requirements.txt" ]; then
            pip install -r "/app/custom_nodes/$(basename "$repo" .git)/requirements.txt"
        fi
    done
fi

# Start ComfyUI
echo "Starting ComfyUI server..."
cd /app
python3 main.py --listen 0.0.0.0 --port 8188 $WORKFLOW_ARG 