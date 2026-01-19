@ECHO OFF
Rem 環境変数リセット
  SET SYSDIR=

IF "%1"=="" GOTO ER1

rem ドライブの指定があり
rem 第一パラメータの値を設定
SET FDD=%1
GOTO ACT

:ER1
rem ドライブの指定がありません。
rem デフォルト設定　A
SET FDD=A
GOTO ACT

:ACT
%FDD%:\f2h\input.exe <YES
CLS
echo 
echo           ###  CD-ROM 起動ディスク作成プログラム  ###              
ECHO           (C) Panasonic Communications Co., Ltd. 2000-2003         
echo                                                                    
echo   CD-ROM 起動ディスクを作成します。下記のものを準備してください。  
echo 　                        
echo    「パソコン付属の起動ディスク」のコピー                        
echo                           
echo                                                                    
echo  1　準備できました                                                 
echo  2　準備できていません                                             
echo                                                                    
echo  [1]または[2]を選択してください。                                  
ECHO 

IF NOT "windir"=="" GOTO DEFAULT
SET SYSDIR=C:\Windows
goto START

:DEFAULT
SET SYSDIR=%windir%

:START
%FDD%:\f2h\input.exe
if errorlevel 2 goto END
if errorlevel 1 goto START2

:START2
%FDD%:

:MENU
Rem <---------------  Top Menu -------------------->
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                        
@echo 　　   CD-ROM 起動ディスクを作成するパソコンメーカー        
@echo 　　   を選択してください。                                 
@echo 　　                                                        
@echo 　　   1.Panasonic　　　　                                  
@echo 　　   2.SONY             　　　　　　　                    
@echo 　　   3.IBM                            　　　　　　　      
@echo 　　   4.SHARP                          　　　　　　　      
@echo 　　   5.Toshiba                        　　　　　　　      
@echo 　　   6.FUJITSU                        　　　　　　　      
@echo 　　   7.NEC                            　　　　　　　      
@echo 　　   8.その他                                             
@echo 　　   9.終了                                               
@echo 　　                                                        
@echo 　　              [1-9]を選択してください。                 
@echo 　　                                                        
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=9 goto END
if errorlevel=8 goto OTHER
if errorlevel=7 goto NEC
if errorlevel=6 goto FUJITSU
if errorlevel=5 goto TOSHIBA
if errorlevel=4 goto SHARP
if errorlevel=3 goto IBM
if errorlevel=2 goto SONY
if errorlevel=1 goto PANA

Rem <---------------  PC Select Menu -------------------->
:PANA
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                   
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。       
@echo 　　                                                                   
@echo 　　   1.Panasonic Let's note CF-S51J8                                 
@echo 　　   2.Panasonic Let's note CF-S51VJ8                                
@echo 　　   3.Panasonic Let's note CF-A1ER,CF-B5V,CF-B5R                    
@echo 　　   4.Panasonic Let's note CF-M32J8                                 
@echo 　　   5.Panasonic Let's note CF-S22J8                                 
@echo 　　   6.Panasonic Let's note CF-C33EJ8                                
@echo 　　   7.初期メニューへ                                                
@echo 　　                                                                   
@echo 　　              [1-7]を選択してください。                            
@echo 　　                                                                   
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=7 goto MENU
if errorlevel=6 goto PANA5
if errorlevel=5 goto PANA4
if errorlevel=4 goto PANA3
if errorlevel=3 goto PANA2
if errorlevel=2 goto PANA6
if errorlevel=1 goto PANA1

:SONY
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.SONY VAIO PCG-C1VJ,PCG-GT1    (USB FD)                       
@echo 　　   2.SONY VAIO PCG-C1XG            (USB FD)                       
@echo 　　   3.SONY VAIO PCG-C1XF,PCG-N505AS (USB FD)                       
@echo 　　   4.SONY VAIO PCG-C1,PCG-C1S      (USB FD)                       
@echo 　　   5.SONY VAIO PCG-505V/CBP                                       
@echo 　　   6.SONY VAIO PCG-505GX                                          
@echo 　　   7.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-7]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=7 goto MENU
if errorlevel=6 goto SONY2
if errorlevel=5 goto SONY4
if errorlevel=4 goto SONY3
if errorlevel=3 goto SONY1
if errorlevel=2 goto SONY5
if errorlevel=1 goto SONY6

:IBM
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.IBM ThinkPad 240,ThinkPad 240X,ThinkPad 240Z                 
@echo 　　   2.IBM ThinkPad X20                                             
@echo 　　   3.IBM ThinkPad X21                                             
@echo 　　   4.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-4]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=4 goto MENU
if errorlevel=3 goto IBM3
if errorlevel=2 goto IBM2
if errorlevel=1 goto IBM1

