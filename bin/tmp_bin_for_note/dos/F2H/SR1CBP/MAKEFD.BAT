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
ECHO   ｜  「リカバリ用起動ディスク」のコピー            ｜            
ECHO   ＋------------------------------------------------＋            
ECHO                                                                   
ECHO ------------------------------------------------------------------
ECHO  「リカバリ用起動ディスク」は、アプリケーション追加と削除で       
ECHO   作成してください。                                              
ECHO                                                                   
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスクでは無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

@echo 起動用ディスク作成中...

REM FD容量の為不要ファイルの削除
del %FDD%:\aspi*.sys


Rem ===== ANSI.SYS =====
if not exist %SYSDIR%\ANSI.SYS goto ERR1
copy %SYSDIR%\ANSI.SYS %FDD%:\ /v >nul
if not exist %FDD%:\ANSI.SYS goto ERR1

if not exist %SYSDIR%\Command\mscdex.exe goto ERR2
copy %SYSDIR%\Command\mscdex.exe %FDD%:\ /v >nul
if not exist %FDD%:\mscdex.exe goto ERR2

c:
CD \
cd c:\f2h
COPY C:\F2h\usbaspi.sys    %FDD%:\ /V >nul
COPY C:\F2h\USBCD.SYS       %FDD%:\ /V >nul
COPY C:\F2h\RAMFD.SYS       %FDD%:\ /V >nul

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

:ERR1
@echo.
@echo ==============================================================
@echo ANSI.SYS が見つからないかコピーできません！
@echo パソコンの中から ANSI.SYS を検索し、
@echo CD-ROM 起動ディスクにコピーしてください。
@echo ==============================================================
pause
goto END

:ERR1
@echo.
@echo ==============================================================
@echo MSCDEX.EXE が見つからないかコピーできません！
@echo パソコンの中から MSCDEX.EXE を検索し、
@echo CD-ROM 起動ディスクにコピーしてください。
@echo ==============================================================
pause
goto END

:END
