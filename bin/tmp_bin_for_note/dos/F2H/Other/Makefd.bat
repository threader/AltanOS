echo oFF
:TOP
Rem ���ϐ����Z�b�g
Rem�iSYSDIR��Windows System Folder  �j
Rem�iFDSTAT��FDD Connect Type Status�j
  SET SYSDIR=
  SET FDSTAT=
cls
echo 
echo           ###  CD-ROM �N���f�B�X�N�쐬�v���O����  ###              
echo                                                                    
echo  CD-ROM �N���f�B�X�N���쐬���܂��B�ȉ��̂��̂�p�ӂ��Ă��������B   
echo  �uWindows 98 �N���f�B�X�N�v�̃R�s�[                               
echo      �܂��́uWindows Me �N���f�B�X�N�v�̃R�s�[                     
echo      �܂��́u�p�\�R����p�N���f�B�X�N�v�̃R�s�[                    
echo  �uCD-ROM �N���f�B�X�N�v�i�󂫃f�B�X�N�F�P���j                     
echo                                                                    
echo     �����ł��܂���      ������ [1]                                 
echo     �����ł��Ă��܂���  ������ [2]                                 
echo                                                                    
echo  [1],[2]��I�����Ă��������B                                       
ECHO 

Rem (1) �W���̏ꍇ�Awindir��PATH���Z�b�g�����
Rem (2) Makefd.bat�̌���Windows�t�H���_���w�肵�Ă���ꍇ�A%1��PATH���Z�b�g�����
Rem (3) PATH�������Z�b�g����Ă��Ȃ��ꍇ�AC:\Windows���Z�b�g����

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
echo  �t���b�s�[�f�B�X�N�h���C�u�͂t�r�a�ڑ��^�C�v�ł����H          
echo                                                                
echo     �͂��i�t�r�a�ڑ��j  ������� [1]                            
echo     �������i��p�ڑ��j  ������� [2]                            
echo                                                                
echo  [1],[2]��I�����Ă��������B                                   
echo 

Rem (1) USB�ڑ��^�C�vFDD�̏ꍇ�AFD Status �� USBFD ���Z�b�g�����B
Rem (2) ���K�V�[�^�C�vFDD�̏ꍇ�AFD Status �� LEGACY ���Z�b�g�����B

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
echo  �쐬����uCD-ROM �N���f�B�X�N�v�͎��̂ǂ���ł����H           
echo                                                                
echo     Windows 98�p  ����������������������������� [1]            
echo     Windows Me�p  ����������������������������� [2]            
echo     �p�\�R����p  ����������������������������� [3]            
echo     B's Recorder GOLD5 BASIC                                   
echo             [�N���p�t���b�s�[�f�B�X�N]��p ���� [4]            
echo                                                                
echo  [1],[2],[3],[4]��I�����Ă��������B                           
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
echo �uWindows Me �N���f�B�X�N�v�̃R�s�[�Ɍ������Ă��������B        
echo                                                                
echo  �����m�点                                                    
echo    �uWindows Me �N���f�B�X�N�v�̌��{�͎g�p���Ȃ��ł��������B   
echo                                                                
echo     �����ł��܂���      ������ [1]                             
echo     �����ł��Ă��܂���  ������ [2]                             
echo                                                                
echo  [1],[2]��I�����Ă��������B                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto MeWin02

:MeWin02
Rem WindowsMe�N���f�B�X�N�ł��邩�`�F�b�N
if not exist %FDD%:\Command.com goto MeWin01

Rem (1) Original File��BackUP
Rem (2) FD�󂫗e�ʊm�ۂ̈׃t�@�C�����폜
Rem (3) HDD����FD�փt�@�C�����R�s�[
cls
@echo �N���p�f�B�X�N�쐬��...

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
echo �uWindows 98 �N���f�B�X�N�v(�P����)�̃R�s�[�Ɍ������Ă��������B
echo                                                                
echo  �����m�点                                                    
echo    �uWindows 98 �N���f�B�X�N�v�̌��{�͎g�p���Ȃ��ł��������B   
echo                                                                
echo     �����ł��܂���      ������ [1]                             
echo     �����ł��Ă��܂���  ������ [2]                             
echo                                                                
echo  [1],[2]��I�����Ă��������B                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto 98Win02

:98Win02
Rem Windows98�N���f�B�X�N�ł��邩�`�F�b�N
if not exist %FDD%:\Command.com goto 98Win01

Rem (1) Original File��BackUP
Rem (2) FD�󂫗e�ʊm�ۂ̈׃t�@�C�����폜
Rem (3) HDD����FD�փt�@�C�����R�s�[
cls
@echo �N���p�f�B�X�N�쐬��...

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
echo �u�p�\�R����p�N���f�B�X�N�v�̃R�s�[�Ɍ������Ă��������B       
echo                                                                
echo  �����m�点                                                    
echo    �u�p�\�R����p�N���f�B�X�N�v�̌��{�͎g�p���Ȃ��ł��������B  
echo                                                                
echo     �����ł��܂���      ������ [1]                             
echo     �����ł��Ă��܂���  ������ [2]                             
echo                                                                
echo  [1],[2]��I�����Ă��������B                                   
echo 
input

if errorlevel 2 goto END
if errorlevel 1 goto PCoRG03

:PCoRG03
Rem �N���f�B�X�N�ł��邩�`�F�b�N
 if exist %FDD%:\Command.com goto DELDATA0
 @echo.
 @echo �N���f�B�X�N���}������Ă��܂���I
 @echo.
 goto PCoRG02

:DELDATA0
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem FD�󂫗e�ʊm�ۂ̈׃t�@�C�����폜
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
cls
@echo �N���p�f�B�X�N�쐬��...
:DELDATA1
Rem -----------------------------------------------------------------
Rem �N���f�B�X�N�̕s�v�t�@�C�����폜����ɂ́A�����ɒǉ�����B
Rem -----------------------------------------------------------------
 if not exist %FDD%:\aspi*.sys goto DELDATA2
   del %FDD%:\aspi*.sys >nul

:DELDATA2
 if not exist %SYSDIR%\command\deltree.exe goto DELDATA5
Rem -----------------------------------------------------------------
Rem �N���f�B�X�N�̕s�v�f�B���N�g�����폜����ɂ́A�����ɒǉ�����B
Rem -----------------------------------------------------------------
 if not exist %FDD%:\pccard\nul goto DELDATA5
   %SYSDIR%\command\deltree /y %FDD%:\pccard > nul
 if not exist %FDD%:\cdrom2\nul goto DELDATA5
   %SYSDIR%\command\deltree /y %FDD%:\cdrom2 > nul

:DELDATA5


Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem (1) config.sys ���^�[�Q�b�g�e�c�ɑ��݂���΁Aconfig.org ��
Rem     Rename ����B
Rem (2) config.org ���}���` config �����f����B
Rem (3) config.sys �̃T���v�����쐬���A�^�[�Q�b�g�e�c�ɃR�s�[����B
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
:CHKCoNF
Rem config.sys �����݂��Ȃ���΁ASample Config.sys �𗘗p����B
 if not exist %FDD%:\config.sys goto RNCoNF

Rem -----------------------------------------------------------------
Rem �������� config.sys �����݂���ꍇ�̏���...
Rem -----------------------------------------------------------------
 if not exist %FDD%:\config.org goto NoRGCoNF

Rem config.org ������΁A�ȑO�ɋN���f�B�X�N���쐬�����e�c�Ƃ݂Ȃ�
Rem ���݂� config.sys ���폜����B
     del %FDD%:\config.sys
     goto EoRGCoNF
:NoRGCoNF
Rem  Not exist ORiGinal CONFig.sys file.
   rename %FDD%:\config.sys *.org

:EoRGCoNF
Rem  Exist ORiGinal CONFig.sys file.
   copy %FDD%:\config.org c:\f2h /v >nul

Rem -----------------------------------------------------------------
Rem config.sys �̍쐬...
Rem -----------------------------------------------------------------
:EXISTDAT
Rem config.sys �����݂���ꍇ�̏����B
 if "%FDSTAT%" == "USBFD" goto USBCoNF

Rem Legacy-FDD �^�C�v�� config.sys ���쐬�B
   type c:\f2h\config.leg >> c:\f2h\config.org
   goto MKCoNF

:USBCoNF
Rem USB-FDD �^�C�v�� config.sys ���쐬�B
   type c:\f2h\config.usb >> c:\f2h\config.org
   goto MKCoNF

:MKCoNF
   copy c:\f2h\config.org %FDD%:\config.sys /v >nul
   goto CHKAUTo

:RNCoNF
Rem config.sys �����݂��Ȃ��ꍇ�̏����B
 if "%FDSTAT%" == "USBFD" goto USBSAMP
Rem config.sys �������ꍇ�̃T���v�� config.sys �iLegacy-FDD �^�C�v�j
   copy c:\f2h\config.sam %FDD%:\config.sys /v >nul
   goto CHKAUTo
   
:USBSAMP
Rem config.sys �������ꍇ�̃T���v�� config.sys �iUSB-FDD �^�C�v�j
   copy c:\f2h\config.sau %FDD%:\config.sys /v >nul
   goto CHKAUTo

Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rem (1) autoexec.bat ���^�[�Q�b�g�e�c�ɑ��݂���΁Aautoexec.org ��
Rem     Rename ����B
Rem (2) autoexec.bat �̃T���v�����쐬���A�^�[�Q�b�g�e�c�ɃR�s�[����B
Rem =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
:CHKAUTo
 if not exist %FDD%:\autoexec.bat goto RNAUTo
Rem autoexec.org ������΁A�ȑO�ɋN���f�B�X�N���쐬�����e�c�Ƃ݂Ȃ��B
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
Rem �f�o�C�X�h���C�o�[�̃R�s�[�B
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
echo �uCD-ROM �N���f�B�X�N�v�̍쐬���I�����܂����B                  
echo                                                                
echo  �CD-ROM �N���f�B�X�N� ������ɓ��삷�邱�Ƃ��m�F���Ă��������B
echo                                                                
echo  ���m�点�F                                                    
echo    �p�\�R���ɂ���ẮACD-ROM �h���C�u���w��̃h���C�u�Ƃ���   
echo    �F�������Ȃ���΁A�V�X�e���̍ăC���X�g�[�����ł��Ȃ����̂�  
echo    ����܂��B                                                  
echo    ���̏ꍇ�́A�p�\�R���t���̐��������Q�l��CD-ROM �N���f�B�X�N 
echo    �� AUTOEXEC.BAT �t�@�C�����G�f�B�^�ŊJ���āAMSCDEX.EXE �s�� 
echo    /L: �I�v�V������ύX���Ă��������B                          
echo                                                                
echo 
pause
goto END


Rem ===== Error Messages =============================================
:ERR1
@echo.
@echo ==============================================================
@echo HIMEM.SYS ��������Ȃ����R�s�[�ł��܂���I
@echo �p�\�R���̒����� HIMEM.SYS �� MSCDEX.EXE ���������A
@echo CD-ROM �N���f�B�X�N�ɃR�s�[���Ă��������B
@echo ==============================================================
pause
goto END

:ERR2
@echo.
@echo ==============================================================
@echo MSCDEX.EXE ��������Ȃ����R�s�[�ł��܂���I
@echo  �CD-ROM �N���f�B�X�N� �Ńp�\�R�����N�����ACD-ROM �h���C�u��
@echo �F������Ȃ��ꍇ�́A���̂����ꂩ�̑Ώ��������Ȃ��Ă��������B
@echo.
@echo  (1) �p�\�R���̒����� MSCDEX.EXE ���������A
@echo      CD-ROM �N���f�B�X�N�ɃR�s�[���Ă��������B
@echo  (2) CD-ROM �N���f�B�X�N�� AUTOEXEC.BAT �t�@�C�����G�f�B�^��
@echo      �J���āAMSCDEX.EXE �s�� PATH �s�̌��ֈړ����Ă��������B
@echo  (3) CD-ROM �N���f�B�X�N�� AUTOEXEC.BAT �t�@�C�����G�f�B�^��
@echo      �N�����AMSCDEX.EXE �s�� MSCDEX.EXE �̑��݂���f�B���N�g��
@echo      �� PATH ���Ƃ����Ă��������B
@echo      �i��FA:\DOS\MSCDEX.EXE /D:USBCD001 /L:Q �j
@echo.
@echo ==============================================================
pause
goto END

:ERR3
 goto END

:END
 set FDSTAT=
 set SYSDIR=