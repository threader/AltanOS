REM
REM --- Panasonic USB Drive ---
REM
:L1
BMPVIEW %TEMP%\BMP\MESDRI.bmp /X=120 /Y=160
PAUSE > NUL
FDCHK.COM
IF ERRORLEVEL 1 GOTO L1
if not EXIST a:\f2h\USBASPI.SYS goto L1
if not EXIST a:\f2h\USBCD.SYS goto L1

copy a:\F2H\USB*.sys c:\ /Y > NUL
