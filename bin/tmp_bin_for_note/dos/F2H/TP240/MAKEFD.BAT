ECHO OFF
:START
cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###             
ECHO                                                                   
ECHO  CD-ROM 起動ディスクを作成します。つぎのディスクに変えてください。
ECHO   ＋----------------------------------------------------------＋  
ECHO   ｜  パソコン付属「Product Recovery CD-ROM                   ｜  
ECHO   ｜                        Boot Diskette」のコピー           ｜  
ECHO   ＋----------------------------------------------------------＋  
ECHO  または、                                                         
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
IF EXIST %FDD%:\GETDRIVE.INI GOTO TP240X

  copy %FDD%:\bin\dosk.bat  c:\f2h\bak >nul
  copy %FDD%:\bin\aspiomgr.sys c:\f2h\bak >nul
  copy %FDD%:\bin\kmecd.sys c:\f2h\bak >nul
  copy %FDD%:\bin\ctcnfcd.sys   c:\f2h\bak >nul

  del %FDD%:\bin\dosk.bat
  del %FDD%:\bin\aspiomgr.sys
  del %FDD%:\bin\kmecd.sys
  del %FDD%:\bin\ctcnfcd.sys

Rem 容量確保の為、CardServiceがあれば削除する
  IF NOT EXIST %FDD%:\bin\cs.sys GOTO DELCS
  copy %FDD%:\bin\cs.sys c:\f2h\bak >nul
  del %FDD%:\bin\cs.sys
:DELCS
  IF NOT EXIST %FDD%:\bin\csalloc.exe GOTO DATACP
  copy %FDD%:\bin\csalloc.exe c:\f2h\bak >nul
  del %FDD%:\bin\csalloc.exe

:DATACP
copy c:\f2h\usbaspi.sys %FDD%:\bin >nul
copy c:\f2h\usbcd.sys %FDD%:\bin >nul

IF EXIST %FDD%:\bin\WAKECD.EXE GOTO SS2

:SS1
 COPY C:\f2h\RWDOSK1 %FDD%:\BIN\DOSK.BAT >nul
 goto ENDMSG

:SS2
 COPY C:\f2h\RWDOSK2 %FDD%:\BIN\DOSK.BAT >nul
 goto ENDMSG

:TP240X
del %FDD%:\aspiomgr.sys
del %FDD%:\kmecd.sys
Ren %FDD%:\AUTOEXEC.BAT AUTOEXEC.BAK
Ren %FDD%:\GETDRIVE.INI GETDRIVE.BAK
COPY C:\F2H\USBASPI.SYS %FDD%:\
COPY C:\F2H\USBCD.SYS %FDD%:\
COPY C:\F2H\AUTOEXEC.BAT %FDD%:\
COPY C:\F2H\GETDRIVE.INI %FDD%:\
goto ENDMSG

REM ===== Closing Messages ===========================================
:ENDMSG
CLS
@echo.
ECHO 
ECHO                                                                 
ECHO 「CD-ROM 起動ディスク」の作成が終了しました。                   
ECHO                                                                 
ECHO  ThinkPad 240 の場合、起動時のメニューは、                      
ECHO     「ＫＸＬ−７８３Ａ」を選択してください。                    
ECHO  ThinkPad 240X の場合、起動時のメニューは、                     
ECHO     「Panasonic USB Drive」を選択してください。                 
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