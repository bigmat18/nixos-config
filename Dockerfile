# syntax=docker/dockerfile:1
FROM nvidia/cuda:12.9.1-devel-ubuntu24.04

USER root
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        apt-transport-https ca-certificates dbus fontconfig gnupg \
        libasound2t64 libfreetype6 libglib2.0-0 libnss3 libsqlite3-0 \
        libx11-xcb1 libxcb-glx0 libxcb-xkb1 libxcomposite1 libxcursor1 \
        libxdamage1 libxi6 libxml2 libxrandr2 libxrender1 libxtst6 \
        libgl1 libglx-mesa0 libxkbfile-dev \
        openssh-client wget xcb dnsutils telnet iproute2 iputils-ping \
        xkb-data openjdk-21-jdk qt6-base-dev \
        cmake ninja-build zsh git locales sudo nano vim curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && \
    cd /tmp && \
    wget https://developer.nvidia.com/downloads/assets/tools/secure/nsight-systems/2025_3/nsight-systems-2025.3.1_2025.3.1.90-1_amd64.deb && \
    apt-get install -y ./nsight-systems-2025.3.1_2025.3.1.90-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN apt-get update && \
    apt-get install -y kmod net-tools wget && \
    touch /etc/modules && \
    mkdir -p /lib/modules/$(uname -r) && \
    rm -f /usr/sbin/modprobe && \
    echo '#!/bin/sh\nexit 0' > /usr/sbin/modprobe && \
    chmod +x /usr/sbin/modprobe && \
    cd /tmp && \
    wget -q https://software.sonicwall.com/CT-NX-VPNClients/CT-12.5.0/ConnectTunnel_Linux64-12.50.00212.tar && \
    tar -xf ConnectTunnel_Linux64-12.50.00212.tar && \
    ./install.sh && \
    rm -rf /tmp/*

RUN userdel -r ubuntu && \
    useradd -m -u 1000 -s /bin/zsh bigmat18 && \
    usermod -aG sudo bigmat18 && \
    echo "bigmat18 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/bigmat18

USER bigmat18
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

SHELL ["/bin/zsh", "-c"]
CMD ["zsh"]