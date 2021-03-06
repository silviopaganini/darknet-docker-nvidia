#! /bin/bash

xhost +

GPU=0 docker run --runtime=nvidia --privileged --rm -it \
--env DISPLAY=$DISPLAY \
--env="QT_X11_NO_MITSHM=1" \
--device=/dev/bus/usb/003/004:/dev/video0 \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
-v /home/barbican/Desktop/darknet:/dev/projects \
--net=host \
darknet /bin/bash

xhost -
