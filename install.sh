#!/bin/bash
set -e

export WINEPREFIX=/home/bms/wine64
export DISPLAY=:1

INSTALLERS_DIR="/home/bms/installers"
BMS_SETUP_DIR="/home/bms/bms_setup"

BMS_TORRENT_URL="magnet:?xt=urn:btih:ab7b93b5daf0d4cb3e2547fc536b580ad9b18b8c&dn=Falcon%20BMS_4.37.6_Full_Setup&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce"
TORRENT_INSTALLER="$BMS_SETUP_DIR/Falcon BMS_4.37.6_Full_Setup/Falcon BMS_4.37.6_Full_Setup.exe"
FALCON4_OFFLINE_INSTALLER="$INSTALLERS_DIR/setup_falcon_4_2.0.0.1.exe"

mkdir -p "$BMS_SETUP_DIR"

# Initialize wineprefix and install required components
if [ ! -f "$WINEPREFIX/system.reg" ]; then
  echo "Initializing Wine prefix..."
  WINEARCH=win64 WINEPREFIX=$WINEPREFIX wineboot --init
  sleep 10
  echo "Installing Winetricks components: dotnet48, vcrun2015, dxvk..."
  WINEPREFIX=$WINEPREFIX winetricks -q dotnet48 vcrun2015 dxvk
else
  echo "Wine prefix already initialized."
fi

# Install Falcon 4 (Steam or offline)
#if [ -n "$STEAM_USER" ] && [ -n "$STEAM_PASS" ]; then
#  echo "Installing Falcon 4 via SteamCMD..."
#  steamcmd +login "$STEAM_USER" "$STEAM_PASS" +force_install_dir "$WINEPREFIX/drive_c/Program Files/Falcon 4.0" +app_update 429530 validate +quit
#else
#  INSTALLER=$(find /home/bms/installers -type f -iname 'falcon*.exe' | head -n1)
#  if [ -z "$INSTALLER" ]; then
#    echo "No Falcon 4 offline installer found in /home/bms/installers"
#    exit 1
#  fi
#  echo "Installing Falcon 4 from $INSTALLER..."
#  wine "$INSTALLER" /S
#  touch "./.falcon4installed"

#fi
#

# Install Falcon BMS from torrent if not installed
if [ ! -f "$TORRENT_INSTALLER" ]; then
  echo "Downloading Falcon BMS installer via torrent..."
  aria2c --dir="$BMS_SETUP_DIR" --out="Falcon BMS_4.37.6_Full_Setup.exe" --console-log-level=warn --seed-time=0 "$BMS_TORRENT_URL"
else
  echo "Falcon BMS installer is downloaded. Skipping download."
fi

#
## Install Falcon BMS
#mkdir -p /home/bms/bms
#cd /home/bms/bms
#wine "$BMS_INSTALLER" /S
#touch "./.bmsinstalled"


echo "Installation complete."
