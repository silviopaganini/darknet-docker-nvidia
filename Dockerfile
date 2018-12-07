FROM nvidia/cuda:9.0-devel-ubuntu16.04
LABEL maintainer="Silvio Paganini <silvio@fluuu.id>" 

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        git \
        build-essential \
        cmake \
        vim \
        wget \
        pkg-config \
        python3-pip \
        libjpeg8-dev \
        libtiff5-dev \
        libjasper-dev \
        libpng12-dev \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libatlas-base-dev \
        gfortran \
        libavresample-dev \
        libgphoto2-dev \
        libgstreamer-plugins-base1.0-dev \
        libdc1394-22-dev

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade numpy

RUN cd /opt && \
        git clone https://github.com/opencv/opencv_contrib.git && \
        cd opencv_contrib && \
        git checkout 3.4.0 && \	
        cd /opt && \
        git clone https://github.com/opencv/opencv.git && \
        cd opencv && \
        git checkout 3.4.0 && \
        mkdir build && \
        cd build && \
        cmake 	-D CMAKE_BUILD_TYPE=RELEASE \
                -D BUILD_NEW_PYTHON_SUPPORT=ON \
                -D CMAKE_INSTALL_PREFIX=/usr/local \
                -D INSTALL_C_EXAMPLES=OFF \
                -D INSTALL_PYTHON_EXAMPLES=OFF \
                -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
                -D PYTHON_EXECUTABLE=/usr/bin/python2.7 \
                -D WITH_OPENGL=ON \
                -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
                -D WITH_CUDA=ON \
                -D BUILD_EXAMPLES=OFF /opt/opencv && \
        make -j $(nproc) && \
        make install && \
        ldconfig && \
        rm -rf /opt/opencv*

RUN git clone https://github.com/pjreddie/darknet.git /darknet
WORKDIR /darknet
COPY Makefile Makefile

RUN make

RUN wget https://pjreddie.com/media/files/yolov3.weights
RUN wget https://pjreddie.com/media/files/yolov3-tiny.weights

CMD ["/bin/bash"]
