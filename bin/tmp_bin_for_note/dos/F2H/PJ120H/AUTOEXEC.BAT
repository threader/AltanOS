@echo off
nlsfunc.exe country.sys
GOTO %CONFIG%

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
MSCDEX.EXE /D:USBCD /L:R

GOTO BOTH

:EDIT
GOTO EXIT

:BOTH
cls
r:\win98\image\sharp\fmenu.exe -H5120 -Fr:\win98\image\system
IF ERRORLEVEL 2 GOTO :EXIT

r:\win98\image\system\smartdrv.exe /Q
r:\win98\image\sharp\sfdump /X /F5020 r:\win98\image
GOTO :EXIT

:EXIT

