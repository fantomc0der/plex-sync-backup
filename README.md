# Plex Sync Backup

## Scripts  

- **plex-backup-media.bat**: Sync any number of Plex media hard drives to an associated backup hard drive, preferable in cold storage.  
- **plex-backup-server.bat**: Backup these scripts and their logs, Tautulli app data, and Plex app data to a target drive.  
- **plex-cache-clear.bat**: Clears Plex server cache.  

## Installation  

1. Place all scripts in root of C drive (i.e. `c:\`).  
2. Modify **plex-backup-media.bat** as needed to map your named hard drives (e.g. `CALL :SYNC_DRIVE "Media1" "E:\" "R:\"`).  
3. Modify **plex-backup-server.bat** if needed to change target drive destination from root of A drive (i.e. `a:\`) to wherever.  
4. Optionally import the task **plex-cache-clear-task.xml** into Windows Task Scheduler if you want to periodically clear Plex server cache.   
5. Both **plex-backup-media.bat** and **plex-backup-server.bat** are intended to be manually run as needed but could also schedule as a Windows task.  
