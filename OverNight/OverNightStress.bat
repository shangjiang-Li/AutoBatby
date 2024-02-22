@ECHO OFF
::setlocal enabledelayedexpansion

@REM under Windows env
ECHO ===========================================
:: BatchGotAdmin
ECHO ===========================================
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    wscript "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


REM ===========================================

CD /D "%~dp0"
SET USB_Vol=%~d0
SET PWD=%~dp0
:RunOverNight
MODE con:cols=60 lines=10
TITLE WAT OverNight Stress
TIMEOUT /T 5 /NOBREAK
start /wait "" "https://baidu.com"
TIMEOUT /T 5 /NOBREAK
start /wait microsoft.windows.camera:
TIMEOUT /T 5 /NOBREAK
START devmgmt.msc
TIMEOUT /T 5 /NOBREAK
start /wait explorer shell:mycomputerfolder
TIMEOUT /T 5 /NOBREAK
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

set "extractdate=%date:~-4,4%%date:~-10,2%%date:~-7,2%"+'000000'
set "extracttime=%time:~-12,2%%time:~-8,2%%time:~-5,2%
set Time_str=_%extractdate%%extracttime%
IF EXIST %USERPROFILE%\DESKTOP\OverNight\EC_LogFile.txt ( REN EC_LogFile.TXT EC_LogFile%Time_str%.TXT )

timeout /t 5 /nobreak
IF EXIST %USERPROFILE%\DESKTOP\OverNight\EC_Monitor_Pav_v22.EXE ( start "" %USERPROFILE%\DESKTOP\OverNight\EC_Monitor_Pav_v22.EXE )
mklink %USERPROFILE%\DESKTOP\GoNight  %USERPROFILE%\DESKTOP\OverNight\OverNightStress.bat
EXIT 0
GOTO :EOF
:FAIL
PAUSE
GOTO FAIL

