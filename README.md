﻿# Falcon BMS Server Docker Image (Headless)

This Docker image installs and runs Falcon 4 and Falcon BMS in a headless Wine environment with PulseAudio dummy sink.

## Features

- Steam or offline installer for Falcon 4
- Automatic Falcon BMS install with update support
- Persistent Wine prefix and installers
- Runtime toggle for (re)installation
- Supervisor-managed launch

## Usage

```bash
docker run -it \
  -e INSTALL_ON_START=true \
  -v $(pwd)/installers:/home/bms/installers \
  -v $(pwd)/wine64:/home/bms/wine64 \
  falcon-bms
