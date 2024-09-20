@echo off
nlsfunc.exe country.sys
GOTO %CONFIG%

:SHRP
REM **********************************************
REM *  SHARP CE-CD01/02を使用する場合            *
REM **********************************************
MSCDEX.EXE /D:PCMCIACD /L:R
GOTO BOTH

:SHRP2
REM **********************************************
REM *  SHARP CE-W10CDを使用する場合              *
REM **********************************************
MSCDEX.EXE /D:PCMCIACD /L:R
GOTO BOTH

:840
REM **********************************************
REM *  任意のCD-ROMドライブを接続する場合は      *
REM *  以下の行を編集してください。              *
REM **********************************************
MSCDEX.EXE /d:usbcd /L:R

GOTO BOTH

:EDIT
GOTO end

:BOTH

cls

mebchk.exe
if errorlevel 1 goto end
R:
cd \win98\image
hddump.exe x . -F156 -G159
:end

