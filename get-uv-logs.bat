
:: Get UV Logs
:: License: MIT License
:: Author: Daniel Gilbert

:: Summary:
:: - A simple script to copy UltraViewer log files with network and system info to a folder on USB.
:: - Can be used for forensics after an incident.

:: Usage:
:: 1. Copy get-uv-logs.bat to an empty USB drive.
:: 2. Open USB drive in File Explorer on target host.
:: 3. Right click get-uv-logs.bat then click "Run as administrator".
:: 4. Files and info will be copied to the appropriate destination directories.

:: Notes:
:: - Tested using install (exe) version of UltraViewer 6.6 on Windows 10 Pro.

@echo off

:: This is the default path to the UltraViewer logs directory.
:: This is based on the install (exe) version of the software, not the portable (zip) version.
set "UV_LOGS_PATH=%appdata%\UltraViewer"

:: This path is the save location for the logs files.
set "COPY_DEST=.\copied-from-host\"

:: This path is the save location for the host environment info.
set "ENV_INFO_DEST=.\env-info\"

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

