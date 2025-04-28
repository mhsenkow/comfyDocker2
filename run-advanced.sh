#!/bin/bash

# Build the advanced Docker image
echo "Building advanced ComfyUI Docker container..."
docker build -t comfy-container-advanced -f Dockerfile.advanced .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    
    # Run the container without GPU support for Mac testing
    echo "Starting advanced ComfyUI container for Mac testing (without GPU)..."
    
    # Create models directory if it doesn't exist
    mkdir -p ./models
    
    # Run with environment variables
    docker run -p 8188:8188 \
        -v "$(pwd)/models:/app/models" \
        -v "$(pwd)/workflows:/app/workflows" \
        -e DOWNLOAD_MODELS=true \
        comfy-container-advanced
else
    echo "Build failed. Please check the error messages above."
    exit 1
fi 