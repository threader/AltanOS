ECHO OFF
Rem 環境変数の値をクリア
SET FILEDAT=
rem SET FDD=A

CLS
ECHO 
ECHO                                                                   
ECHO         ###  CD-ROM 起動ディスク作成準備プログラム  ###           
ECHO                                                                   
ECHO         Panasonic Let's note CF-S51J8                             
ECHO                 (C) Panasonic Communications Co., Ltd. 2000-2003  
ECHO ------------------------------------------------------------------
ECHO  ● このプログラムは、CD-ROM 起動ディスク作成の準備をします。     
ECHO 
@echo.
@echo.
PAUSE
C:
CD \
MD C:\F2H >nul

Rem F2Hデータ　→　ハードディスク
@echo 起動用ディスク作成の準備中...
COPY %FDD%:CONFIG.SYS     C:\F2H /V >nul
COPY %FDD%:AUTOEXEC.BAT   C:\F2H /V >nul
COPY %FDD%:MAKEFD.BAT     C:\F2H\MAKEFD.BAT /V >nul
copy %FDD%:\f2h\input.exe c:\f2h /V >nul

Rem CD-ROM ドライバ　→　ハードディスク
SET FILEDAT=NOSETUP

:FILECHK
IF NOT EXIST %FDD%:\F2h\usbaspi.sys GOTO ERR01
IF NOT EXIST %FDD%:\F2h\usbcd.SYS GOTO ERR01

COPY %FDD%:\F2h\usbaspi.sys    C:\F2H /V >nul
COPY %FDD%:\F2h\USBCD.SYS       C:\F2H /V >nul

C:
CD \F2H
MAKEFD.BAT
Rem ここで終わり、どこにもジャンプしない。
goto END

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
