@ECHO OFF
COLOR DF
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
SET M_bat=None
For %%I in ( A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z ) DO (
		IF exist %%I:\AutoWAT\Manual_MSS4S5Restart.flg  Set M_bat=%%I
)
IF EXIST %USERPROFILE%\DESKTOP\AutoWAT GOTO copy
MD %USERPROFILE%\DESKTOP\AutoWAT
:copy
IF M_bat=="None" ( exit 1 )
 robocopy  %M_bat%:\Test  %USERPROFILE%\DESKTOP  /mt  /z /copyall  /ETA    /E 
 robocopy  %M_bat%:\AutoWAT  %USERPROFILE%\DESKTOP\AutoWAT  /mt  /z /copyall  /ETA    /E
:choose
@ECHO The Unit System Vol is:  %M_bat%
del  /Q /F "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart*.*"
del  /Q /F %USERPROFILE%\DESKTOP\GO
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ECHO @@@@@ Please Choose Your's Manual Stress @@@@@
@ECHO @@@@@      M/m is Standby stress         @@@@@
@ECHO @@@@@      S/s is S5/ShutDown stress     @@@@@
@ECHO @@@@@      H/h is S4/Hibernate stress    @@@@@
@ECHO @@@@@      R/r is   Restart   stress     @@@@@
@ECHO @@@@@      A/a is      ALL    stress     @@@@@
@ECHO @@@@@      U/u is      Human  stress     @@@@@
@ECHO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
choice /c:RHSMOAU /m:"Please Select: "
if %errorlevel%==7 goto Man_Human
if %errorlevel%==6 goto ALL
if %errorlevel%==5 goto OverNight
if %errorlevel%==4 goto MS
if %errorlevel%==3 goto S
if %errorlevel%==2 goto H
if %errorlevel%==1 goto R
pause
goto FAIL
:R
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-R.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-R.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-R.bat"
GOTO :EOF

:H
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S4.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S4.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-S4.bat"
GOTO :EOF

:S
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S5.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S5.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-S5.bat"
GOTO :EOF

:ALL
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S5.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-ALL.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-ALL.bat"
GOTO :EOF

:Man_Human
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-Human.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-Human.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-Human.bat"
GOTO :EOF

:MS
IF NOT EXIST %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-S5.bat GOTO FAIL
XCOPY %M_bat%:\WAT_STRESS\Manual_MSS4S5Restart-MS.bat   "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\*.*"  /y
mklink %USERPROFILE%\DESKTOP\GO "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Manual_MSS4S5Restart-MS.bat"
GOTO :EOF

:OverNight
IF EXIST %USERPROFILE%\DESKTOP\OverNight GOTO CP
MD %USERPROFILE%\DESKTOP\OverNight
:CP
XCOPY %M_bat%:\OverNight\*.*  %USERPROFILE%\DESKTOP\OverNight\. /Y /E
:Overnight
IF EXIST %USERPROFILE%\DESKTOP\OverNight\OverNightStress.bat (START "OverNightStress" %USERPROFILE%\DESKTOP\OverNight\OverNightStress.bat & exit 0)
GOTO :EOF

:FAIL
COLOR 1C
ECHO %OSVOL%:\%PASS_FLG%
ECHO CAN NOT FIND PATCH!!!
ECHO CAN NOT FIND PATCH!!!
ECHO CAN NOT FIND PATCH!!!
PAUSE