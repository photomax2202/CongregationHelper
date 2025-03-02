@echo off
setlocal

rem Setze den Pfad zur ausführbaren Datei
set LOCAL_PATH=%~dp0
set EXE_FILE=%LOCAL_PATH%\CongregationHelper.exe
set OLD_VERSION_INFO = %LOCAL_PATH%\VersionInfo.txt

rem Prüfen, ob die Datei existiert und sie löschen, falls vorhanden
if exist "%OLD_VERSION_INFO%" (
    del "%OLD_VERSION_INFO%"
    echo Datei wurde erfolgreich gelöscht.
) else (
    echo Datei existiert nicht.
)

rem Temporäre Datei für die Versionsinformationen
set TEMP_FILE=%TEMP%\VersionInfo.txt

rem Versionsinformationen aus der EXE-Datei auslesen
powershell "(Get-Command %EXE_FILE%).FileVersionInfo | Out-File %TEMP_FILE%"

rem Versionsinformationen in Textdatei speichern
type %TEMP_FILE% > VersionInfo.txt

rem Temporäre Datei löschen
del %TEMP_FILE%

echo Versionsinformationen wurden in VersionInfo.txt gespeichert.
endlocal
pause
