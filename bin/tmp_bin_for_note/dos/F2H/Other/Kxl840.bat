REM *** OTHER ****
ECHO OFF
Rem ���ϐ��̒l���N���A
SET FILEDAT=
rem SET FDD=A

CLS
ECHO 
ECHO                                                                 
ECHO         ###  CD-ROM �N���f�B�X�N�쐬�����v���O����  ###         
ECHO                                                                 
ECHO               (C) Panasonic Communications Co., Ltd. 2000-2003  
ECHO ----------------------------------------------------------------
ECHO  �� ���̃v���O�����́ACD-ROM �N���f�B�X�N�쐬�̏��������܂��B   
ECHO 
@echo.
@echo.
PAUSE

Rem F2H�f�[�^�@���@�n�[�h�f�B�X�N
@echo �N���p�f�B�X�N�쐬�̏�����...
REM COPY %FDD%:README.TXT C:\F2H /V >nul

COPY %FDD%:AUTOEXEC.SAM C:\F2H /V >nul

COPY %FDD%:CONFIG.Me1   C:\F2H /V >nul
COPY %FDD%:CONFIG.Me2   C:\F2H /V >nul
COPY %FDD%:CONFIG.SAM   C:\F2H /V >nul
COPY %FDD%:CONFIG.SAU   C:\F2H /V >nul
COPY %FDD%:CONFIG.LEG   C:\F2H /V >nul
COPY %FDD%:CONFIG.USB   C:\F2H /V >nul

COPY %FDD%:MAKEFD.*   C:\F2H\MAKEFD.* /V >nul

Rem CD-ROM �h���C�o�@���@�n�[�h�f�B�X�N
SET FILEDAT=NOSETUP

:FILECHK
IF NOT EXIST %FDD%:\F2H\usbaspi.sys GOTO  ERR01
IF NOT EXIST %FDD%:\f2h\usbcd.sys GOTO ERR01
IF NOT EXIST %FDD%:\f2h\ramfd.sys GOTO ERR01

COPY %FDD%:\F2H\usbaspi.sys    C:\F2H /V >nul
COPY %FDD%:\f2h\usbcd.sys   C:\F2H /V >nul
COPY %FDD%:\f2h\ramfd.sys   C:\F2H /V >nul

C:
CD \F2H

Rem ���ϐ��̒l���N���A
SET FILEDAT=

MAKEFD.BAT
Rem �����ŏI���A�ǂ��ɂ��W�����v���Ȃ��B

:ERR01
IF NOT "%FILEDAT%" == "NOSETUP" GOTO ERR02
CLS
@ECHO.
@echo �@�@
@echo �@�@                                                                  
@echo �@�@   �t���b�s�[�f�B�X�N�h���C�u�̃f�B�X�N��                         
@echo �@�@   �{�@�t���́u�Z�b�g�A�b�v�f�B�X�N�v�֌������Ă��������D         
@echo �@�@                                                                  
@echo �@�@
@echo.
@echo.
@ECHO OFF
PAUSE
SET FILEDAT=SETUPDSK
GOTO FILECHK

:ERR02
ECHO ***  �K�v�ȃt�@�C����������܂���B        ***
ECHO ***  �Z�b�g�A�b�v�f�B�X�N�𐳂����Z�b�g����  ***
ECHO ***            �ŏ������蒼���Ă��������B  ***
ECHO.
GOTO END

:END
Rem ���ϐ��̒l���N���A
SET FILEDAT=

