FROM nvidia/cuda:11.6.2-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt-get install -y ffmpeg wget git curl python3 python3-venv python3-pip libgl1 libglib2.0-0

# Entrypoint
COPY ./entrypoint.sh /entrypoint.sh
COPY ./idle.sh /idle.sh

RUN chmod +x /entrypoint.sh \
    && chmod +x /idle.sh

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu

WORKDIR /app_dev

RUN wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh \
    && chmod +x ./webui.sh && ./webui.sh --xformers

ENTRYPOINT ["/idle.sh"]
#ENTRYPOINT ["/entrypoint.sh"]