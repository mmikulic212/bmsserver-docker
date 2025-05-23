FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/home/bms/wine64
ENV DISPLAY=:1

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wine64 \
        wine32 \
        winetricks \
        aria2 \
        pulseaudio \
        xvfb \
        x11vnc \
        fluxbox \
        xterm \
        supervisor \
        wget \
        unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user and directories
RUN useradd -m -d /home/bms bms && \
    mkdir -p /home/bms/wine64 /home/bms/installers && \
    chown -R bms:bms /home/bms

WORKDIR /home/bms

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY install.sh launch.sh entrypoint.sh ./

RUN chmod +x install.sh launch.sh entrypoint.sh

USER bms

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
