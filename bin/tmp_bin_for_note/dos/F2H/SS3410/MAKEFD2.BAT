:START2
ECHO OFF

REM　WindowsPath
set SYSDIR=C:\Windows

cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###           
ECHO                                                                 
ECHO  つぎのディスクに変えてください。                               
ECHO   ＋-------------------------------------------------------＋   
ECHO   ｜  「標準システムインストール起動ディスク　2」のコピー  ｜   
ECHO   ＋-------------------------------------------------------＋   
ECHO                                                                 
ECHO ----------------------------------------------------------------
ECHO  「標準システムインストール起動ディスク」は、パソコン内の　　   
ECHO  「標準システムインストール起動ディスクの作成」プログラムを　   
ECHO   利用して作成してください。                                    
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。 
ECHO 
PAUSE

Rem ターゲットＦＤ内に %FDD%:\Sysfiles\807an.cfg がなければ起動ディスク2では無いと判断する。
  IF NOT EXIST %FDD%:\Sysfiles\807an.cfg GOTO START2

@echo 起動用ディスク作成中...

c:
CD \
cd c:\f2h

%FDD%:
rename %FDD%:\sysfiles\807an.cfg 807anKME.cfg
rename %FDD%:\sysfiles\807an.bat 807anKME.bat
rename %FDD%:\sysfiles\config.cm config.KME

copy c:\f2h\807an.cfg %FDD%:\sysfiles\807an.cfg >nul
copy c:\f2h\807an.bat %FDD%:\sysfiles\807an.bat >nul
copy c:\f2h\config.cm %FDD%:\sysfiles\Config.cm >nul

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