# Darknet Nvidia-Docker Ubuntu 16.04
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