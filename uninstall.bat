@echo off
@rem     _   _                             _
@rem    / \ | |_ _ __ ___   ___  ___ _ __ | |__   ___ _ __ ___
@rem   / _ \| __| '_ ` _ \ / _ \/ __| '_ \| '_ \ / _ \ '__/ _ \
@rem  / ___ \ |_| | | | | | (_) \__ \ |_) | | | |  __/ | |  __/
@rem /_/   \_\__|_| |_| |_|\___/|___/ .__/|_| |_|\___|_|  \___|
@rem                                |_|
@rem uninstall/backup script for Windows

@rem sets the path params
set ATMOSPHERE_MAVEN_LOCAL=%HOMEPATH%\.m2\repository\com\musala\atmosphere
set GRADLE_CACHES_DIR=%HOMEPATH%\.gradle\caches
set GRADLE1=%GRADLE_CACHES_DIR%\modules-2\files-2.1\com.musala.atmosphere
set GRADLE2=%GRADLE_CACHES_DIR%\modules-2\metadata-2.16\descriptors\com.musala.atmosphere

@rem sets some util variables
set BACKUP_OPTION=-b
set HELP_OPTION=-h
set UNINSTALL_OPTION=-u
set LOG_FILE=uninstall.log

set DIRECTORIES=%ATMOSPHERE_MAVEN_LOCAL% %GRADLE1% %GRADLE2%

goto validateOptions

:doUninstallOrBackup
@rem prints and log a timestamp 
for /F "usebackq tokens=1" %%i in (`powershell get-date -format yyyy-MM-dd-hh-mm-ss`) do set TIMESTAMP=%%i
echo. && echo. >> %LOG_FILE%
for /F "tokens=*" %%I IN ('echo *******************') DO ECHO %%I & ECHO %%I >> %LOG_FILE%
for /F "tokens=*" %%I IN ('echo %TIMESTAMP%') DO ECHO %%I & ECHO %%I >> %LOG_FILE%
for /F "tokens=*" %%I IN ('echo *******************') DO ECHO %%I & ECHO %%I >> %LOG_FILE%
echo. && echo. >> %LOG_FILE%

for %%D in (%DIRECTORIES%) do (
    if exist %%D (
	    if "%~1"=="%BACKUP_OPTION%" (
		    @rem for %%a in (%%D) do set FOLDER_NAME=%%~na
			for %%* in ("%%D") do set FOLDER_NAME=%%~nx*
		    rename %%D "%FOLDER_NAME%-%TIMESTAMP%.bak"
			
			FOR /F "tokens=*" %%I IN ('echo [INFO] The "%%D" directory is successfully backed up'
			) DO ECHO %%I & ECHO %%I >> %LOG_FILE%
	    ) else (
		    rmdir /s /q %%D
			
	        FOR /F "tokens=*" %%I IN ('echo [INFO] The "%%D" directory is removed successfully.'
			) DO ECHO %%I & ECHO %%I >> %LOG_FILE%
		)
    ) else (
	    FOR /F "tokens=*" %%I IN ('echo The "%%D" directory does not exists. Nothing to remove/backup.'
		) DO ECHO %%I & ECHO %%I >> %LOG_FILE%
    )
)

echo DONE
exit /b

@rem interrupts the script due incorrect options
:validateOptions
if "%~2" neq "" (
    echo [ERROR] Only one option is allowed.
	goto printHelp
)

if "%~1" neq "%HELP_OPTION%" (
if "%~1" neq "%BACKUP_OPTION%" (
if "%~1" neq "%UNINSTALL_OPTION%" (
if "%~1" neq "" (
    echo [ERROR] Unexpected option: %~1
	goto printHelp
))))

if "%~1"=="%HELP_OPTION%" (
    goto printHelp
)

goto doUninstallOrBackup

@rem prints the usage 
:printHelp
echo Usage: `uninstall.bat [-h]` or `uninstall.bat [-b]`
echo where
echo    -h  show the help
echo    -b  remomove and backup the Atmospgere packages
echo    -u  uninstall the Atmospgere packages. Default option