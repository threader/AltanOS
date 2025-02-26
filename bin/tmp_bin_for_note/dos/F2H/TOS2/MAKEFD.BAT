:START
ECHO OFF

REM　WindowsPath
set SYSDIR=C:\Windows

cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###             
ECHO  CD-ROM 起動ディスクを作成します。つぎのディスクに変えてください。
ECHO   ＋---------------------------------------------------＋         
ECHO   ｜  「標準システムインストール起動ディスク」のコピー ｜         
ECHO   ＋---------------------------------------------------＋         
ECHO ------------------------------------------------------------------
ECHO  「標準システムインストール起動ディスク」は、パソコン内の　　     
ECHO  「標準システムインストール起動ディスクの作成」プログラムを　     
ECHO   利用して作成してください。                                      
ECHO   (メーカー名選択画面にて「手動インストール」を選択してください。 
ECHO   詳しくは、パソコン付属の取扱説明書をお読みください。            
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスク作成中...

c:
CD \
cd c:\f2h
COPY C:\F2h\usbaspi.sys    %FDD%:\ /V >nul
COPY C:\F2h\USBCD.SYS       %FDD%:\ /V >nul
COPY C:\F2h\RAMFD.SYS       %FDD%:\ /V >nul

%FDD%:
rename %FDD%:\config.sys config.KME
rem rename %FDD%:\autoexec.bat autoexec.KME

copy c:\f2h\config.sys %FDD%:\config.sys >nul
rem copy c:\f2h\autoexec.bat %FDD%:\autoexec.bat >nul

REM ===== Closing Messages ===========================================
:ENDMSG
CLS
@echo.
ECHO 
ECHO                                                                 
ECHO 「標準システムインストール起動ディスク」の作成が終了しました。  
ECHO                                                                 
ECHO 
@echo.
@echo.
pause
goto END

:END
