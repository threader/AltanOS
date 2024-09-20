echo oFF
:TOP
Rem 環境変数リセット
Rem（SYSDIR＝Windows System Folder  ）
Rem（FDSTAT＝FDD Connect Type Status）
  SET SYSDIR=
  SET FDSTAT=
cls
echo 
echo           ###  CD-ROM 起動ディスク作成プログラム  ###              
echo                                                                    
echo  CD-ROM 起動ディスクを作成します。以下のものを用意してください。   
echo  「Windows 98 起動ディスク」のコピー                               
echo      または「Windows Me 起動ディスク」のコピー                     
echo      または「パソコン専用起動ディスク」のコピー                    
echo  「CD-ROM 起動ディスク」（空きディスク：１枚）                     
echo                                                                    
echo     準備できました      ･･････ [1]                                 
echo     準備できていません  ･･････ [2]                                 
echo                                                                    
echo  [1],[2]を選択してください。                                       
ECHO 

Rem (1) 標準の場合、windirにPATHがセットされる
Rem (2) Makefd.batの後ろにWindowsフォルダを指定している場合、%1にPATHがセットされる
Rem (3) PATHが何もセットされていない場合、C:\Windowsをセットする

if not "windir"=="" goto DEFAULT
if not "%1"=="" goto FLEXIBLE
set SYSDIR=C:\Windows
goto oRGFDCHK

:DEFAULT
 set SYSDIR=%windir%
 goto oRGFDCHK

:FLEXIBLE
 set SYSDIR=%1

:oRGFDCHK
input.exe
 if errorlevel 2 goto END
 if errorlevel 1 goto FDDCHECK

 goto ERR3


:FDDCHECK
cls
echo 
echo  フロッピーディスクドライブはＵＳＢ接続タイプですか？          
echo                                                                
echo     はい（ＵＳＢ接続）  ･･･････ [1]                            
echo     いいえ（専用接続）  ･･･････ [2]                            
echo                                                                
echo  [1],[2]を選択してください。                                   
echo 

Rem (1) USB接続タイプFDDの場合、FD Status に USBFD がセットされる。
Rem (2) レガシータイプFDDの場合、FD Status に LEGACY がセットされる。

input.exe
if errorlevel 2 goto SETLEG
if errorlevel 1 goto SETUSB

:SETUSB
Rem --- USB-FDD Type ------------------------------------------------
set FDSTAT=USBFD
goto MKSTART

:SETLEG
Rem --- Legacy-FDD Type ---------------------------------------------
set FDSTAT=LEGACY

:MKSTART
cls
echo 
echo  作成する「CD-ROM 起動ディスク」は次のどちらですか？           
echo                                                                
echo     Windows 98用  ･････････････････････････････ [1]            
echo     Windows Me用  ･････････････････････････････ [2]            
echo     パソコン専用  ･････････････････････････････ [3]            
echo     B's Recorder GOLD5 BASIC                                   
echo             [起動用フロッピーディスク]専用 ････ [4]            
echo                                                                
echo  [1],[2],[3],[4]を選択してください。                           
echo 
input.exe

if errorlevel 4 goto PCoRG01
if errorlevel 3 goto PCoRG01
if errorlevel 2 goto MeWin01
if errorlevel 1 goto 98Win01


Rem ===== For Windows Me =============================================
:MeWin01
cls
echo 
echo                                                                
echo 「Windows Me 起動ディスク」のコピーに交換してください。        
echo                                                                
echo  ※お知らせ                                                    
echo    「Windows Me 起動ディスク」の原本は使用しないでください。   
echo                                                                
echo     準備できました      ･･････ [1]                             
echo     準備できていません  ･･････ [2]                             
echo                                                                
echo  [1],[2]を選択してください。                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto MeWin02

:MeWin02
Rem WindowsMe起動ディスクであるかチェック
if not exist %FDD%:\Command.com goto MeWin01

Rem (1) Original FileのBackUP
Rem (2) FD空き容量確保の為ファイルを削除
Rem (3) HDDからFDへファイルをコピー
cls
@echo 起動用ディスク作成中...

if not exist %FDD%:\config.sys goto MeWin03
rename %FDD%:\config.sys *.org

:MeWin03
if not exist %FDD%:\autoexec.bat goto MeWin04
rename %FDD%:\autoexec.bat *.org

:MeWin04
del %FDD%:\aspi*.sys

copy c:\f2h\autoexec.sam %FDD%:\autoexec.bat /v >nul
copy c:\f2h\usbaspi.sys %FDD%:\ /v >nul
copy c:\f2h\usbcd.sys %FDD%:\ /v >nul

if "%FDSTAT%" == "USBFD" goto WMeUSB
copy c:\f2h\config.me1   %FDD%:\config.sys /v >nul
goto SEARCH0

:WMeUSB
copy c:\f2h\config.me2   %FDD%:\config.sys /v >nul
copy c:\f2h\ramfd.sys %FDD%:\ /v >nul
goto SEARCH0



