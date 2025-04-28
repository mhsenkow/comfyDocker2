#!/bin/bash

# Build the Mac-compatible Docker image
echo "Building CPU-only ComfyUI Docker container for Mac testing..."
docker build -t comfy-container-cpu -f Dockerfile.mac .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    
    # Run the container with CPU support
    echo "Starting ComfyUI container with CPU support for Mac testing..."
    docker run -p 8188:8188 comfy-container-cpu
else
    echo "Build failed. Please check the error messages above."
    exit 1
fi 