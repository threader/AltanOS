@ECHO OFF
PATH=A:\;A\PCM311
A:\MSCDEX.EXE /D:USBCD /M:15 /V /L:Z

:MAIN
CLS
TYPE A:\MENU.TXT
ECHO.
ECHO あなたのインストール環境は以下の通りです
TYPE Instype.txt
ECHO.

ECHO.
ECHO 番号を選択してください（１,２,３,４）
choice /C:1234 /N
IF ERRORLEVEL 4 GOTO AEND
IF ERRORLEVEL 3 GOTO ENVIRO
IF ERRORLEVEL 2 GOTO FDISK
IF ERRORLEVEL 1 GOTO RECOVERY
GOTO END


REM 区画の設定
:FDISK
A:\FDISK
CLS
ECHO.
ECHO 変更した内容を有効にするには再起動する必要があります。
ECHO 再度セットアップメニューを起動する場合は、Ctrl + Alt + Del を同時に押して
ECHO ください。
ECHO.
GOTO END

REM ***** リカバリ環境変更（３）*****
:ENVIRO
CLS
TYPE A:\MENU2.TXT
ECHO.
ECHO あなたの現在のインストール環境は、以下の通りです。
TYPE A:\INSTYPE.TXT
ECHO.

CHOICE /C:1234 /N 番号を選択してください（１,２,３,４）
IF ERRORLEVEL 4 GOTO AEND
IF ERRORLEVEL 3 GOTO MAIN
IF ERRORLEVEL 2 GOTO NCD201
IF ERRORLEVEL 1 GOTO NCD401
GOTO END

:NCD201

COPY /Y CONFIG.201 CONFIG.SYS
ECHO ●CD-ROMドライブユニット(FMV-NCD201)の環境 > A:\INSTYPE.TXT

CLS
ECHO リカバリ環境を「CD-ROMドライブユニット(FMV-NCD201)」に変更しました。
ECHO.
ECHO 変更した内容を有効にするには再起動する必要があります。
ECHO Ctrl + Alt + Del を同時に押してください。
GOTO END


:NCD401

COPY /Y CONFIG.401 CONFIG.SYS
ECHO ●CD-ROMドライブユニット(FMV-NCD401)の環境 > A:\INSTYPE.TXT

CLS
ECHO リカバリ環境を「CD-ROMドライブユニット(FMV-NCD401)」に変更しました。
ECHO.
ECHO 変更した内容を有効にするには再起動する必要があります。
ECHO Ctrl + Alt + Del を同時に押してください。
GOTO END

REM リカバリ作業開始
:RECOVERY

CLS
RECOVERY.BAT

:FEND
CLS
ECHO.
ECHO ハードディスクの初期化を中止しました。セットアップメニューを再度起動する
ECHO 場合は、Ctrl + Alt + Del を同時に押してください。
ECHO.
GOTO END

:AEND
CLS
ECHO.
ECHO セットアップメニューを中断しました。再度起動する場合は、
ECHO Ctrl + Alt + Del を同時に押してください。
ECHO.

:END
