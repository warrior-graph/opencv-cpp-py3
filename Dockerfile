FROM ubuntu:18.04

RUN apt update && apt install -y \
    build-essential \
    checkinstall \
    cmake \
    pkg-config \
    yasm \
    git \
    gfortran \
    libjpeg8-dev \
    libpng-dev \
    software-properties-common \
    && add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" \
    && apt update && apt install -y \
    libjasper1 \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libdc1394-22-dev \
    libxine2-dev libv4l-dev \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libgtk2.0-dev libtbb-dev qt5-default \
    libatlas-base-dev \
    libfaac-dev libmp3lame-dev libtheora-dev \
    libvorbis-dev libxvidcore-dev \
    libopencore-amrnb-dev libopencore-amrwb-dev \
    libavresample-dev \
    x264 v4l-utils \
    libprotobuf-dev protobuf-compiler \
    libgoogle-glog-dev libgflags-dev \
    libgphoto2-dev libhdf5-dev doxygen \
    python3-dev python3-pip \
    python3-testresources \
    && cd /usr/include/linux \
    && ln -sf ../libv4l1-videodev.h videodev.h

RUN cd && git clone https://github.com/opencv/opencv.git \
    && git clone https://github.com/opencv/opencv_contrib \
    && cd opencv && git checkout -b tags/4.1.0 && cd \
    && cd opencv_contrib && git checkout -b tags/4.1.0 && cd \
    && pip3 install -U pip numpy virtualenv \
    && cd && python3 -m virtualenv -p python3 --no-site-packages .opencv-py3 \
    && mkdir opencv/build && cd opencv/build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
                -D CMAKE_INSTALL_PREFIX=/usr/local \
                -D INSTALL_C_EXAMPLES=ON \
                -D INSTALL_PYTHON_EXAMPLES=ON \
                -D WITH_TBB=ON \
                -D WITH_V4L=ON \
                -D OPENCV_PYTHON3_INSTALL_PATH=/root/.opencv-py3/lib/python3.6/site-packages \
                -D WITH_QT=ON \
                -D WITH_OPENGL=ON \
                -D BUILD_TIFF=ON \
                -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
                -D BUILD_EXAMPLES=ON .. \
    && make -j`nproc` && make install \
    && cd && rm -rf opencv* \
    && mv /usr/local/include/opencv4/opencv2 /usr/local/include/opencv2 \
    && rm -rf /usr/local/include/opencv4
    
    
