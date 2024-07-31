@echo off
echo Detecting USB Cameras...
echo.

rem Create a temporary file to store USB devices information
set tempFile=usb_devices.txt
del %tempFile% 2>nul

rem List all USB devices and save to the temp file
wmic path Win32_PnPEntity get Description, DeviceID /format:list > %tempFile%

rem Output the list of devices
echo All USB devices detected:
type %tempFile%
echo.

rem Search for devices that might be cameras
echo Checking for USB video devices...
echo.

rem Initialize a flag to check if any camera is found
set cameraFound=false

rem Process the temporary file
for /f "tokens=1,* delims==" %%A in (%tempFile%) do (
    if "%%A"=="Description" set "description=%%B"
    if "%%A"=="DeviceID" (
        rem Check if the description contains "camera" or "video"
        echo %description% | findstr /i "camera video" >nul
        if %errorlevel%==0 (
            echo Found camera or video device:
            echo Description: %description%
            echo DeviceID: %%B
            echo.
            set cameraFound=true
        )
    )
)

if not %cameraFound%==true (
    echo No USB camera detected.
)

echo Detection Complete.
pause
