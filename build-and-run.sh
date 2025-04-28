#!/bin/bash

# Build the Docker image
echo "Building ComfyUI Docker container..."
docker build -t comfy-container .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    
    # Run the container without GPU support for Mac testing
    echo "Starting ComfyUI container for Mac testing (without GPU)..."
    docker run -p 8188:8188 comfy-container
else
    echo "Build failed. Please check the error messages above."
    exit 1
fi 