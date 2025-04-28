# ComfyUI Docker Container for Runpod

A lightweight, production-ready Docker container for running ComfyUI on Runpod or other GPU hosts.

## Features

- Based on NVIDIA CUDA 12.1 with Ubuntu 22.04
- Automatically starts ComfyUI server on container launch
- Exposes port 8188 for web UI access
- Minimized container size through careful dependency management

## Basic Version

The basic version (`Dockerfile`) provides a minimal setup for running ComfyUI:

```bash
# Build and run the basic container
./build-and-run.sh
```

## Advanced Version

The advanced version (`Dockerfile.advanced`) includes additional features:

- Automatic workflow loading
- Model downloading
- Custom nodes installation
- Health check endpoint
- Volume mounting for persistent data

```bash
# Build and run the advanced container
./run-advanced.sh
```

### Environment Variables (Advanced Version)

- `WORKFLOW_FILE`: Name of a workflow file in the /app/workflows directory to load
- `DOWNLOAD_MODELS`: Set to any value to download default models if models directory is empty
- `CUSTOM_NODES`: Comma-separated list of Git repositories to clone as custom nodes

## Building Locally

```bash
# Clone this repository
git clone https://github.com/yourusername/comfy-docker.git
cd comfy-docker

# Build the Docker image (basic version)
docker build -t comfy-container .

# Or build the advanced version
docker build -t comfy-container-advanced -f Dockerfile.advanced .
```

## Running Locally

### Basic Version

```bash
# Run with GPU support
docker run --gpus all -p 8188:8188 comfy-container
```

### Advanced Version

```bash
# Run with GPU support and persistent storage
docker run --gpus all -p 8188:8188 \
    -v /path/to/models:/app/models \
    -v /path/to/workflows:/app/workflows \
    -e DOWNLOAD_MODELS=true \
    -e WORKFLOW_FILE=example_workflow.json \
    comfy-container-advanced
```

Once the container is running, access the ComfyUI web interface at: http://localhost:8188

## Deploying on Runpod

1. Push this container to a container registry or use the Runpod template system
2. Create a new pod on Runpod
3. Select your container image
4. Ensure port 8188 is exposed
5. Configure volume mounts for persistent model storage
6. Start the pod and access ComfyUI through the provided URL

## Troubleshooting

- If you encounter CUDA-related errors, ensure your host has compatible NVIDIA drivers installed
- For permission issues with volume mounts, check that the mounted directories have appropriate permissions 