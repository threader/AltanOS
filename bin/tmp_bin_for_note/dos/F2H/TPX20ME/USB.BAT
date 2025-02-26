ECHO OFF
Rem 環境変数の値をクリア
SET FILEDAT=
rem SET FDD=A

CLS
ECHO 
ECHO                                                                    
ECHO         ###  CD-ROM 起動ディスク作成準備プログラム  ###            
ECHO                                                                    
ECHO         IBM ThinkPad X20                                           
ECHO                 (C) Panasonic Communications Co., Ltd. 2000-2003   
ECHO -------------------------------------------------------------------
ECHO  ● このプログラムは、CD-ROM 起動ディスク作成の準備をします。      
ECHO 
@echo.
@echo.
PAUSE
C:
CD \

Rem F2Hデータ　→　ハードディスク
@echo 起動用ディスケット作成の準備中...
COPY %FDD%:README.TXT C:\F2H /V >nul
COPY %FDD%:Config.sys C:\F2H /V >nul
COPY %FDD%:MAKEFD.BAT C:\F2H\MAKEFD.BAT /V >nul
COPY %FDD%:Autoexec.bat C:\F2H\AUTOEXEC.BAT /V >nul
COPY %FDD%:Getdrive.ini C:\F2H\GETDRIVE.INI /V >nul

Rem CD-ROM ドライバ　→　ハードディスク
SET FILEDAT=NOSETUP

:FILECHK
IF NOT EXIST %FDD%:\F2H\RAMFD.SYS GOTO ERR01
IF NOT EXIST %FDD%:\F2H\USBASPI.SYS GOTO ERR01
IF NOT EXIST %FDD%:\F2H\USBCD.SYS GOTO ERR01

COPY %FDD%:\F2H\ramfd.sys C:\F2H /V >nul
COPY %FDD%:\F2H\usbaspi.sys C:\F2H /V >nul
COPY %FDD%:\F2H\usbcd.sys C:\F2H /V >nul

C:
CD \F2H
MAKEFD.BAT
Rem ここで終わり、どこにもジャンプしない。

:ERR01
IF NOT "%FILEDAT%" == "NOSETUP" GOTO ERR02
CLS
@ECHO.
@echo 　　
@echo 　　                                                                  
@echo 　　   フロッピーディスクドライブのディスケットを                     
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
