REM *** OTHER ****
ECHO OFF
Rem 環境変数の値をクリア
SET FILEDAT=
rem SET FDD=A

CLS
ECHO 
ECHO                                                                 
ECHO         ###  CD-ROM 起動ディスク作成準備プログラム  ###         
ECHO                                                                 
ECHO               (C) Panasonic Communications Co., Ltd. 2000-2003  
ECHO ----------------------------------------------------------------
ECHO  ● このプログラムは、CD-ROM 起動ディスク作成の準備をします。   
ECHO 
@echo.
@echo.
PAUSE

Rem F2Hデータ　→　ハードディスク
@echo 起動用ディスク作成の準備中...
REM COPY %FDD%:README.TXT C:\F2H /V >nul

COPY %FDD%:AUTOEXEC.SAM C:\F2H /V >nul

COPY %FDD%:CONFIG.Me1   C:\F2H /V >nul
COPY %FDD%:CONFIG.Me2   C:\F2H /V >nul
COPY %FDD%:CONFIG.SAM   C:\F2H /V >nul
COPY %FDD%:CONFIG.SAU   C:\F2H /V >nul
COPY %FDD%:CONFIG.LEG   C:\F2H /V >nul
COPY %FDD%:CONFIG.USB   C:\F2H /V >nul

COPY %FDD%:MAKEFD.*   C:\F2H\MAKEFD.* /V >nul

Rem CD-ROM ドライバ　→　ハードディスク
SET FILEDAT=NOSETUP

:FILECHK
IF NOT EXIST %FDD%:\F2H\usbaspi.sys GOTO  ERR01
IF NOT EXIST %FDD%:\f2h\usbcd.sys GOTO ERR01
IF NOT EXIST %FDD%:\f2h\ramfd.sys GOTO ERR01

COPY %FDD%:\F2H\usbaspi.sys    C:\F2H /V >nul
COPY %FDD%:\f2h\usbcd.sys   C:\F2H /V >nul
COPY %FDD%:\f2h\ramfd.sys   C:\F2H /V >nul

C:
CD \F2H

Rem 環境変数の値をクリア
SET FILEDAT=

MAKEFD.BAT
Rem ここで終わり、どこにもジャンプしない。

:ERR01
IF NOT "%FILEDAT%" == "NOSETUP" GOTO ERR02
CLS
@ECHO.
@echo 　　
@echo 　　                                                                  
@echo 　　   フロッピーディスクドライブのディスクを                         
@echo 　　   本機付属の「セットアップディスク」へ交換してください．         
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
@ECHO OFF
PAUSE
SET FILEDAT=SETUPDSK
GOTO FILECHK

:ERR02
ECHO ***  必要なファイルが見つかりません。        ***
ECHO ***  セットアップディスクを正しくセットして  ***
ECHO ***            最初からやり直してください。  ***
ECHO.
GOTO END

:END
Rem 環境変数の値をクリア
SET FILEDAT=

