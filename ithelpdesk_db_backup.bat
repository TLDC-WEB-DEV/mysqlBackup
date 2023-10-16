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
set host="<host>"
set user="<username>"
@REM If password has a % sign, double the % sign
@REM Example: "pass%ord" should be "pass%%ord"
set pass="<password>"
set db[0]=<db0>
set db[1]=<db1>
set db[2]=<db2>
set db[3]=<db3>
set db[4]=<db4>
set db[5]=<db5>

REM pause
for /l %%n in (0,1,5) do ( 
    REM echo %BACKUP_DIR%;
	set BACKUP_FILE=!BACKUP_DIR!\backup_!db[%%n]!.sql
	REM pause
	set LOG_FILE=!BACKUP_DIR!\backup_!db[%%n]!.log

	REM echo !db[%%n]!
	REM pause
	REM pause
	@REM echo "mysqldump -h!host! -u!user! -p!pass! --verbose !db[%%n]!  > "!BACKUP_FILE!" 2> "!LOG_FILE!"
    mysqldump -h!host! -u!user! -p!pass! --verbose !db[%%n]!  > "!BACKUP_FILE!" 2> "!LOG_FILE!"

	REM pause
)

setlocal DisableDelayedExpansion

echo "MYSQL Backup for %host% completed!.."
echo "Backup Location: %BACKUP_DIR%"
pause

