@ECHO OFF
:: Syncs an entire (Plex media) drive to a backup drive
:: Make sure that any USB drives are explicitly assigned drive letters so after reconnection this script wont target an incorrect path

:: Ensure parent sync log directory exists
IF NOT EXIST "C:\plex_sync_media_logs" MKDIR "C:\plex_sync_media_logs"

:: Ensure session sync log directory exists
SET logoutputdirname=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
IF NOT EXIST "C:\plex_sync_media_logs\%logoutputdirname%\" MKDIR "C:\plex_sync_media_logs\%logoutputdirname%"

:: Sync each media drive to its backup drive
CALL :SYNC_DRIVE "Media1" "E:\" "R:\"
CALL :SYNC_DRIVE "Media2" "F:\" "S:\"
CALL :SYNC_DRIVE "Media3" "G:\" "T:\"
CALL :SYNC_DRIVE "Media4" "H:\" "U:\"
CALL :SYNC_DRIVE "Media5" "I:\" "V:\"
CALL :SYNC_DRIVE "Media6" "J:\" "W:\"

:: Exit from main logic
EXIT /B %ERRORLEVEL%

:: Function that syncs a source drive to a destination backup drive, ignoring any root directories prefixed with "_temp".
:: (arguments: Name, SourceDirectory, DestinationDirectory)
:SYNC_DRIVE
@ECHO Starting sync for %~1 (%date% %time%)... >> C:\plex_sync_media_logs\%logoutputdirname%\%~1%-log.txt
ROBOCOPY %~2 %~3 /MIR /XJD /MT:4 /R:10 /W:60 /XA:SHT /NP /log+:C:\plex_sync_media_logs\%logoutputdirname%\%~1%-log.txt /XD _temp* $* Recovery "System Volume Information*" /XF *.dat *.sys *.db *.log
EXIT /B 0
