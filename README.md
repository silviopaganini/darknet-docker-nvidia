# Darknet Nvidia-Docker Ubuntu 16.04

## Prerequisites

1) Make sure you have the NVidia driver for your machine 

Find out your the Graphics Card model 
```bash
lspci | grep VGA
```

https://www.nvidia.com/Download/index.aspx?lang=en-us

How to install NVidia Drivers on Linux
https://gist.github.com/wangruohui/df039f0dc434d6486f5d4d098aa52d07#install-nvidia-graphics-driver-via-runfile

2) Install Docker and NVidia Docker https://github.com/NVIDIA/nvidia-docker

## Steps to run

1) Clone this repo

2) Build the machine (this step might take a while, go make some ☕️)
```bash
docker build -t darknet .
````

3) On `start.sh` make sure you have the correct address of your webcam 

Find your webcam bus
```bash
lsusb -t
```

Change the following line with the correct webcam bus

```
--device=/dev/bus/usb/003/002:/dev/video0
```

4) Map a local folder to the Docker Container 

Format:
```bash
/local/folder:/docker/folder
```

on `start.sh` change the following line
```bash
-v /home/projects:/dev/projects \
```

4) Run the machine with Webcam
```bash
sh start.sh
```

## Darknet

Make sure you have the weights for what you want to run

More information at https://pjreddie.com/darknet/