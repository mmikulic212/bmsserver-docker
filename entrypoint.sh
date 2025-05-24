#!/bin/bash
set -e

export WINEPREFIX=/home/bms/wine64
export DISPLAY=:1

FALCON4_FLAG="./.falcon4installed"
BMS_FLAG="./.bmsinstalled"

INSTALL_FLAG="${INSTALL_ON_START,,}"  # lowercase normalization

# Check if Falcon BMS and Falcon 4 are installed
if [ "$INSTALL_FLAG" = "true" ] || \
   [ ! -f "$FALCON4_FLAG" ] || \
   [ ! -f "$BMS_FLAG" ]; then
  echo "Install required: INSTALL_ON_START=$INSTALL_ON_START or missing installation."
  /home/bms/install.sh
else
  echo "Falcon BMS and Falcon 4 appear installed. Skipping install."
fi

exec /home/bms/launch.sh
