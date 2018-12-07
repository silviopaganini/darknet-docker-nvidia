FROM nvidia/cuda:9.0-devel-ubuntu16.04
MAINTAINER Silvio Paganini <silvio@fluuu.id>

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y python3-pip \
			vim \
			wget \
		        build-essential \
			cmake \
			git \
			libgtk2.0-dev \
			pkg-config \
			libavcodec-dev \
			usbutils \
			libavformat-dev \
                        g++-multilib \
			qt5-default \
			libswscale-dev \
			libgflags-dev

RUN apt-get --reinstall install libc6 libc6-dev
RUN ln -s /usr/include/asm-generic /usr/include/asm
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade numpy

WORKDIR /OpenCV
RUN git clone https://github.com/Itseez/opencv.git && cd opencv && git checkout 3.4.0

WORKDIR /OpenCV
RUN git clone https://github.com/Itseez/opencv_contrib.git && cd opencv_contrib && git checkout 3.4.0

WORKDIR /OpenCV/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_QT=ON \
    -D WITH_OPENGL=ON \
    -D FORCE_VTK=ON \
    -D WITH_CUDA=ON \
    -D BUILD_PNG=ON \
    -D BUILD_TIFF=ON \
    -D BUILD_TBB=OFF \
    -D BUILD_JPEG=ON \
    -D BUILD_JASPER=ON \
    -D BUILD_ZLIB=ON \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_LIBV4L=ON \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -D VIBRANTE=TRUE \
    -D WITH_TBB=ON \
    -D WITH_GDAL=ON \
    -D WITH_XINE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/OpenCV/opencv_contrib/modules \
    VERBOSE=1 \
    ..

RUN make -j7 && make install && ldconfig


RUN git clone https://github.com/pjreddie/darknet.git /darknet
WORKDIR /darknet
COPY Makefile Makefile

RUN make

RUN wget https://pjreddie.com/media/files/yolov3.weights
RUN wget https://pjreddie.com/media/files/yolov3-tiny.weights

CMD ["/bin/bash"]