:SHARP
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.SHARP Mebius PC-PJ120H                                       
@echo 　　   2.SHARP Mebius PC-PJ2, PC-PJ2-X5                               
@echo 　　   3.SHARP Mebius PC-PJ140H                                       
@echo 　　   4.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-4]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=4 goto MENU
if errorlevel=3 goto SHARP3
if errorlevel=2 goto SHARP1
if errorlevel=1 goto SHARP2

:TOSHIBA
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.Toshiba Dynabook SS3480,SS3410,SS3440                        
@echo 　　                      ,Libretto ff1100,ff1100V                    
@echo 　　                      ,Libretto L1/060TNMM                        
@echo 　　   2.Toshiba Dynabook SS2000 DS7SP/2                              
@echo 　　                      ,Libretto L2/060TN2L                        
@echo 　　   3.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-3]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=3 goto MENU
if errorlevel=2 goto TOS2
if errorlevel=1 goto TOS1

:FUJITSU
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.FUJITSU FMV-BIBLO MCⅨ23                                     
@echo 　　   2.FUJITSU FMV-BIBLO MCⅧ23                                     
@echo 　　   3.FUJITSU FMV-BIBLO NCⅦ20                                     
@echo 　　   4.FUJITSU FMV-BIBLO MC4/45C                                    
@echo 　　   5.FUJITSU FMV-BIBLO LOOX S5/53                                 
@echo 　　   6.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-6]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=6 goto MENU
if errorlevel=5 goto FUJI5
if errorlevel=4 goto FUJI4
if errorlevel=3 goto FUJI3
if errorlevel=2 goto FUJI2
if errorlevel=1 goto FUJI1

:NEC
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   CD-ROM 起動ディスクを作成するパソコンを選択してください。      
@echo 　　                                                                  
@echo 　　   1.NEC LaVieNX LB400J/12D, LaVieNX LB40H/22D                    
@echo 　　   2.NEC LaVieNX LB26C/50AS1                                      
@echo 　　   3.初期メニューへ                                               
@echo 　　                                                                  
@echo 　　              [1-3]を選択してください。                           
@echo 　　                                                                  
@echo 　　
@echo.
@echo.
%FDD%:\f2h\input.exe
if errorlevel=3 goto MENU
if errorlevel=2 goto NEC2
if errorlevel=1 goto NEC1

goto END

Rem <---------------*****  Make Recovery Disk *****-------------------->
Rem ===== Panasonic  =======
:PANA1
CD S51j8
pana.bat
goto END

:PANA2
CD CFA1ER
pana.bat
goto END

:PANA3
CD CFM32
pana.bat
goto END

:PANA4
CD CFS22
pana.bat
goto END

:PANA5
CD CFC33E
pana.bat
goto END

:PANA6
CD CFS51V
pana.bat
goto END

Rem ===== SONY  ======
:SONY1
CD C1XF
SONY.bat
goto END

:SONY2
CD 505GX
SONY.bat
goto END

:SONY3
CD C1S
SONY.bat
goto END

:SONY4
CD 505V
SONY.bat
goto END

:SONY5
CD C1XG
SONY.bat
goto END

:SONY6
CD SR1CBP
SONY.bat
goto END

Rem ===== IBM  ========
:IBM1
CD TP240
IBM.bat
goto END

:IBM2
CD TPX20ME
IBM.bat
goto END

:IBM3
CD IBM3
IBM.bat
goto END

Rem ===== SHARP1  =======
:SHARP1
CD PJ2X5
SHARP.bat
goto END

:SHARP2
CD Pj120h
SHARP.bat
goto END

:SHARP3
CD SHARP3
SHARP.bat
goto END

Rem ===== TOSHIBA  ======
:TOS1
CD SS3410
TOSHIBA.bat
goto END

:TOS2
CD TOS2
TOSHIBA.bat
goto END

Rem ===== FUJITSU  ======
:FUJI1
CD MC923
FUJITSU.bat
goto END

:FUJI2
CD MC823
FUJITSU.bat
goto END

:FUJI3
CD NC720
FUJITSU.bat
goto END

:FUJI4
CD FUJI4
FUJITSU.bat
goto END

:FUJI5
CD FUJI5
FUJITSU.bat
goto END

Rem ===== NEC  ========
:NEC1
CD LB400J
NEC.bat
goto END

:NEC2
CD LB26C
NEC.bat
goto END

Rem ===== OTHER PC  =======
:OTHER
CD OTHER
OTHER.bat
goto END

:ERR
CLS
@echo.
@echo.
@echo 　　
@echo 　　                                                                  
@echo 　　   お使いのコンピュータではCD-ROM セットアップ起動ディスクの      
@echo 　　   作成プログラムメニューを実行できません。                       
@echo 　　   Readme.txtを参照してお使いのコンピュータに合った               
@echo 　　   プログラムを直接実行してください。                             
@echo 　　                                                                  
@echo 　　
@echo.
@echo.

:END
@echo.