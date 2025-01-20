@ECHO OFF
:: Syncs Plex Server related application data and management scripts

:: Create the new backup directory
SET backupdirname=Plex_Server_Backup_%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%
IF NOT EXIST "A:\%backupdirname%\" MKDIR "A:\%backupdirname%"

:: Backup scripts
COPY C:\clear-plex-cache.bat "A:\%backupdirname%"
COPY C:\plex-backup-media.bat "A:\%backupdirname%"
COPY C:\plex-backup-server.bat "A:\%backupdirname%"

:: Backup sync logs
robocopy "C:\plex_sync_media_logs" "A:\%backupdirname%\plex_sync_media_logs" /mir /r:3 /w:5 /log:"A:\%backupdirname%\sync-media-logs-backup.log"

:: Backup Tautulli appdata
robocopy "%LOCALAPPDATA%\Tautulli" "A:\%backupdirname%\Tautulli" /mir /r:3 /w:5 /log:"A:\%backupdirname%\tautulli-backup.log"

:: Backup Plex appdata
robocopy "%LOCALAPPDATA%\Plex Media Server" "A:\%backupdirname%\PlexServer\AppData" /mir /r:3 /w:5 /xd "%LOCALAPPDATA%\Plex Media Server\Cache" "%LOCALAPPDATA%\Plex Media Server\Crash Reports" "%LOCALAPPDATA%\Plex Media Server\Logs" "%LOCALAPPDATA%\Plex Media Server\Updates" "%LOCALAPPDATA%\Plex Media Server\Media\localhost" /log:"A:\%backupdirname%\plexserver-appdata-backup.log"
reg EXPORT "HKCU\SOFTWARE\Plex, Inc." "A:\%backupdirname%\PlexServer\plex-inc.reg" /y