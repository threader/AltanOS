:START
ECHO OFF

REM　WindowsPath
set SYSDIR=C:\Windows

cls
ECHO 
ECHO           ###  CD-ROM 起動ディスク作成プログラム  ###             
ECHO                                                                   
ECHO  CD-ROM 起動ディスクを作成します。つぎのディスクに変えてください。
ECHO   ＋-------------------------------------------------------＋     
ECHO   ｜  「標準システムインストール起動ディスク　1」のコピー  ｜     
ECHO   ＋-------------------------------------------------------＋     
ECHO                                                                   
ECHO ------------------------------------------------------------------
ECHO  「標準システムインストール起動ディスク」は、パソコン内の　　     
ECHO  「標準システムインストール起動ディスクの作成」プログラムを　     
ECHO   利用して作成してください。                                      
ECHO                            ［Ctrl］＋［Ｃ］キーで中断できます。   
ECHO 
PAUSE

Rem ターゲットＦＤ内に command.com がなければ起動ディスク1では無いと判断する。
  IF NOT EXIST %FDD%:\COMMAND.COM GOTO START

cls

@echo 起動用ディスク作成中...

c:
CD \
cd c:\f2h
COPY C:\F2h\usbaspi.sys    %FDD%:\ /V >nul
COPY C:\F2h\USBCD.SYS      %FDD%:\ /V >nul

%FDD%:
rename %FDD%:\sysfiles\pana.lst pana.KME

copy c:\f2h\pana.lst %FDD%:\sysfiles\pana.lst >nul

REM ===== MAKEFD2.bat ===========================================

c:\f2h\MAKEFD2.BAT
