@ECHO OFF

::setlocal enabledelayedexpansion
MODE con:cols=60 lines=10
IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe ( %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe cmd )
TITLE Human Run Cycles
CALL :DeviceCheck
IF EXIST %USERPROFILE%\DESKTOP\DTime.bat ( CALL %USERPROFILE%\DESKTOP\DTime.bat)
IF NOT DEFINED BK_Time ( SET BK_Time=5 )
start  taskmgr
TIMEOUT /T %BK_Time% /NOBREAK
setlocal enabledelayedexpansion
set "video_path=%USERPROFILE%\DESKTOP\WAT\*.mp4"
for %%a in (%video_path%) do set /a n+=1
set /a m=%random%%%%n%
if %m% equ 0 set m=%n%

for %%a in (%video_path%) do (
set /a counter+=1
if !counter! equ %m% start %%a
)
endlocal

TIMEOUT /T %BK_Time% /NOBREAK
start /wait "" "https://baidu.com"
TIMEOUT /T %BK_Time% /NOBREAK
start /wait microsoft.windows.camera:
TIMEOUT /T %BK_Time% /NOBREAK
START devmgmt.msc
TIMEOUT /T %BK_Time% /NOBREAK
start /wait explorer shell:mycomputerfolder
TIMEOUT /T %BK_Time% /NOBREAK

@ECHO.
@ECHO ====================================
@ECHO ==      Manual_MSS4S5Restart      ==
@ECHO ==      Manual_MSS4S5Restart      ==
@ECHO ====================================
@ECHO.
CD /D "%~dp0"
COLOR 0A
@ECHO.

:Start
IF EXIST %USERPROFILE%\DESKTOP\ACount.bat ( CALL %USERPROFILE%\DESKTOP\ACount.bat)
SET M_bat=None
For %%I in ( A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z ) DO (
		IF exist %%I:\AutoWAT\Manual_MSS4S5Restart.flg  Set M_bat=%%I
)
IF EXIST %M_bat%:\del.bat (START /MIN %M_bat%:\del.bat & exit)
@ECHO The Tester User's Vol is:  %M_bat%

cls
@ECHO.
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ECHO @@  Restart+MS+S5+S4  Run Cycles     @@
@ECHO @@        Total: %RSH_Count%           @@
@ECHO @@      Restart: %R_Count%             @@
@ECHO @@           S5: %S5_Count%            @@
@ECHO @@           S4: %S4_Count%            @@
@ECHO @@           MS: %MS_Count%            @@
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ECHO.
TIMEOUT /T 5 /NOBREAK 
IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe ( start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe tabwin --tw 8 4 )
GOTO END

::Device check
@ECHO ---------- UUT DM/Device check run ---------- 
   IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe ( %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe YB )
   if %ErrorLevel%  NEQ  0 (goto Capture )
   GOTO PASS
:Capture
IF NOT EXIST %USERPROFILE%\DESKTOP\WatCheckYB\Whitelist.txt (  ECHO "ECHO IS FOR YB"> %USERPROFILE%\DESKTOP\WatCheckYB\Whitelist.txt)
setlocal enabledelayedexpansion
set "Whitelist=%USERPROFILE%\DESKTOP\WatCheckYB\Whitelist.txt" 
set "YB_path=%USERPROFILE%\DESKTOP\WatCheckYB\*.log" 
set "Whitelist=%USERPROFILE%\DESKTOP\WatCheckYB\Whitelist.txt" 
set "YB_file=%USERPROFILE%\DESKTOP\WatCheckYB\*.log" 
set "YB_path=%USERPROFILE%\DESKTOP\WatCheckYB\" 
   for /F "tokens=* delims=" %%a in ('dir /b %YB_file%') do  ( 
      FOR /F "tokens=2 delims=:" %%x in (%YB_path%%%a) DO ( 
             if  not  "%%x"==" " ( CALL :CheckWhitelist "%Whitelist%"  "%%x" )
      )
  )
endlocal
GOTO PASS
:always 
pause
  IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Capture_DeviceManager.exe ( %USERPROFILE%\DESKTOP\AutoWAT\Capture_DeviceManager.exe )
  GOTO DeviceCheck
:PASS

 @ECHO ************* DM Check PASS *************
 @ECHO ************* DM Check PASS *************
 @ECHO ---------- UUT DM/Device check run ---------- 
GOTO :EOF

:CheckWhitelist
             type %~1 | find /i "%~2"
             if %ERRORLEVEL%==1  goto always
GOTO :EOF
::Device check
:END
 EXIT 0