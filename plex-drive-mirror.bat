@ECHO OFF

:: Syncs an entire (Plex media) drive to a backup drive
:: Make sure that any USB drives are explicitly assigned drive letters so after reconnection this script wont target an incorrect path

:: Ensure sync log directory exists
IF NOT EXIST "C:\sync_logs" MKDIR C:\sync_logs

:: Sync each media drive to its backup drive
CALL :SYNC_DIRECTORY "Anime" "E:\" "R:\"
CALL :SYNC_DIRECTORY "Movies" "F:\" "S:\"
CALL :SYNC_DIRECTORY "Television" "G:\" "T:\"

:: Exit from main logic
EXIT /B %ERRORLEVEL%

:: Function that syncs a source directory to a destination backup directory, ignoring any root directory prefixed with "_temp".
:: (arguments: Name, SourceDirectory, DestinationDirectory)
:SYNC_DIRECTORY
@ECHO Starting sync for %~1 (%date% %time%)... >> C:\sync_logs\log.txt
ROBOCOPY %~2 %~3 /MIR /XJD /MT:4 /R:10 /W:60 /XA:SHT /log+:C:\sync_logs\log.txt /XD _temp* $* "System Volume Information*" /XF *.dat *.sys *.db *.log
EXIT /B 0
