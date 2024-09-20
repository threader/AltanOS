ECHO OFF
:START
cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###             
ECHO                                                                   
ECHO  CD-ROM 起動ディスクを作成します。つぎのディスクに変えてください。
ECHO   ＋----------------------------------------------------------＋  
ECHO   ｜  パソコン付属                                            ｜  
ECHO   ｜ 「IBM ThinkPad リカバリーＣＤ 起動ディスケット」のコピー ｜  
ECHO   ＋----------------------------------------------------------＋  
ECHO                                                                   
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスケット作成中...
c:
CD \
cd c:\f2h
md bak

Rem 容量確保の為
IF NOT EXIST %FDD%:\aspiomgr.sys GOTO KMECD
  copy %FDD%:\aspiomgr.sys c:\f2h\bak >nul
  del %FDD%:\aspiomgr.sys

:KMECD
IF NOT EXIST %FDD%:\kmecd.sys GOTO CARDCS
  copy %FDD%:\kmecd.sys c:\f2h\bak >nul
  del %FDD%:\kmecd.sys

:CARDCS
Rem 容量確保の為、CardServiceがあれば削除する
  IF NOT EXIST %FDD%:\IBMDSS14.SYS GOTO DELCS
  copy %FDD%:\IBMDSS14.SYS c:\f2h\bak >nul
  del %FDD%:\IBMDSS14.SYS

:DELCS
  IF NOT EXIST %FDD%:\IBMDSS14.SYS GOTO DATACP
  copy %FDD%:\IBMDSS14.SYS c:\f2h\bak >nul
  del %FDD%:\IBMDSS14.SYS

:DATACP
copy c:\f2h\ramfd.sys %FDD%:\ >nul
copy c:\f2h\usbaspi.sys %FDD%:\ >nul
copy c:\f2h\usbcd.sys %FDD%:\ >nul

COPY C:\F2H\AUTOEXEC.BAT %FDD%:\ >NUL
COPY C:\F2H\CONFIG.SYS   %FDD%:\ >NUL
COPY C:\F2H\GETDRIVE.INI %FDD%:\ >NUL

goto ENDMSG


REM ===== Closing Messages ===========================================
:ENDMSG
CLS
@echo.
ECHO 
ECHO                                                                 
ECHO 「CD-ROM 起動ディスク」の作成が終了しました。                   
ECHO                                                                 
ECHO  ｢CD-ROM 起動ディスク｣ が正常に動作することを確認してください。 
ECHO                                                                 
ECHO 
@echo.
@echo.
@echo どれかキーを押すと，「お知らせ」を表示します。
pause >nul

cls
type c:\f2h\readme.txt

goto END

:END
