:START
ECHO OFF

REM　WindowsPath
set SYSDIR=C:\Windows

cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###             
ECHO                                                                   
ECHO  CD-ROM 起動ディスクを作成します。つぎのディスクに変えてください。
ECHO   ＋------------------------------------------------＋            
ECHO   ｜  「CD-ROMセットアップ起動ディスク」のコピー    ｜            
ECHO   ＋------------------------------------------------＋            
ECHO                                                                   
ECHO ------------------------------------------------------------------
ECHO  注:「CD-ROM セットアップ起動ディスク」は、パソコン付属の取扱     
ECHO      説明書に記載の「再インストールのための準備」を参照し、       
ECHO      「ファーストエイドＦＤ作成」から作成した起動ディスクを       
ECHO      利用して「３．その他の CD-ROM ドライブ」を選択して作成した   
ECHO      ものを使用してください。                                     
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスク作成中...

c:
CD \
cd c:\f2h
COPY C:\F2h\usbaspi.sys    %FDD%:\other /V >nul
COPY C:\F2h\USBCD.SYS       %FDD%:\other /V >nul

%FDD%:
rename %FDD%:\config.sys config.KME
rename %FDD%:\autoexec.bat autoexec.KME

copy c:\f2h\config.sys %FDD%:\config.sys >nul
copy c:\f2h\autoexec.bat %FDD%:\autoexec.bat >nul

REM ===== Closing Messages ===========================================
:ENDMSG
CLS
@echo.
ECHO 
ECHO                                                                 
ECHO 「CD-ROM 起動ディスク」の作成が終了しました。                   
ECHO                                                                 
ECHO 
@echo.
@echo.
pause
goto END

:END
