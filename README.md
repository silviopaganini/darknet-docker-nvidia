# Darknet Nvidia-Docker Ubuntu 16.04

## Prerequisites

1) Make sure you have the NVidia driver for your machine https://www.nvidia.com/Download/index.aspx?lang=en-us

2) Install Docker and NVidia Docker https://github.com/NVIDIA/nvidia-docker

## Steps to run

1) Clone this repo

2) Build the machine (this step might take a while, go make some coffee)
```bash
docker build -t darknet .
````

3) On `start.sh` make sure you have the correct address of your webcam 

`--device=/dev/bus/usb/003/002:/dev/video0`

4) Run the machine with Webcam
```bash
sh start.sh
```

## Darknet

Make sure you have the weights for what you want to run

More information at https://pjreddie.com/darknet/