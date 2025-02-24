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
ECHO   ｜  「リカバリCD用起動ディスク」のコピー          ｜            
ECHO   ＋------------------------------------------------＋            
ECHO                                                                   
ECHO ------------------------------------------------------------------
ECHO  「リカバリCD用起動ディスク」は、パソコンに付属されています。     
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスク作成中...
c:
CD \
cd c:\f2h
md bak

Rem 空き容量の確保の為、CardServiceがあれば削除する
  if not exist %FDD%:\Card\nul goto DATACP
  copy %FDD%:\Card\Cardxtnd.sys c:\f2h\bak /V >nul
  copy %FDD%:\Card\Cs.sys       c:\f2h\bak /V >nul
  copy %FDD%:\Card\Csalloc.exe  c:\f2h\bak /V >nul

  del %FDD%:\Card\Cardxtnd.sys
  del %FDD%:\Card\Cs.sys
  del %FDD%:\Card\Csalloc.exe

:DATACP
COPY C:\F2h\usbaspi.sys    %FDD%:\ /V >nul
COPY C:\F2h\USBCD.SYS      %FDD%:\ /V >nul
COPY C:\F2h\ramfd.sys      %FDD%:\ /V >nul

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