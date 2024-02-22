@ECHO OFF
MODE con:cols=60 lines=10
IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe ( start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe cmd )
TITLE S4  Run Cycles
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
TIMEOUT /T 5 /NOBREAK
start /wait "" "https://baidu.com"
TIMEOUT /T 5 /NOBREAK
start /wait microsoft.windows.camera:
TIMEOUT /T 5 /NOBREAK
START devmgmt.msc
TIMEOUT /T 5 /NOBREAK
start /wait explorer shell:mycomputerfolder
TIMEOUT /T 5 /NOBREAK
@ECHO.
@ECHO ====================================
@ECHO ==      Manual_MSS4S5Restart      ==
@ECHO ==      Manual_MSS4S5Restart      ==
@ECHO ====================================
@ECHO.
CD /D "%~dp0"
COLOR 0A
@ECHO.

:RUN
CALL :DeviceCheck
SET M_bat=None
For %%I in ( A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z ) DO (
		IF exist %%I:\AutoWAT\Manual_MSS4S5Restart.flg  Set M_bat=%%I
)

IF EXIST %USERPROFILE%\DESKTOP\DTime.bat ( CALL %USERPROFILE%\DESKTOP\DTime.bat)
IF NOT DEFINED DTime ( SET DTime=10 & ( IF NOT DEFINED DTime ( SET Pin_Num=10 ) ) )
IF EXIST %USERPROFILE%\DESKTOP\Count.bat ( CALL %USERPROFILE%\DESKTOP\Count.bat)

IF NOT DEFINED Count (
ECHO SET Count=%Count% >%USERPROFILE%\DESKTOP\Count.bat
ECHO SET /A Count+=1 >>%USERPROFILE%\DESKTOP\Count.bat
ECHO SET SET HCount=%HCount% >>%USERPROFILE%\DESKTOP\Count.bat
ECHO SET /A HCount+=1 >>%USERPROFILE%\DESKTOP\Count.bat
) ELSE ( 
ECHO SET Count=%Count% >%USERPROFILE%\DESKTOP\Count.bat 
ECHO SET /A Count+=1 >>%USERPROFILE%\DESKTOP\Count.bat
IF DEFINED RCount (
ECHO SET RCount=%RCount% >>%USERPROFILE%\DESKTOP\Count.bat
)
IF DEFINED SCount (
ECHO SET SCount=%SCount% >>%USERPROFILE%\DESKTOP\Count.bat
) 
IF DEFINED MSCount (
ECHO SET MSCount=%MSCount% >>%USERPROFILE%\DESKTOP\Count.bat
) 
ECHO SET HCount=%HCount% >>%USERPROFILE%\DESKTOP\Count.bat 
ECHO SET /A HCount+=1 >>%USERPROFILE%\DESKTOP\Count.bat
)
CLS
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ECHO @@      Total Count: %Count%           @@
IF DEFINED MSCount (
@ECHO @@      MS Count: %MSCount%             @@
)
IF DEFINED RCount (
@ECHO @@      Restart Count: %RCount%        @@
)
IF DEFINED SCount (
@ECHO @@      S5 Count: %SCount%             @@
)
@ECHO @@      S4  Run Cycles            @@
@ECHO @@              %HCount%               @@
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

IF EXIST %M_bat%:\del.bat (START /MIN %M_bat%:\del.bat & exit)
@ECHO The Tester User's Vol is:  %M_bat%

IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe ( start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe tabwin --tw 7 4 )

pause
TIMEOUT /T %DTime% /NOBREAK
CALL :DeviceCheck
start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe S4
ping localhost -n %Pin_Num% >nul 2>&1
TIMEOUT /T %DTime% /NOBREAK
GOTO RUN

::Device check
:DeviceCheck
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