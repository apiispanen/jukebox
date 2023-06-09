# Set the base image
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

# Add NVIDIA package repository key
RUN sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu bionic main universe" >> /etc/apt/sources.list' && \
    apt-get update && \
    apt-get install -y gnupg && \
    curl -sL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub -o /tmp/nvidia.pub && \
    apt-key add /tmp/nvidia.pub

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        ffmpeg \
        libsndfile1 \
        libsndfile-dev \
        libportaudio2 \
        libportaudiocpp0 \
        libportaudio-dev \
        libsndio-dev \
        libsndio6.1 \
        libvorbis-dev \
        libogg-dev \
        libflac-dev \
        libfftw3-dev \
        libmp3lame-dev \
        libopus-dev \
        python3-dev \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir \
        torch==1.9.0+cu111 \
        librosa==0.7.2 \
        soundfile==0.10.3.post1 \
        unidecode==1.2.0 \
        pydub==0.24.1 \
        tqdm==4.42.1 \
        omegaconf==2.0.6 \
        kaldi_io

# Clone the Jukebox repository
RUN git clone https://github.com/openai/jukebox.git

# Set the working directory
WORKDIR /jukebox

# Run the setup script
RUN bash setup.sh

# Expose the default port
EXPOSE 8080

# Run the Jukebox server
CMD ["python3", "setup.py"]
