#!/bin/bash
set -e

export WINEPREFIX=/home/bms/wine64
export DISPLAY=:1

# Initialize Wine prefix
if [ ! -d "$WINEPREFIX/dosdevices" ]; then
  echo "Initializing Wine prefix..."
  wineboot --init
  sleep 10
fi

# Install core dependencies
echo "Installing winetricks packages..."
winetricks -q dotnet48 vcrun2015 dxvk

# Install Falcon 4 (Steam or offline)
if [ -n "$STEAM_USER" ] && [ -n "$STEAM_PASS" ]; then
  echo "Installing Falcon 4 via SteamCMD..."
  steamcmd +login "$STEAM_USER" "$STEAM_PASS" +force_install_dir "$WINEPREFIX/drive_c/Program Files/Falcon 4.0" +app_update 22380 validate +quit
else
  INSTALLER=$(find /home/bms/installers -type f -iname 'falcon*.exe' | head -n1)
  if [ -z "$INSTALLER" ]; then
    echo "No Falcon 4 offline installer found in /home/bms/installers"
    exit 1
  fi
  echo "Installing Falcon 4 from $INSTALLER..."
  wine "$INSTALLER" /S
fi

# Download or use cached Falcon BMS installer
BMS_INSTALLER="/home/bms/installers/bmsinstaller.exe"
if [ ! -f "$BMS_INSTALLER" ]; then
  echo "Downloading Falcon BMS installer..."
  curl -L -o "$BMS_INSTALLER" https://github.com/FalconBMS/Falcon-Installer/releases/latest/download/bmsinstaller.exe
else
  echo "Using cached Falcon BMS installer."
fi

# Install Falcon BMS
mkdir -p /home/bms/bms
cd /home/bms/bms
wine "$BMS_INSTALLER" /S

echo "Installation complete."
