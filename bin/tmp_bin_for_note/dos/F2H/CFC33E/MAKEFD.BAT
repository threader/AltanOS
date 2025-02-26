:START
ECHO OFF
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
pause

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスケット作成中...

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
copy c:\f2h\USBASPI.sys %FDD%:\OTHER >nul
copy c:\f2h\USBCD.sys %FDD%:\OTHER >nul

%FDD%:
rename %FDD%:\config.sys config.KME

copy c:\f2h\config.sys %FDD%:\config.sys >nul

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