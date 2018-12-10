FROM nvidia/cuda:9.0-devel-ubuntu16.04
LABEL maintainer="Silvio Paganini <silvio@fluuu.id>" 

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
        git \
        build-essential \
        cmake \
        vim \
        wget \
        pkg-config \
	python-pip \
        python3-pip \
        python-numpy \
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
	libc6-dev-i386 \
        libavresample-dev \
        libgphoto2-dev \
	libx32gcc-4.8-dev \
        libgstreamer-plugins-base1.0-dev \
        libdc1394-22-dev

RUN pip3 install --upgrade pip

WORKDIR /opt
RUN wget https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz --no-check-certificate && tar -xf 3.4.0.tar.gz && rm 3.4.0.tar.gz
RUN wget https://github.com/opencv/opencv/archive/3.4.0.tar.gz --no-check-certificate && tar -xf 3.4.0.tar.gz && rm 3.4.0.tar.gz

WORKDIR opencv-3.4.0
RUN mkdir build && cd build && \
        cmake 	-D CMAKE_BUILD_TYPE=RELEASE \
                -D BUILD_NEW_PYTHON_SUPPORT=ON \
                -D CMAKE_INSTALL_PREFIX=/usr/local \
                -D INSTALL_C_EXAMPLES=OFF \
                -D INSTALL_PYTHON_EXAMPLES=OFF \
                -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-3.4.0/modules \
#                -D PYTHON_EXECUTABLE=/usr/bin/python3 \
#                -D WITH_OPENGL=ON \
#                -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
#                -D WITH_CUDA=ON \
                -D BUILD_EXAMPLES=OFF /opt/opencv-3.4.0 && \
        make -j7 && \
        make install && \
        ldconfig && \
        rm -rf /opt/opencv*

WORKDIR /
RUN wget https://github.com/pjreddie/darknet/archive/master.tar.gz --no-check-certificate && tar -xf master.tar.gz && rm master.tar.gz && mv ./darknet-master ./darknet
WORKDIR /darknet
COPY Makefile Makefile

RUN make

CMD ["/bin/bash"]
