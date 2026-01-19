

REM　WindowsPath
REM set SYSDIR=C:\Windows

@echo off
IF "%CONFIG%"=="SHRP"  GOTO SHRP
IF "%CONFIG%"=="SHRP2" GOTO SHRP2
IF "%CONFIG%"=="USER"  GOTO USER
GOTO EXIT

:SHRP
REM **********************************************
REM *  SHARP CE-CD03を使用する場合               *
REM **********************************************
REM MSCDEX.EXE /D:MSCD001 /L:R
REM GOTO BOTH

:SHRP2
REM **********************************************
REM *  SHARP CE-CD01/CE-CD02を使用する場合       *
REM **********************************************
MSCDEX.EXE /D:MSCD001 /L:R
GOTO BOTH

:USER
REM **********************************************
REM *  任意のCD-ROMドライブを接続する場合は      *
REM *  以下の行を編集してください。              *
REM **********************************************
REM MSCDEX.EXE /D:ここにお使いのCD-ROMﾃﾞﾊﾞｲｽ名を記入してください。 /L:R
MSCDEX.EXE /D:MSCD001 /L:R

GOTO BOTH

:EDIT
GOTO EXIT

:BOTH
drive -q
cls

mebchk.exe
if errorlevel 1 goto END

path=%RAMDISK%\;a:\
copy command.com %RAMDISK%\ > NUL
copy RAMDRV\*.* %RAMDISK%\ > NUL
set comspec=%RAMDISK%\command.com

%RAMDISK%
recover.bat

:EXIT

