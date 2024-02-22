@ECHO OFF

::setlocal enabledelayedexpansion
MODE con:cols=60 lines=10
IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe (%USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe cmd )
TITLE MSS4S5  Run Cycles
CALL :DeviceCheck
IF EXIST %USERPROFILE%\DESKTOP\DTime.bat ( CALL %USERPROFILE%\DESKTOP\DTime.bat)
IF NOT DEFINED BK_Time ( SET BK_Time=5 )
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
start  taskmgr
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
IF EXIST %USERPROFILE%\DESKTOP\DTime.bat ( CALL %USERPROFILE%\DESKTOP\DTime.bat)
IF NOT DEFINED DTime ( SET DTime=10 & ( IF NOT DEFINED DTime ( SET Pin_Num=10 ) ) )
set /a _rand=(%random%*4/32768) + 1
set /a _rand=(%random%*4/32768) + 1

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

IF EXIST %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe (%USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe tabwin --tw 8 4 )


IF NOT DEFINED RSH_Count (
ECHO SET RSH_Count=%RSH_Count% >%USERPROFILE%\DESKTOP\ACount.bat
ECHO SET /A RSH_Count+=1 >>%USERPROFILE%\DESKTOP\ACount.bat
ECHO SET S5_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
ECHO SET S4_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
ECHO SET R_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
ECHO SET MS_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)
IF %_rand% EQU 1 GOTO Hibernate
IF %_rand% EQU 2 GOTO Shutdown
IF %_rand% EQU 3 GOTO Restart
IF %_rand% EQU 4 GOTO MS
GOTO :EOF

:Shutdown
@ECHO @@+++++++++++++++Run S5 Stress+++++++++++++++@@
TIMEOUT /T %DTime% /NOBREAK
IF NOT DEFINED S5_Count (
ECHO SET /A S5_Count=%RSH_Count%+1 >>%USERPROFILE%\DESKTOP\ACount.bat
) ELSE (

 IF DEFINED RSH_Count (
    ECHO SET RSH_Count=%RSH_Count% >%USERPROFILE%\DESKTOP\ACount.bat
    ECHO SET /A RSH_Count+=1 >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S4_Count (
    ECHO SET S4_Count=%S4_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED MS_Count (
    ECHO SET MS_Count=%MS_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED R_Count (
    ECHO SET R_Count=%R_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)
    ECHO SET /A S5_Count=%S5_Count%+1 >>%USERPROFILE%\DESKTOP\ACount.bat
)
CALL :DeviceCheck
start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe S5
pause
GOTO Start

:Restart
@ECHO @@+++++++++++++++Run Restart Stress+++++++++++++++@@
TIMEOUT /T %DTime% /NOBREAK
IF NOT DEFINED R_Count (
ECHO SET R_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
) ELSE (

 IF DEFINED RSH_Count (
    ECHO SET RSH_Count=%RSH_Count% >%USERPROFILE%\DESKTOP\ACount.bat
    ECHO SET /A RSH_Count+=1 >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S4_Count (
    ECHO SET S4_Count=%S4_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED MS_Count (
    ECHO SET MS_Count=%MS_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S5_Count (
    ECHO SET S5_Count=%S5_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)
    ECHO SET /A R_Count=%R_Count%+1 >>%USERPROFILE%\DESKTOP\ACount.bat
)
CALL :DeviceCheck
start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe restart
pause
GOTO Start

:Hibernate
@ECHO @@+++++++++++++++Run Hibernate Stress+++++++++++++++@@
TIMEOUT /T %DTime% /NOBREAK
IF NOT DEFINED S4_Count (
ECHO SET S4_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
) ELSE (
 IF DEFINED RSH_Count (
    ECHO SET RSH_Count=%RSH_Count% >%USERPROFILE%\DESKTOP\ACount.bat
    ECHO SET /A RSH_Count+=1 >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED R_Count (
    ECHO SET R_Count=%R_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S5_Count (
    ECHO SET S5_Count=%S5_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED MS_Count (
    ECHO SET MS_Count=%MS_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

    ECHO SET /A S4_Count=%S4_Count%+1 >>%USERPROFILE%\DESKTOP\ACount.bat
)
CALL :DeviceCheck
start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe S4
ping localhost -n %Pin_Num% >nul 2>&1
TIMEOUT /T %DTime% /NOBREAK
CALL :DeviceCheck
Goto Start

:MS
@ECHO @@+++++++++++++++Run Standby Stress+++++++++++++++@@
TIMEOUT /T %DTime% /NOBREAK
IF NOT DEFINED MS_Count (
ECHO SET MS_Count=%RSH_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
) ELSE (
 IF DEFINED RSH_Count (
    ECHO SET RSH_Count=%RSH_Count% >%USERPROFILE%\DESKTOP\ACount.bat
    ECHO SET /A RSH_Count+=1 >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED R_Count (
    ECHO SET R_Count=%R_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S5_Count (
    ECHO SET S5_Count=%S5_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)

 IF DEFINED S4_Count (
    ECHO SET S4_Count=%S4_Count% >>%USERPROFILE%\DESKTOP\ACount.bat
)
    ECHO SET /A MS_Count=%MS_Count%+1 >>%USERPROFILE%\DESKTOP\ACount.bat
)
CALL :DeviceCheck
start "" /wait /min %USERPROFILE%\DESKTOP\AutoWAT\Manual_MSS4S5Restart.exe MS

ping localhost -n %Pin_Num% >nul 2>&1
TIMEOUT /T %DTime% /NOBREAK
CALL :DeviceCheck
Goto Start

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