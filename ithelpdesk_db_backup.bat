@echo off
setlocal EnableDelayedExpansion

REM Get the current date in the format YYYY_MM_DD
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "year=%datetime:~0,4%"
set "month=%datetime:~4,2%"
set "day=%datetime:~6,2%"
set "current_date=%year%_%month%_%day%"
REM pause
REM Set the backup directory with the current date in the current directory
set BACKUP_DIR=%~dp0%current_date%
REM pause
REM Ensure the backup directory exists, create it if not
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
REM pause
REM echo %current_date%
set host=192.168.250.78
set user=ithelpdesk
set pass=1ntrud3r
set db[0]=calltracker
set db[1]=custcarev2
set db[2]=hrservicedesk
set db[3]=legalconcerns
set db[4]=marketingrequest
set db[5]=tldchesk

REM pause
for /l %%n in (0,1,5) do ( 
    REM echo %BACKUP_DIR%;
	set BACKUP_FILE=!BACKUP_DIR!\backup_!db[%%n]!.sql
	REM pause
	set LOG_FILE=!BACKUP_DIR!\backup_!db[%%n]!.log
 
	REM echo !db[%%n]!
	REM pause
	REM pause
	echo "mysqldump -h!host! -u!user! -p!pass! --verbose !db[%%n]!  > "!BACKUP_FILE!" 2> "!LOG_FILE!"
    mysqldump -h!host! -u!user! -p!pass! --verbose !db[%%n]!  > "!BACKUP_FILE!" 2> "!LOG_FILE!"
	REM pause
)

setlocal DisableDelayedExpansion

echo "MYSQL Backup for %host% completed!.."
echo "Backup Location: %BACKUP_DIR%"
pause

REM | information_schema |
REM | calltracker        |
REM | custcarev2         |
REM | hrservicedesk      |
REM | legalconcerns      |
REM | marketingrequest   |
REM | mysql              |
REM | performance_schema |
REM | sys                |
REM | tldchesk           |

REM Count the number of databases in the array
REM for /f %%a in ('echo !DATABASE_NAMES! ^| find /c /v ""') do set "DB_COUNT=%%a"

REM echo %DB_COUNT%


REM Loop through the array and perform database backups
REM for /L %%i in (0, 1, %DB_COUNT%) do (
    REM set "DB_NAME=!DATABASE_NAMES[%%i]!"
	REM echo %DB_NAME%
    REM set "BACKUP_FILE=%BACKUP_DIR%\backup_!DB_NAME!.sql"
    REM set "LOG_FILE=%BACKUP_DIR%\backup_!DB_NAME!.log"
    
    REM echo Backing up database '!DB_NAME!' to !BACKUP_FILE!...
    REM mysqldump -u%MYSQL_USER% -p%MYSQL_PASSWORD% --verbose "!DB_NAME!" > "!BACKUP_FILE!" 2

    REM Check the mysqldump exit code
    REM if !errorlevel! neq 0 (
        REM echo Error: Database backup for '!DB_NAME!' failed. See log file: !LOG_FILE!
    REM ) else (
        REM echo Database backup for '!DB_NAME!' completed successfully. Log file: !LOG_FILE!
    REM )
REM )

REM pause
