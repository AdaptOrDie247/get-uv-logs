
:: Get UV Logs
:: License: MIT License
:: Author: Daniel Gilbert

:: Summary:
:: - A simple script to copy UltraViewer log files with network and system info to a folder on USB.
:: - Can be used for forensics after an incident.

:: Usage:
:: 1. Copy get-uv-logs.bat to an empty USB drive.
:: 2. Run get-uv-logs.bat from USB drive on target host as victim user account of incident.
:: 3. Files and info will be copied to the appropriate destination directories.

:: Notes:
:: - Tested using install (exe) version of UltraViewer 6.6 on Windows 10 Pro.

@echo off

:: This is the default path to the UltraViewer logs directory.
:: This is based on the install (exe) version of the software, not the portable (zip) version.
set "UV_LOGS_PATH=%appdata%\UltraViewer"

:: Destination directory for where to copy the logs files to.
set "COPY_DEST=.\copied-from-host"

:: Destination directory for where to copy the host environment info to.
set "ENV_INFO_DEST=.\env-info"

echo.
echo Ensuring USB destination directories exist...
echo.

mkdir %COPY_DEST%
mkdir %ENV_INFO_DEST%

echo.
echo Copying UltraViewer logs and configurations...
echo.

robocopy /e %UV_LOGS_PATH% %COPY_DEST%

echo.
echo Getting external IP of host network...
echo.

curl ifconfig.me > %ENV_INFO_DEST%\external-ip.txt

echo.
echo Getting local network info...
echo.

ipconfig /all > %ENV_INFO_DEST%\ipconfig-all.txt

echo Getting system information...
echo.

:: This should include the time zone information, which is critical.
systeminfo > %ENV_INFO_DEST%\system-info.txt

echo Operation complete.
echo.

pause

