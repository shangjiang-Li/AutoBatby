@ECHO OFF
DEL /F /Q  "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart*.*" 
DEL  /Q /F %USERPROFILE%\DESKTOP\GO
pause
IF EXIST %M_bat%:\Find_UsbKey.bat  Call %M_bat%:\Find_UsbKey.bat
PAUSE
SHUTDOWN -R -T 0
goto :eof
