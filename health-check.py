#!/usr/bin/env python3
import http.client
import sys

try:
    conn = http.client.HTTPConnection("localhost:8188")
    conn.request("GET", "/")
    response = conn.getresponse()
    
    if response.status >= 200 and response.status < 300:
        print("Health check passed! ComfyUI is running.")
        sys.exit(0)
    else:
        print(f"Health check failed! Status code: {response.status}")
        sys.exit(1)
except Exception as e:
    print(f"Health check failed! Error: {str(e)}")
    sys.exit(1) 