Rem ===== For Windows 98 =============================================
:98Win01
cls
echo 
echo                                                                
echo 「Windows 98 起動ディスク」(１枚目)のコピーに交換してください。
echo                                                                
echo  ※お知らせ                                                    
echo    「Windows 98 起動ディスク」の原本は使用しないでください。   
echo                                                                
echo     準備できました      ･･････ [1]                             
echo     準備できていません  ･･････ [2]                             
echo                                                                
echo  [1],[2]を選択してください。                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto 98Win02

:98Win02
Rem Windows98起動ディスクであるかチェック
if not exist %FDD%:\Command.com goto 98Win01

Rem (1) Original FileのBackUP
Rem (2) FD空き容量確保の為ファイルを削除
Rem (3) HDDからFDへファイルをコピー
cls
@echo 起動用ディスク作成中...

if not exist %FDD%:\config.sys goto 98Win03
rename %FDD%:\config.sys *.org

:98Win03
if not exist %FDD%:\autoexec.bat goto 98Win04
rename %FDD%:\autoexec.bat *.org

:98Win04
del %FDD%:\aspi*.sys

copy c:\f2h\autoexec.sam %FDD%:\autoexec.bat /v >nul
copy c:\f2h\usbaspi.sys %FDD%:\ /v >nul
copy c:\f2h\usbcd.sys %FDD%:\ /v >nul

if "%FDSTAT%" == "USBFD" goto W98USB
copy c:\f2h\config.sam   %FDD%:\config.sys /v >nul
goto SEARCH0

:W98USB
copy c:\f2h\config.sau   %FDD%:\config.sys /v >nul
copy c:\f2h\ramfd.sys %FDD%:\ /v >nul
goto SEARCH0





Rem ===== For PC Original ============================================
:PCoRG01
 cls
:PCoRG02
echo 
echo                                                                
echo 「パソコン専用起動ディスク」のコピーに交換してください。       
echo                                                                
echo  ※お知らせ                                                    
echo    「パソコン専用起動ディスク」の原本は使用しないでください。  
echo                                                                
echo     準備できました      ･･････ [1]                             
echo     準備できていません  ･･････ [2]                             
echo                                                                
echo  [1],[2]を選択してください。                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto PCoRG03

:PCoRG03
Rem 起動ディスクであるかチェック
 if exist %FDD%:\Command.com goto DELDATA0
 @echo.
 @echo 起動ディスクが挿入されていません！
 @echo.
 goto PCoRG02

:DELDATA0
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem FD空き容量確保の為ファイルを削除
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
cls
@echo 起動用ディスク作成中...
:DELDATA1
Rem -----------------------------------------------------------------
Rem 起動ディスクの不要ファイルを削除するには、ここに追加する。
Rem -----------------------------------------------------------------
 if not exist %FDD%:\aspi*.sys goto DELDATA2
   del %FDD%:\aspi*.sys >nul

:DELDATA2
 if not exist %SYSDIR%\command\deltree.exe goto DELDATA5
Rem -----------------------------------------------------------------
Rem 起動ディスクの不要ディレクトリを削除するには、ここに追加する。
Rem -----------------------------------------------------------------
 if not exist %FDD%:\pccard\nul goto DELDATA5
   %SYSDIR%\command\deltree /y %FDD%:\pccard > nul
 if not exist %FDD%:\cdrom2\nul goto DELDATA5
   %SYSDIR%\command\deltree /y %FDD%:\cdrom2 > nul

:DELDATA5


Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem (1) config.sys がターゲットＦＤに存在すれば、config.org へ
Rem     Rename する。
Rem (2) config.org がマルチ config か判断する。
Rem (3) config.sys のサンプルを作成し、ターゲットＦＤにコピーする。
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
:CHKCoNF
Rem config.sys が存在しなければ、Sample Config.sys を利用する。
 if not exist %FDD%:\config.sys goto RNCoNF

Rem -----------------------------------------------------------------
Rem ここから config.sys が存在する場合の処理...
Rem -----------------------------------------------------------------
 if not exist %FDD%:\config.org goto NoRGCoNF

Rem config.org があれば、以前に起動ディスクを作成したＦＤとみなし
Rem 現在の config.sys を削除する。
     del %FDD%:\config.sys
     goto EoRGCoNF
:NoRGCoNF
Rem  Not exist ORiGinal CONFig.sys file.
   rename %FDD%:\config.sys *.org

:EoRGCoNF
Rem  Exist ORiGinal CONFig.sys file.
   copy %FDD%:\config.org c:\f2h /v >nul

Rem -----------------------------------------------------------------
Rem config.sys の作成...
Rem -----------------------------------------------------------------
:EXISTDAT
Rem config.sys が存在する場合の処理。
 if "%FDSTAT%" == "USBFD" goto USBCoNF

Rem Legacy-FDD タイプの config.sys を作成。
   type c:\f2h\config.leg >> c:\f2h\config.org
   goto MKCoNF

:USBCoNF
Rem USB-FDD タイプの config.sys を作成。
   type c:\f2h\config.usb >> c:\f2h\config.org
   goto MKCoNF

:MKCoNF
   copy c:\f2h\config.org %FDD%:\config.sys /v >nul
   goto CHKAUTo

