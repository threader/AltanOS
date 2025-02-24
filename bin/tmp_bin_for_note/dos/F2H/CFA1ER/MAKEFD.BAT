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
ECHO   ｜  「ファーストエイドＦＤ」のコピー              ｜            
ECHO   ＋------------------------------------------------＋            
ECHO                                                                   
ECHO ------------------------------------------------------------------
ECHO  注:「ファーストエイドＦＤ」は、パソコン付属の取扱説明書に        
ECHO      記載の「万一のトラブルに備えましょう」を参照し、             
ECHO      「バックアップディスク作成」から作成した起動ディスクを       
ECHO      利用して「９．その他のＣＤ−ＲＯＭドライブ」を選択して       
ECHO      作成したものを使用してください。                             
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスク作成中...

rem FD容量確保の為KXL-808AN用ドライバを削除
%FDD%:
cd\
cd \kxl808
del Atasmgr.sys
del Kmesatcd.sys
cd \

c:
CD \
cd c:\f2h
COPY C:\F2h\usbaspi.sys    %FDD%:\other /V >nul
COPY C:\F2h\USBCD.SYS       %FDD%:\other /V >nul

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
ECHO 「CD-ROM 起動ディスク」の作成が終了しました。                   
ECHO                                                                 
ECHO 
@echo.
@echo.
pause
goto END

:END
