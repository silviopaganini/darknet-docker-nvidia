# Darknet Nvidia-Docker Ubuntu 16.04
## Steps to run

Clone this repo

Build the machine 
```bash
docker build -t darknet .
````

On `start.sh` make sure you have the correct address of your webcam 

`--device=/dev/bus/usb/003/002:/dev/video0`

Run the machine with Webcam
```bash
sh start.sh
```