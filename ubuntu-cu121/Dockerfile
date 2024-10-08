################################################################################
# Dockerfile that builds 'robinpenn/comfyui-docker:cu124'
# A streamlined version using PyTorch's official CUDA 12.4 image.
################################################################################

FROM pytorch/pytorch:2.1.1-cuda12.1-cudnn8-runtime

LABEL maintainer="robinpenn <code@robinpenn.fun>"

# Set the environment variable to avoid timezone prompt
ENV DEBIAN_FRONTEND=noninteractive

# Install tzdata and set timezone to Shanghai non-interactively
RUN apt-get update && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

################################################################################
# System utilities and dependencies

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    vim \
    ninja-build \
    aria2 \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

################################################################################
# Python Packages

# Upgrade pip, setuptools, and install the required Python packages
# xformers==0.0.23 for impact-pack DepthAnythingV2
# torch==2.1.2 torchaudio==2.1.2 for RVC
RUN pip install --upgrade pip wheel setuptools \
    && pip install \
        xformers==0.0.23 \
        torchvision==0.16.2 \
        torchaudio==2.1.2 \
        beautifulsoup4 \
        GitPython \
        joblib \
        matplotlib \
        numba \
        numpy \
        onnx \
        opencv-python-headless \
        pandas \
        rich \
        scikit-image \
        scikit-learn \
        scipy \
        tqdm \
        pycparser \
        python-etcd \
        pyOpenSSL \
        PySocks \
        requests \
        soupsieve \
        sympy \
        typing_extensions \
        --no-deps

################################################################################
# Copy scripts

# Install additional dependencies for ComfyUI and custom nodes

COPY builder-scripts/generate-pak5.sh  /builder-scripts/generate-pak5.sh
COPY builder-scripts/pak3.txt  /builder-scripts/pak3.txt

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /builder-scripts/pak3.txt

COPY builder-scripts/pak5.txt  /builder-scripts/pak5.txt

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /builder-scripts/pak5.txt

COPY builder-scripts/pak7.txt  /builder-scripts/pak7.txt

RUN pip install -r /builder-scripts/pak7.txt

# for ReActor
RUN pip uninstall --yes onnxruntime onnxruntime-gpu \
    && pip --no-cache-dir install onnxruntime-gpu==1.15.1
#         --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-12/pypi/simple/ \
#     && pip install mediapipe \
#     && pip list


# ComfyUI-MimicMotionWrapper need tensorboard
# pykalman for LivePortraitKJ
RUN pip install tensorboard insightface  pykalman

# fairseq need pip <= 24.0 
# ref https://github.com/facebookresearch/fairseq/issues/5518
# RUN python -m pip install pip==24.0 \
# && apt update \
# && apt install -y portaudio19-dev 
# pip install fairseq

# ffmpeg-python for echo mimic ffmpeg errors， yt_dlp for youtube-dl-comfyui, gguf for gguf
# cpm-kernels for KwaiKolorsWrapper (Kolors)
# aiofiles brotli for comfyui-deploy, pathlib for ComfyUI-Anyline
# RUN pip uninstall  --yes ffmpeg-python python-ffmpeg \
# && pip install ffmpeg-python yt_dlp gguf cpm-kernels \
# && pip install decord bitsandbytes \
# && pip install aiofiles brotli \
# && pip install pathlib

# pip install dlib, insightface, monotonic-align, pyaudio, samplerate

# Runner scripts
COPY runner-scripts/.  /runner-scripts/

################################################################################

# Clean up any unnecessary files to reduce image size
RUN rm -rf /root/.cache /tmp/* /var/tmp/*

# Set up working environment
USER root
VOLUME /root
WORKDIR /root
EXPOSE 8188
ENV CLI_ARGS=""
CMD ["bash","/runner-scripts/entrypoint.sh"]
