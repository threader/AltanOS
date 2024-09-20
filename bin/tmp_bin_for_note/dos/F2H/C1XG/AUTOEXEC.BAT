@echo off
set path=A:\;A:\DOS;Q:\SONY
REM œœ MSCDEX.EXE ‚Ìs‚ð‰Á‚¦‚Ä‚­‚¾‚³‚¢ œœ
mscdex.exe /d:usbcd /l:q
cd \SONY
INSTALL4.EXE
