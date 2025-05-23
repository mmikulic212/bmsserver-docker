#!/bin/bash
set -e

export WINEPREFIX=/home/bms/wine64
export DISPLAY=:1

FALCON4_DIR="$WINEPREFIX/drive_c/Program Files/Falcon 4.0"
FALCONBMS_DIR="$WINEPREFIX/drive_c/Program Files/Falcon BMS"

INSTALL_FLAG="${INSTALL_ON_START,,}"  # lowercase normalization

# Check if Falcon BMS and Falcon 4 are installed
if [ "$INSTALL_FLAG" = "true" ] || \
   [ ! -d "$FALCON4_DIR" ] || \
   [ ! -d "$FALCONBMS_DIR" ]; then
  echo "Install required: INSTALL_ON_START=$INSTALL_ON_START or missing installation."
  /home/bms/install.sh
else
  echo "Falcon BMS and Falcon 4 appear installed. Skipping install."
fi

exec /home/bms/launch.sh
