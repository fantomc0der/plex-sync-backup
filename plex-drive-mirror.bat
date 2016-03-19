@ECHO OFF

:: Syncs an entire (Plex media) drive to a backup drive
:: Make sure that any USB drives are explicitly assigned drive letters so after reconnection this script wont target an incorrect path

:: Ensure sync log directory exists
IF NOT EXIST "C:\plex_sync_logs" MKDIR C:\plex_sync_logs

:: Sync each media drive to its backup drive
CALL :SYNC_DRIVE "Anime" "E:\" "R:\"
CALL :SYNC_DRIVE "Movies" "F:\" "S:\"
CALL :SYNC_DRIVE "Television" "G:\" "T:\"

:: Exit from main logic
EXIT /B %ERRORLEVEL%

:: Function that syncs a source drive to a destination backup drive, ignoring any root directories prefixed with "_temp".
:: (arguments: Name, SourceDirectory, DestinationDirectory)
:SYNC_DRIVE
@ECHO Starting sync for %~1 (%date% %time%)... >> C:\plex_sync_logs\%~1%-log.txt
ROBOCOPY %~2 %~3 /MIR /XJD /MT:4 /R:10 /W:60 /XA:SHT /log+:C:\plex_sync_logs\%~1%-log.txt /XD _temp* $* "System Volume Information*" /XF *.dat *.sys *.db *.log
EXIT /B 0