:RNCoNF
Rem config.sys が存在しない場合の処理。
 if "%FDSTAT%" == "USBFD" goto USBSAMP
Rem config.sys が無い場合のサンプル config.sys （Legacy-FDD タイプ）
   copy c:\f2h\config.sam %FDD%:\config.sys /v >nul
   goto CHKAUTo
   
:USBSAMP
Rem config.sys が無い場合のサンプル config.sys （USB-FDD タイプ）
   copy c:\f2h\config.sau %FDD%:\config.sys /v >nul
   goto CHKAUTo

Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem (1) autoexec.bat がターゲットＦＤに存在すれば、autoexec.org へ
Rem     Rename する。
Rem (2) autoexec.bat のサンプルを作成し、ターゲットＦＤにコピーする。
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
:CHKAUTo
 if not exist %FDD%:\autoexec.bat goto RNAUTo
Rem autoexec.org があれば、以前に起動ディスクを作成したＦＤとみなす。
   if not exist %FDD%:\autoexec.org goto NoRGAUTo
   del %FDD%:\autoexec.bat
   goto EoRGAUTo
:NoRGAUTo
   rename %FDD%:\autoexec.bat *.org
:EoRGAUTo
   copy %FDD%:\autoexec.org c:\f2h /v >nul
   type c:\f2h\autoexec.org >> c:\f2h\autoexec.sam
   copy c:\f2h\autoexec.sam %FDD%:\autoexec.bat /v >nul
   goto CoPYDRV

:RNAUTo
   copy c:\f2h\autoexec.sam %FDD%:\autoexec.bat /v >nul
   goto CoPYDRV

:CoPYDRV
Rem デバイスドライバーのコピー。
 if "%FDSTAT%" == "LEGACY" goto LEGACYFD
 copy c:\f2h\ramfd.sys %FDD%:\ /v >nul
:LEGACYFD
 copy c:\f2h\usbaspi.sys %FDD%:\ /v >nul
 copy c:\f2h\usbcd.sys %FDD%:\ /v >nul

 goto SEARCH0


Rem ===== SEARCH for MSCDEX, HIMEM ===================================
:SEARCH0
if exist %FDD%:\himem.sys goto SEARCH01
if not exist %SYSDIR%\himem.sys goto ERR1
copy %SYSDIR%\himem.sys %FDD%:\ /v >nul
if not exist %FDD%:\himem.sys goto ERR1

:SEARCH01
if exist %FDD%:\mscdex.exe goto SEARCH02
if not exist %SYSDIR%\Command\mscdex.exe goto ERR2
copy %SYSDIR%\Command\mscdex.exe %FDD%:\ /v >nul
if not exist %FDD%:\mscdex.exe goto ERR2

:SEARCH02
goto SUCCESS0


Rem ===== Closing Messages ===========================================
:SUCCESS0
cls
echo 
echo                                                                
echo 「CD-ROM 起動ディスク」の作成が終了しました。                  
echo                                                                
echo  ｢CD-ROM 起動ディスク｣ が正常に動作することを確認してください。
echo                                                                
echo  お知らせ：                                                    
echo    パソコンによっては、CD-ROM ドライブを指定のドライブとして   
echo    認識させなければ、システムの再インストールができないものが  
echo    あります。                                                  
echo    その場合は、パソコン付属の説明書を参考にCD-ROM 起動ディスク 
echo    の AUTOEXEC.BAT ファイルをエディタで開いて、MSCDEX.EXE 行の 
echo    /L: オプションを変更してください。                          
echo                                                                
echo 
pause
goto END


Rem ===== Error Messages =============================================
:ERR1
@echo.
@echo ==============================================================
@echo HIMEM.SYS が見つからないかコピーできません！
@echo パソコンの中から HIMEM.SYS と MSCDEX.EXE を検索し、
@echo CD-ROM 起動ディスクにコピーしてください。
@echo ==============================================================
pause
goto END

:ERR2
@echo.
@echo ==============================================================
@echo MSCDEX.EXE が見つからないかコピーできません！
@echo  ｢CD-ROM 起動ディスク｣ でパソコンを起動し、CD-ROM ドライブが
@echo 認識されない場合は、次のいずれかの対処をおこなってください。
@echo.
@echo  (1) パソコンの中から MSCDEX.EXE を検索し、
@echo      CD-ROM 起動ディスクにコピーしてください。
@echo  (2) CD-ROM 起動ディスクの AUTOEXEC.BAT ファイルをエディタで
@echo      開いて、MSCDEX.EXE 行を PATH 行の後ろへ移動してください。
@echo  (3) CD-ROM 起動ディスクの AUTOEXEC.BAT ファイルをエディタで
@echo      起動し、MSCDEX.EXE 行を MSCDEX.EXE の存在するディレクトリ
@echo      へ PATH をとおしてください。
@echo      （例：A:\DOS\MSCDEX.EXE /D:USBCD001 /L:Q ）
@echo.
@echo ==============================================================
pause
goto END

:ERR3
 goto END

:END
 set FDSTAT=
 set SYSDIR=
