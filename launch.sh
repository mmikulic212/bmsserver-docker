#!/bin/bash
set -e

export WINEPREFIX=/home/bms/wine64
export DISPLAY=:1

# Optional: update Falcon BMS
echo "Running Falcon BMS updater..."
wine "C:\\Program Files\\Falcon BMS\\updater.exe" /silent || true

# Start Falcon BMS
echo "Launching Falcon BMS..."
wine "C:\\Program Files\\Falcon BMS\\bms.exe"

# Keep container running
tail -f /dev/null
