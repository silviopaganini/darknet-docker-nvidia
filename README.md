# Darknet Nvidia-Docker Ubuntu 16.04
openCV 3.4.0
CUDA 9.0

Build the machine 
```bash
docker build -t darknet .
````

Run the machine with Webcam
```bash
xhost +local:root
docker run --runtime=nvidia --device /dev/video0 --env="DISPLAY" -it darknet /bin/bash
```
